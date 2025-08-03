package com.ruoyi.minio.service.impl;

import com.ruoyi.common.core.utils.DateUtils;
import com.ruoyi.minio.domain.MinioRecord;
import com.ruoyi.minio.mapper.MinioRecordMapper;
import com.ruoyi.minio.service.IMinioRecordService;
import com.ruoyi.minio.utils.MyMinioUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * minio操作记录Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-07-21
 */
@Service
public class MinioRecordServiceImpl implements IMinioRecordService 
{
    @Resource
    private MyMinioUtils minioUtils;
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
        // 根据id数组查询出对应的MinioRecord对象列表
        List<MinioRecord> pojoList = minioRecordMapper.selectMinioRecordByIds(ids);

        // 遍历对象列表，对每一个MinioRecord对象调用minioUtils的removeFile方法删除文件
        pojoList.stream().forEach(x -> minioUtils.removeFile(x.getFilePath()));

        // 根据id数组批量删除MinioRecord记录
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
        // 根据主键查询minio操作记录
        MinioRecord minioRecord = minioRecordMapper.selectMinioRecordById(id);
        // 删除minio操作记录对应的文件
        minioUtils.removeFile(minioRecord.getFilePath());
        // 删除minio操作记录
        return minioRecordMapper.deleteMinioRecordById(id);
    }

}
