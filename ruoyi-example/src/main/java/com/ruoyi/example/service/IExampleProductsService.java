package com.ruoyi.example.service;

import java.util.List;
import com.ruoyi.example.domain.ExampleProducts;

/**
 * 存储商品的信息Service接口
 * 
 * @author ruoyi
 * @date 2025-07-27
 */
public interface IExampleProductsService 
{
    /**
     * 查询存储商品的信息
     * 
     * @param exampleId 存储商品的信息主键
     * @return 存储商品的信息
     */
    public ExampleProducts selectExampleProductsByExampleId(Long exampleId);

    /**
     * 查询存储商品的信息列表
     * 
     * @param exampleProducts 存储商品的信息
     * @return 存储商品的信息集合
     */
    public List<ExampleProducts> selectExampleProductsList(ExampleProducts exampleProducts);

    /**
     * 新增存储商品的信息
     * 
     * @param exampleProducts 存储商品的信息
     * @return 结果
     */
    public int insertExampleProducts(ExampleProducts exampleProducts);

    /**
     * 修改存储商品的信息
     * 
     * @param exampleProducts 存储商品的信息
     * @return 结果
     */
    public int updateExampleProducts(ExampleProducts exampleProducts);

    /**
     * 批量删除存储商品的信息
     * 
     * @param exampleIds 需要删除的存储商品的信息主键集合
     * @return 结果
     */
    public int deleteExampleProductsByExampleIds(Long[] exampleIds);

    /**
     * 删除存储商品的信息信息
     * 
     * @param exampleId 存储商品的信息主键
     * @return 结果
     */
    public int deleteExampleProductsByExampleId(Long exampleId);
}
