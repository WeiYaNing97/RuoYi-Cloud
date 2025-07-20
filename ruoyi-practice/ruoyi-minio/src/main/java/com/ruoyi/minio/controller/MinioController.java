package com.ruoyi.minio.controller;

import com.ruoyi.common.core.utils.StringUtils;
import com.ruoyi.common.core.web.domain.AjaxResult;
import com.ruoyi.common.security.utils.SecurityUtils;
import com.ruoyi.minio.config.MyMinioConfig;
import com.ruoyi.minio.domain.MinioRecord;
import com.ruoyi.minio.service.IMinioRecordService;
import com.ruoyi.minio.utils.MyMinioUtils;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.compress.utils.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.InputStream;

/**
 * @program: xxkfz-minio
 * @ClassName OSSController.java
 * @author: wust
 * @create: 2024-03-13 11:01
 * @description:
 **/
@Slf4j
@RestController
@RequestMapping("/oss")
public class MinioController {

    @Autowired
    private MyMinioUtils minioUtils;

    @Autowired
    private MyMinioConfig minioConfig;

    @Autowired
    private IMinioRecordService minioRecordService;

    /**
     * 文件上传
     *
     * @param file
     */
    @PostMapping("/upload")
    public AjaxResult upload(MultipartFile file, boolean updateSupport) {
        try {
            //文件名
            String fileName = file.getOriginalFilename();
            //String newFileName = System.currentTimeMillis() + "." + StringUtils.substringAfterLast(fileName, ".");

            String newFileName = StringUtils.substringBeforeLast(fileName, ".")+System.currentTimeMillis() + "." + StringUtils.substringAfterLast(fileName, ".");
            //类型
            String contentType = file.getContentType();
            minioUtils.uploadFile(minioConfig.getBucketName(), file, newFileName, contentType);


            MinioRecord minioRecord = new MinioRecord();
            minioRecord.setFileName(newFileName);
            minioRecord.setFilePath(newFileName);
            minioRecord.setCreateBy(SecurityUtils.getUsername());
            minioRecord.setId(2l);
            minioRecordService.insertMinioRecord(minioRecord);
            return AjaxResult.success("上传成功");
        } catch (Exception e) {
            e.printStackTrace();
            return AjaxResult.error("上传失败");
        }
    }

    /**
     * 删除
     *
     * @param fileName
     */
    @DeleteMapping("/")
    public void delete(@RequestParam("fileName") String fileName) {
        minioUtils.removeFile(minioConfig.getBucketName(), fileName);
    }

    /**
     * 获取文件信息
     *
     * @param fileName
     * @return
     */
    @GetMapping("/info")
    public String getFileStatusInfo(@RequestParam("fileName") String fileName) {
        return minioUtils.getFileStatusInfo(minioConfig.getBucketName(), fileName);
    }

    /**
     * 获取文件外链
     *
     * @param fileName
     * @return
     */
    @GetMapping("/url")
    public String getPresignedObjectUrl(@RequestParam("fileName") String fileName) {
        return minioUtils.getPresignedObjectUrl(minioConfig.getBucketName(), fileName);
    }

    /**
     * 文件下载
     *
     * @param fileName
     * @param response
     */
    @GetMapping("/download")
    public void download(@RequestParam("fileName") String fileName, HttpServletResponse response) {
        try {
            InputStream fileInputStream = minioUtils.getObject(minioConfig.getBucketName(), fileName);
            response.setHeader("Content-Disposition", "attachment;filename=" + fileName);
            response.setContentType("application/force-download");
            response.setCharacterEncoding("UTF-8");
            IOUtils.copy(fileInputStream, response.getOutputStream());
        } catch (Exception e) {
            log.error("下载失败");
        }
    }
}
