package com.ruoyi.minio.mapper;

import java.util.List;
import com.ruoyi.minio.domain.PracticeMinio;

/**
 * minio操作记录Mapper接口
 * 
 * @author ruoyi
 * @date 2025-07-20
 */
public interface PracticeMinioMapper 
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
     * 删除minio操作记录
     * 
     * @param id minio操作记录主键
     * @return 结果
     */
    public int deletePracticeMinioById(Long id);

    /**
     * 批量删除minio操作记录
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deletePracticeMinioByIds(Long[] ids);
}
