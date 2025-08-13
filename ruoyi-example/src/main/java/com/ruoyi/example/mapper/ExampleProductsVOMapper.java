package com.ruoyi.example.mapper;

import com.ruoyi.common.core.config.BaseMapperX;
import com.ruoyi.example.domain.ExampleProducts;
import com.ruoyi.example.domain.ExampleProductsVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * 存储商品的信息Mapper接口
 * 
 * @author ruoyi
 * @date 2025-07-27
 */
@Mapper
public interface ExampleProductsVOMapper extends BaseMapperX<ExampleProductsVO>
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
     * 删除存储商品的信息
     * 
     * @param exampleId 存储商品的信息主键
     * @return 结果
     */
    public int deleteExampleProductsByExampleId(Long exampleId);

    /**
     * 批量删除存储商品的信息
     * 
     * @param exampleIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteExampleProductsByExampleIds(Long[] exampleIds);
}
