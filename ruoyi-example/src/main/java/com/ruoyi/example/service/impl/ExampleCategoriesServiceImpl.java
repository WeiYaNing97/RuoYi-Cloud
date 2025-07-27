package com.ruoyi.example.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.example.mapper.ExampleCategoriesMapper;
import com.ruoyi.example.domain.ExampleCategories;
import com.ruoyi.example.service.IExampleCategoriesService;

/**
 * 存储商品类别的信息Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-07-27
 */
@Service
public class ExampleCategoriesServiceImpl implements IExampleCategoriesService 
{
    @Autowired
    private ExampleCategoriesMapper exampleCategoriesMapper;

    /**
     * 查询存储商品类别的信息
     * 
     * @param exampleId 存储商品类别的信息主键
     * @return 存储商品类别的信息
     */
    @Override
    public ExampleCategories selectExampleCategoriesByExampleId(Long exampleId)
    {
        return exampleCategoriesMapper.selectExampleCategoriesByExampleId(exampleId);
    }

    /**
     * 查询存储商品类别的信息列表
     * 
     * @param exampleCategories 存储商品类别的信息
     * @return 存储商品类别的信息
     */
    @Override
    public List<ExampleCategories> selectExampleCategoriesList(ExampleCategories exampleCategories)
    {
        return exampleCategoriesMapper.selectExampleCategoriesList(exampleCategories);
    }

    /**
     * 新增存储商品类别的信息
     * 
     * @param exampleCategories 存储商品类别的信息
     * @return 结果
     */
    @Override
    public int insertExampleCategories(ExampleCategories exampleCategories)
    {
        return exampleCategoriesMapper.insertExampleCategories(exampleCategories);
    }

    /**
     * 修改存储商品类别的信息
     * 
     * @param exampleCategories 存储商品类别的信息
     * @return 结果
     */
    @Override
    public int updateExampleCategories(ExampleCategories exampleCategories)
    {
        return exampleCategoriesMapper.updateExampleCategories(exampleCategories);
    }

    /**
     * 批量删除存储商品类别的信息
     * 
     * @param exampleIds 需要删除的存储商品类别的信息主键
     * @return 结果
     */
    @Override
    public int deleteExampleCategoriesByExampleIds(Long[] exampleIds)
    {
        return exampleCategoriesMapper.deleteExampleCategoriesByExampleIds(exampleIds);
    }

    /**
     * 删除存储商品类别的信息信息
     * 
     * @param exampleId 存储商品类别的信息主键
     * @return 结果
     */
    @Override
    public int deleteExampleCategoriesByExampleId(Long exampleId)
    {
        return exampleCategoriesMapper.deleteExampleCategoriesByExampleId(exampleId);
    }
}
