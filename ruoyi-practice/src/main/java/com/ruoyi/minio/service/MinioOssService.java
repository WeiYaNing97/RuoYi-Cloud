package com.ruoyi.minio.service;

import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;

public interface MinioOssService {
    void deleteByFilePath(String filePath);

    String uploadFile(MultipartFile file);

    String getFileStatusInfo(String filePath);

    String getPresignedObjectUrl(String filePath);

    void downloadFile(String filePath, HttpServletResponse response);
}
