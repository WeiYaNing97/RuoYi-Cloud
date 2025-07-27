package com.ruoyi.example.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.example.mapper.ExampleOrderItemsMapper;
import com.ruoyi.example.domain.ExampleOrderItems;
import com.ruoyi.example.service.IExampleOrderItemsService;

/**
 * 存储订单中每种商品的详细信息Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-07-27
 */
@Service
public class ExampleOrderItemsServiceImpl implements IExampleOrderItemsService 
{
    @Autowired
    private ExampleOrderItemsMapper exampleOrderItemsMapper;

    /**
     * 查询存储订单中每种商品的详细信息
     * 
     * @param exampleId 存储订单中每种商品的详细信息主键
     * @return 存储订单中每种商品的详细信息
     */
    @Override
    public ExampleOrderItems selectExampleOrderItemsByExampleId(Long exampleId)
    {
        return exampleOrderItemsMapper.selectExampleOrderItemsByExampleId(exampleId);
    }

    /**
     * 查询存储订单中每种商品的详细信息列表
     * 
     * @param exampleOrderItems 存储订单中每种商品的详细信息
     * @return 存储订单中每种商品的详细信息
     */
    @Override
    public List<ExampleOrderItems> selectExampleOrderItemsList(ExampleOrderItems exampleOrderItems)
    {
        return exampleOrderItemsMapper.selectExampleOrderItemsList(exampleOrderItems);
    }

    /**
     * 新增存储订单中每种商品的详细信息
     * 
     * @param exampleOrderItems 存储订单中每种商品的详细信息
     * @return 结果
     */
    @Override
    public int insertExampleOrderItems(ExampleOrderItems exampleOrderItems)
    {
        return exampleOrderItemsMapper.insertExampleOrderItems(exampleOrderItems);
    }

    /**
     * 修改存储订单中每种商品的详细信息
     * 
     * @param exampleOrderItems 存储订单中每种商品的详细信息
     * @return 结果
     */
    @Override
    public int updateExampleOrderItems(ExampleOrderItems exampleOrderItems)
    {
        return exampleOrderItemsMapper.updateExampleOrderItems(exampleOrderItems);
    }

    /**
     * 批量删除存储订单中每种商品的详细信息
     * 
     * @param exampleIds 需要删除的存储订单中每种商品的详细信息主键
     * @return 结果
     */
    @Override
    public int deleteExampleOrderItemsByExampleIds(Long[] exampleIds)
    {
        return exampleOrderItemsMapper.deleteExampleOrderItemsByExampleIds(exampleIds);
    }

    /**
     * 删除存储订单中每种商品的详细信息信息
     * 
     * @param exampleId 存储订单中每种商品的详细信息主键
     * @return 结果
     */
    @Override
    public int deleteExampleOrderItemsByExampleId(Long exampleId)
    {
        return exampleOrderItemsMapper.deleteExampleOrderItemsByExampleId(exampleId);
    }
}
