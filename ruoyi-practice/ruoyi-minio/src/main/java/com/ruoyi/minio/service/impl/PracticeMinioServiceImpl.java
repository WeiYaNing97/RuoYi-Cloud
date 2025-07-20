package com.ruoyi.minio.service.impl;

import java.util.List;
import com.ruoyi.common.core.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.minio.mapper.PracticeMinioMapper;
import com.ruoyi.minio.domain.PracticeMinio;
import com.ruoyi.minio.service.IPracticeMinioService;

/**
 * minio操作记录Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-07-20
 */
@Service
public class PracticeMinioServiceImpl implements IPracticeMinioService 
{
    @Autowired
    private PracticeMinioMapper practiceMinioMapper;

    /**
     * 查询minio操作记录
     * 
     * @param id minio操作记录主键
     * @return minio操作记录
     */
    @Override
    public PracticeMinio selectPracticeMinioById(Long id)
    {
        return practiceMinioMapper.selectPracticeMinioById(id);
    }

    /**
     * 查询minio操作记录列表
     * 
     * @param practiceMinio minio操作记录
     * @return minio操作记录
     */
    @Override
    public List<PracticeMinio> selectPracticeMinioList(PracticeMinio practiceMinio)
    {
        return practiceMinioMapper.selectPracticeMinioList(practiceMinio);
    }

    /**
     * 新增minio操作记录
     * 
     * @param practiceMinio minio操作记录
     * @return 结果
     */
    @Override
    public int insertPracticeMinio(PracticeMinio practiceMinio)
    {
        practiceMinio.setCreateTime(DateUtils.getNowDate());
        return practiceMinioMapper.insertPracticeMinio(practiceMinio);
    }

    /**
     * 修改minio操作记录
     * 
     * @param practiceMinio minio操作记录
     * @return 结果
     */
    @Override
    public int updatePracticeMinio(PracticeMinio practiceMinio)
    {
        practiceMinio.setUpdateTime(DateUtils.getNowDate());
        return practiceMinioMapper.updatePracticeMinio(practiceMinio);
    }

    /**
     * 批量删除minio操作记录
     * 
     * @param ids 需要删除的minio操作记录主键
     * @return 结果
     */
    @Override
    public int deletePracticeMinioByIds(Long[] ids)
    {
        return practiceMinioMapper.deletePracticeMinioByIds(ids);
    }

    /**
     * 删除minio操作记录信息
     * 
     * @param id minio操作记录主键
     * @return 结果
     */
    @Override
    public int deletePracticeMinioById(Long id)
    {
        return practiceMinioMapper.deletePracticeMinioById(id);
    }
}
