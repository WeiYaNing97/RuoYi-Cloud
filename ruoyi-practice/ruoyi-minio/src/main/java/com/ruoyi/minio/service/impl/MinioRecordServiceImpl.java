package com.ruoyi.minio.service.impl;

import java.util.List;
import com.ruoyi.common.core.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.minio.mapper.MinioRecordMapper;
import com.ruoyi.minio.domain.MinioRecord;
import com.ruoyi.minio.service.IMinioRecordService;

/**
 * minio操作记录Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-07-20
 */
@Service
public class MinioRecordServiceImpl implements IMinioRecordService 
{
    @Autowired
    private MinioRecordMapper minioRecordMapper;

    /**
     * 查询minio操作记录
     * 
     * @param id minio操作记录主键
     * @return minio操作记录
     */
    @Override
    public MinioRecord selectMinioRecordById(Long id)
    {
        return minioRecordMapper.selectMinioRecordById(id);
    }

    /**
     * 查询minio操作记录列表
     * 
     * @param minioRecord minio操作记录
     * @return minio操作记录
     */
    @Override
    public List<MinioRecord> selectMinioRecordList(MinioRecord minioRecord)
    {
        return minioRecordMapper.selectMinioRecordList(minioRecord);
    }

    /**
     * 新增minio操作记录
     * 
     * @param minioRecord minio操作记录
     * @return 结果
     */
    @Override
    public int insertMinioRecord(MinioRecord minioRecord)
    {
        minioRecord.setCreateTime(DateUtils.getNowDate());
        return minioRecordMapper.insertMinioRecord(minioRecord);
    }

    /**
     * 修改minio操作记录
     * 
     * @param minioRecord minio操作记录
     * @return 结果
     */
    @Override
    public int updateMinioRecord(MinioRecord minioRecord)
    {
        minioRecord.setUpdateTime(DateUtils.getNowDate());
        return minioRecordMapper.updateMinioRecord(minioRecord);
    }

    /**
     * 批量删除minio操作记录
     * 
     * @param ids 需要删除的minio操作记录主键
     * @return 结果
     */
    @Override
    public int deleteMinioRecordByIds(Long[] ids)
    {
        return minioRecordMapper.deleteMinioRecordByIds(ids);
    }

    /**
     * 删除minio操作记录信息
     * 
     * @param id minio操作记录主键
     * @return 结果
     */
    @Override
    public int deleteMinioRecordById(Long id)
    {
        return minioRecordMapper.deleteMinioRecordById(id);
    }
}
