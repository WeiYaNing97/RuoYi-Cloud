package com.ruoyi.example.mapper;

import java.util.List;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ruoyi.common.core.config.BaseMapperX;
import com.ruoyi.example.domain.ExampleOrderItems;
import org.apache.ibatis.annotations.Mapper;

/**
 * 存储订单中每种商品的详细信息Mapper接口
 * 
 * @author ruoyi
 * @date 2025-07-27
 */
@Mapper
public interface ExampleOrderItemsMapper extends BaseMapperX<ExampleOrderItems>
{
    /**
     * 查询存储订单中每种商品的详细信息
     * 
     * @param exampleId 存储订单中每种商品的详细信息主键
     * @return 存储订单中每种商品的详细信息
     */
    public ExampleOrderItems selectExampleOrderItemsByExampleId(Long exampleId);

    /**
     * 查询存储订单中每种商品的详细信息列表
     * 
     * @param exampleOrderItems 存储订单中每种商品的详细信息
     * @return 存储订单中每种商品的详细信息集合
     */
    public List<ExampleOrderItems> selectExampleOrderItemsList(ExampleOrderItems exampleOrderItems);

    /**
     * 新增存储订单中每种商品的详细信息
     * 
     * @param exampleOrderItems 存储订单中每种商品的详细信息
     * @return 结果
     */
    public int insertExampleOrderItems(ExampleOrderItems exampleOrderItems);

    /**
     * 修改存储订单中每种商品的详细信息
     * 
     * @param exampleOrderItems 存储订单中每种商品的详细信息
     * @return 结果
     */
    public int updateExampleOrderItems(ExampleOrderItems exampleOrderItems);

    /**
     * 删除存储订单中每种商品的详细信息
     * 
     * @param exampleId 存储订单中每种商品的详细信息主键
     * @return 结果
     */
    public int deleteExampleOrderItemsByExampleId(Long exampleId);

    /**
     * 批量删除存储订单中每种商品的详细信息
     * 
     * @param exampleIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteExampleOrderItemsByExampleIds(Long[] exampleIds);
}
