package com.ruoyi.minio.controller;

import com.ruoyi.common.core.web.domain.AjaxResult;
import com.ruoyi.minio.service.MinioOssService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;

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
    private MinioOssService minioOssService;


    /**
     * 文件上传
     *
     * @param file
     */
    @PostMapping("/upload")
    public AjaxResult upload(MultipartFile file, boolean updateSupport) {
        String filePath = minioOssService.uploadFile(file);
        if (filePath.equals("上传失败"))
            return AjaxResult.error("上传失败");
        return AjaxResult.success(filePath);
    }

    /**
     * 删除
     *
     * @param fileName
     */
    @DeleteMapping("/")
    public void delete(@RequestParam("fileName") String fileName) {
        minioOssService.deleteByFilePath(fileName);
    }

    /**
     * 获取文件信息
     *
     * @param fileName
     * @return
     */
    @GetMapping("/info")
    public String getFileStatusInfo(@RequestParam("fileName") String fileName) {
        return minioOssService.getFileStatusInfo(fileName);
    }

    /**
     * 获取文件外链
     *
     * @param fileName
     * @return
     */
    @GetMapping("/url")
    public String getPresignedObjectUrl(@RequestParam("fileName") String fileName) {
        return minioOssService.getPresignedObjectUrl(fileName);
    }

    /**
     * 文件下载
     *
     * @param fileName
     * @param response
     */
    @GetMapping("/download")
    public void download(@RequestParam("fileName") String fileName, HttpServletResponse response) {
        minioOssService.downloadFile(fileName, response);
    }
}
