package com.ruoyi.example.mapper;

import java.util.List;
import com.ruoyi.example.domain.ExampleOrders;

/**
 * 存储订单的信息Mapper接口
 * 
 * @author ruoyi
 * @date 2025-07-27
 */
public interface ExampleOrdersMapper 
{
    /**
     * 查询存储订单的信息
     * 
     * @param exampleId 存储订单的信息主键
     * @return 存储订单的信息
     */
    public ExampleOrders selectExampleOrdersByExampleId(Long exampleId);

    /**
     * 查询存储订单的信息列表
     * 
     * @param exampleOrders 存储订单的信息
     * @return 存储订单的信息集合
     */
    public List<ExampleOrders> selectExampleOrdersList(ExampleOrders exampleOrders);

    /**
     * 新增存储订单的信息
     * 
     * @param exampleOrders 存储订单的信息
     * @return 结果
     */
    public int insertExampleOrders(ExampleOrders exampleOrders);

    /**
     * 修改存储订单的信息
     * 
     * @param exampleOrders 存储订单的信息
     * @return 结果
     */
    public int updateExampleOrders(ExampleOrders exampleOrders);

    /**
     * 删除存储订单的信息
     * 
     * @param exampleId 存储订单的信息主键
     * @return 结果
     */
    public int deleteExampleOrdersByExampleId(Long exampleId);

    /**
     * 批量删除存储订单的信息
     * 
     * @param exampleIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteExampleOrdersByExampleIds(Long[] exampleIds);
}
