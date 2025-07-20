package com.ruoyi.minio.service;

import java.util.List;
import com.ruoyi.minio.domain.PracticeMinio;

/**
 * minio操作记录Service接口
 * 
 * @author ruoyi
 * @date 2025-07-20
 */
public interface IPracticeMinioService 
{
    /**
     * 查询minio操作记录
     * 
     * @param id minio操作记录主键
     * @return minio操作记录
     */
    public PracticeMinio selectPracticeMinioById(Long id);

    /**
     * 查询minio操作记录列表
     * 
     * @param practiceMinio minio操作记录
     * @return minio操作记录集合
     */
    public List<PracticeMinio> selectPracticeMinioList(PracticeMinio practiceMinio);

    /**
     * 新增minio操作记录
     * 
     * @param practiceMinio minio操作记录
     * @return 结果
     */
    public int insertPracticeMinio(PracticeMinio practiceMinio);

    /**
     * 修改minio操作记录
     * 
     * @param practiceMinio minio操作记录
     * @return 结果
     */
    public int updatePracticeMinio(PracticeMinio practiceMinio);

    /**
     * 批量删除minio操作记录
     * 
     * @param ids 需要删除的minio操作记录主键集合
     * @return 结果
     */
    public int deletePracticeMinioByIds(Long[] ids);

    /**
     * 删除minio操作记录信息
     * 
     * @param id minio操作记录主键
     * @return 结果
     */
    public int deletePracticeMinioById(Long id);
}
