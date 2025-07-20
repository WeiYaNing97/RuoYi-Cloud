package com.ruoyi.minio.mapper;

import java.util.List;
import com.ruoyi.minio.domain.MinioRecord;

/**
 * minio操作记录Mapper接口
 * 
 * @author ruoyi
 * @date 2025-07-20
 */
public interface MinioRecordMapper 
{
    /**
     * 查询minio操作记录
     * 
     * @param id minio操作记录主键
     * @return minio操作记录
     */
    public MinioRecord selectMinioRecordById(Long id);

    /**
     * 查询minio操作记录列表
     * 
     * @param minioRecord minio操作记录
     * @return minio操作记录集合
     */
    public List<MinioRecord> selectMinioRecordList(MinioRecord minioRecord);

    /**
     * 新增minio操作记录
     * 
     * @param minioRecord minio操作记录
     * @return 结果
     */
    public int insertMinioRecord(MinioRecord minioRecord);

    /**
     * 修改minio操作记录
     * 
     * @param minioRecord minio操作记录
     * @return 结果
     */
    public int updateMinioRecord(MinioRecord minioRecord);

    /**
     * 删除minio操作记录
     * 
     * @param id minio操作记录主键
     * @return 结果
     */
    public int deleteMinioRecordById(Long id);

    /**
     * 批量删除minio操作记录
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteMinioRecordByIds(Long[] ids);
}
