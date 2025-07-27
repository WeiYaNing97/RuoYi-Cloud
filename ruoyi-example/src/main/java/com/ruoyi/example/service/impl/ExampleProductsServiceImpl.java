package com.ruoyi.example.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.example.mapper.ExampleProductsMapper;
import com.ruoyi.example.domain.ExampleProducts;
import com.ruoyi.example.service.IExampleProductsService;

/**
 * 存储商品的信息Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-07-27
 */
@Service
public class ExampleProductsServiceImpl implements IExampleProductsService 
{
    @Autowired
    private ExampleProductsMapper exampleProductsMapper;

    /**
     * 查询存储商品的信息
     * 
     * @param exampleId 存储商品的信息主键
     * @return 存储商品的信息
     */
    @Override
    public ExampleProducts selectExampleProductsByExampleId(Long exampleId)
    {
        return exampleProductsMapper.selectExampleProductsByExampleId(exampleId);
    }

    /**
     * 查询存储商品的信息列表
     * 
     * @param exampleProducts 存储商品的信息
     * @return 存储商品的信息
     */
    @Override
    public List<ExampleProducts> selectExampleProductsList(ExampleProducts exampleProducts)
    {
        return exampleProductsMapper.selectExampleProductsList(exampleProducts);
    }

    /**
     * 新增存储商品的信息
     * 
     * @param exampleProducts 存储商品的信息
     * @return 结果
     */
    @Override
    public int insertExampleProducts(ExampleProducts exampleProducts)
    {
        return exampleProductsMapper.insertExampleProducts(exampleProducts);
    }

    /**
     * 修改存储商品的信息
     * 
     * @param exampleProducts 存储商品的信息
     * @return 结果
     */
    @Override
    public int updateExampleProducts(ExampleProducts exampleProducts)
    {
        return exampleProductsMapper.updateExampleProducts(exampleProducts);
    }

    /**
     * 批量删除存储商品的信息
     * 
     * @param exampleIds 需要删除的存储商品的信息主键
     * @return 结果
     */
    @Override
    public int deleteExampleProductsByExampleIds(Long[] exampleIds)
    {
        return exampleProductsMapper.deleteExampleProductsByExampleIds(exampleIds);
    }

    /**
     * 删除存储商品的信息信息
     * 
     * @param exampleId 存储商品的信息主键
     * @return 结果
     */
    @Override
    public int deleteExampleProductsByExampleId(Long exampleId)
    {
        return exampleProductsMapper.deleteExampleProductsByExampleId(exampleId);
    }
}
