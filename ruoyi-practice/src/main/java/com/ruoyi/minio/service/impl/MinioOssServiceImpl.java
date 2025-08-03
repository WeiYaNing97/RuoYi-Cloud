package com.ruoyi.minio.service.impl;

import com.ruoyi.common.core.utils.StringUtils;
import com.ruoyi.common.security.utils.SecurityUtils;
import com.ruoyi.minio.config.MyMinioConfig;
import com.ruoyi.minio.domain.MinioRecord;
import com.ruoyi.minio.service.IMinioRecordService;
import com.ruoyi.minio.service.MinioOssService;
import com.ruoyi.minio.utils.MyMinioUtils;
import io.minio.ObjectWriteResponse;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.compress.utils.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.InputStream;
@Slf4j
@Service
public class MinioOssServiceImpl implements MinioOssService {
    /**
     * 访问地址
     */
    @Value("${minio.endpoint}")
    private String endpoint;

    @Autowired
    private MyMinioUtils minioUtils;

    @Autowired
    private MyMinioConfig minioConfig;

    @Autowired
    private IMinioRecordService minioRecordService;


    @Override
    public void deleteByFilePath(String filePath) {
        minioUtils.removeFile(/*minioConfig.getBucketName(), */filePath);
    }

    /**
     * 上传文件
     *
     * @param file 上传的文件
     * @return 上传文件的URL地址，如果上传失败则返回"上传失败"
     * @throws Exception 如果上传过程中发生异常，则抛出异常
     */
    @Override
    public String uploadFile(MultipartFile file) {
        try {
            // 文件名
            String fileName = file.getOriginalFilename();
            // 修改后的文件名，包含时间戳以防止重名
            //String newFileName = System.currentTimeMillis() + "." + StringUtils.substringAfterLast(fileName, ".");

            // 使用时间戳重新命名文件，保留原文件扩展名
            String newFileName = StringUtils.substringBeforeLast(fileName, ".") + System.currentTimeMillis() + "." + StringUtils.substringAfterLast(fileName, ".");
            // 类型
            String contentType = file.getContentType();
            // 上传文件到MinIO服务器
            ObjectWriteResponse objectWriteResponse = minioUtils.uploadFile(minioConfig.getBucketName(), file, newFileName, contentType);

            // 创建MinioRecord对象，记录文件信息
            MinioRecord minioRecord = new MinioRecord();
            minioRecord.setFileName(newFileName);
            // 构造文件访问路径
            minioRecord.setFilePath(endpoint + "/" + objectWriteResponse.bucket() + "/" + newFileName);
            minioRecord.setCreateBy(SecurityUtils.getUsername());
            // 将文件信息保存到数据库
            minioRecordService.insertMinioRecord(minioRecord);
            // 返回文件访问路径
            return endpoint + "/" + objectWriteResponse.bucket() + "/" + newFileName;
        } catch (Exception e) {
            // 打印异常堆栈信息
            e.printStackTrace();
            // 上传失败，返回失败信息
            return "上传失败";
        }
    }


    /**
     * 获取指定路径文件的状态信息。
     *
     * @param filePath 文件路径
     * @return 文件状态信息字符串
     */
    @Override
    public String getFileStatusInfo(String filePath) {
        // 调用 MinioUtils 类的 getFileStatusInfo 方法获取文件状态信息
        // 参数为 Minio 配置中的桶名称和文件路径
        return minioUtils.getFileStatusInfo(minioConfig.getBucketName(), filePath);
    }


    /**
     * 获取预签名对象URL
     *
     * @param filePath 文件路径
     * @return 预签名对象URL
     */
    @Override
    public String getPresignedObjectUrl(String filePath) {
        return minioUtils.getPresignedObjectUrl(minioConfig.getBucketName(), filePath);
    }

    /**
     * 下载文件
     *
     * @param filePath 文件路径
     * @param response HttpServletResponse对象
     * @throws Exception 抛出异常
     */
    @Override
    public void downloadFile(String filePath, HttpServletResponse response) {
        try {
            // 获取文件输入流
            InputStream fileInputStream = minioUtils.getObject(minioConfig.getBucketName(), filePath);

            // 设置响应头，表示这是一个文件下载
            response.setHeader("Content-Disposition", "attachment;filename=" + filePath);

            // 设置响应的内容类型为强制下载
            response.setContentType("application/force-download");

            // 设置响应的字符编码为UTF-8
            response.setCharacterEncoding("UTF-8");

            // 将文件输入流复制到响应的输出流中
            IOUtils.copy(fileInputStream, response.getOutputStream());
        } catch (Exception e) {
            // 打印错误日志
            log.error("下载失败");
        }
    }

}
