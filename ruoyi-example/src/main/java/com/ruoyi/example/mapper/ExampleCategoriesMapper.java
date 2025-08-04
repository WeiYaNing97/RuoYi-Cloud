package com.ruoyi.example.mapper;

import java.util.List;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ruoyi.example.domain.ExampleCategories;
import org.apache.ibatis.annotations.Mapper;

/**
 * 存储商品类别的信息Mapper接口
 * 
 * @author ruoyi
 * @date 2025-07-27
 */
@Mapper
public interface ExampleCategoriesMapper extends BaseMapper<ExampleCategories>
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
     * 删除存储商品类别的信息
     * 
     * @param exampleId 存储商品类别的信息主键
     * @return 结果
     */
    public int deleteExampleCategoriesByExampleId(Long exampleId);

    /**
     * 批量删除存储商品类别的信息
     * 
     * @param exampleIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteExampleCategoriesByExampleIds(Long[] exampleIds);
}
