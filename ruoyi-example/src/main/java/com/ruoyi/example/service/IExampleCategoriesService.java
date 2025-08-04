package com.ruoyi.example.service;

import java.util.List;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ruoyi.example.domain.ExampleCategories;

/**
 * 存储商品类别的信息Service接口
 * 
 * @author ruoyi
 * @date 2025-07-27
 */
public interface IExampleCategoriesService extends IService<ExampleCategories>
{
    /**
     * 查询存储商品类别的信息
     * 
     * @param exampleId 存储商品类别的信息主键
     * @return 存储商品类别的信息
     */
    public ExampleCategories selectExampleCategoriesByExampleId(Long exampleId);

    /**
     * 查询存储商品类别的信息列表
     * 
     * @param exampleCategories 存储商品类别的信息
     * @return 存储商品类别的信息集合
     */
    public List<ExampleCategories> selectExampleCategoriesList(ExampleCategories exampleCategories);

    /**
     * 新增存储商品类别的信息
     * 
     * @param exampleCategories 存储商品类别的信息
     * @return 结果
     */
    public int insertExampleCategories(ExampleCategories exampleCategories);

    /**
     * 修改存储商品类别的信息
     * 
     * @param exampleCategories 存储商品类别的信息
     * @return 结果
     */
    public int updateExampleCategories(ExampleCategories exampleCategories);

    /**
     * 批量删除存储商品类别的信息
     * 
     * @param exampleIds 需要删除的存储商品类别的信息主键集合
     * @return 结果
     */
    public int deleteExampleCategoriesByExampleIds(Long[] exampleIds);

    /**
     * 删除存储商品类别的信息信息
     * 
     * @param exampleId 存储商品类别的信息主键
     * @return 结果
     */
    public int deleteExampleCategoriesByExampleId(Long exampleId);
}
