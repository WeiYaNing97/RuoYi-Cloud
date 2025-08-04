package com.ruoyi.example.service;

import java.util.List;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ruoyi.example.domain.ExampleOrderItems;

/**
 * 存储订单中每种商品的详细信息Service接口
 * 
 * @author ruoyi
 * @date 2025-07-27
 */
public interface IExampleOrderItemsService extends IService<ExampleOrderItems>
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
     * 批量删除存储订单中每种商品的详细信息
     * 
     * @param exampleIds 需要删除的存储订单中每种商品的详细信息主键集合
     * @return 结果
     */
    public int deleteExampleOrderItemsByExampleIds(Long[] exampleIds);

    /**
     * 删除存储订单中每种商品的详细信息信息
     * 
     * @param exampleId 存储订单中每种商品的详细信息主键
     * @return 结果
     */
    public int deleteExampleOrderItemsByExampleId(Long exampleId);
}
