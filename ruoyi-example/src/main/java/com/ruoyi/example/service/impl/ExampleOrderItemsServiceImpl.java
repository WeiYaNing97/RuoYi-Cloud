package com.ruoyi.example.service.impl;

import java.math.BigDecimal;
import java.util.List;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ruoyi.example.domain.ExampleOrders;
import com.ruoyi.example.domain.ExampleProducts;
import com.ruoyi.example.mapper.ExampleOrdersMapper;
import com.ruoyi.example.mapper.ExampleProductsMapper;
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
public class ExampleOrderItemsServiceImpl extends ServiceImpl<ExampleOrderItemsMapper, ExampleOrderItems> implements IExampleOrderItemsService
{
    @Autowired
    private ExampleOrderItemsMapper exampleOrderItemsMapper;
    @Autowired
    private ExampleOrdersMapper exampleOrdersMapper;

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
        // 获取订单ID
        Long exampleOrderId = exampleOrderItems.getExampleOrderId();

        // 初始化总价变量
        BigDecimal SUM = new BigDecimal(0);

        // 创建查询包装器
        LambdaQueryWrapper<ExampleOrderItems> exampleOrderItemsLambdaQueryWrapper = new LambdaQueryWrapper<>();
        // 设置查询条件：订单ID等于传入的订单ID
        exampleOrderItemsLambdaQueryWrapper.eq(ExampleOrderItems::getExampleOrderId, exampleOrderId);
        // 执行查询，获取订单中的商品列表
        List<ExampleOrderItems> exampleOrderItemsList = exampleOrderItemsMapper.selectList(exampleOrderItemsLambdaQueryWrapper);

        exampleOrderItemsList.add(exampleOrderItems);

        // 遍历商品列表，累加每个商品的总价
        for (ExampleOrderItems exampleOrderItem : exampleOrderItemsList) {
            SUM = SUM.add(exampleOrderItem.getTotalPrice());
        }

        // 创建更新包装器
        LambdaUpdateWrapper<ExampleOrders> exampleOrdersLambdaUpdateWrapper = new LambdaUpdateWrapper<>();
        // 设置更新条件：订单ID等于传入的订单ID
        exampleOrdersLambdaUpdateWrapper.set(ExampleOrders::getTotalAmount, SUM)
                .eq(ExampleOrders::getExampleId, exampleOrderId);
        // 执行更新操作
        int update = exampleOrdersMapper.update(exampleOrdersLambdaUpdateWrapper);
        // 如果更新失败，返回0
        if (update < 0) {
            return 0;
        }
        // 执行插入操作，返回结果
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
        // 获取订单ID
        Long exampleOrderId = exampleOrderItems.getExampleOrderId();

        // 初始化总价
        BigDecimal SUM = new BigDecimal(0);

        // 创建Lambda查询包装器
        LambdaQueryWrapper<ExampleOrderItems> exampleOrderItemsLambdaQueryWrapper = new LambdaQueryWrapper<>();
        // 查询条件：订单ID等于传入的订单ID
        exampleOrderItemsLambdaQueryWrapper.eq(ExampleOrderItems::getExampleOrderId, exampleOrderId);
        // 查询订单中每种商品的详细信息列表
        List<ExampleOrderItems> exampleOrderItemsList = exampleOrderItemsMapper.selectList(exampleOrderItemsLambdaQueryWrapper);

        // 遍历商品列表，累加总价
        for (ExampleOrderItems exampleOrderItem : exampleOrderItemsList) {
            if(exampleOrderItem.getExampleId().equals(exampleOrderItems.getExampleId())){
                SUM = SUM.add(exampleOrderItems.getTotalPrice());
                continue;
            }
            SUM = SUM.add(exampleOrderItem.getTotalPrice());
        }

        // 创建Lambda更新包装器
        LambdaUpdateWrapper<ExampleOrders> exampleOrdersLambdaUpdateWrapper = new LambdaUpdateWrapper<>();
        // 更新条件：订单ID等于传入的订单ID
        // 更新内容：总价等于累加的总价
        exampleOrdersLambdaUpdateWrapper.set(ExampleOrders::getTotalAmount, SUM)
                .eq(ExampleOrders::getExampleId, exampleOrderId);
        // 执行更新操作
        int update = exampleOrdersMapper.update(exampleOrdersLambdaUpdateWrapper);
        // 如果更新失败，则返回0
        if (update < 0) {
            return 0;
        }

        // 更新存储订单中每种商品的详细信息
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
        /*return exampleOrderItemsMapper.deleteExampleOrderItemsByExampleIds(exampleIds);*/
        for (Long exampleId : exampleIds) {
            deleteExampleOrderItemsByExampleId(exampleId);
        }
        return 1;
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
        ExampleOrderItems exampleOrderItems = exampleOrderItemsMapper.selectExampleOrderItemsByExampleId(exampleId);

        // 获取订单ID
        Long exampleOrderId = exampleOrderItems.getExampleOrderId();

        // 初始化总价
        BigDecimal SUM = new BigDecimal(0);

        // 创建Lambda查询包装器
        LambdaQueryWrapper<ExampleOrderItems> exampleOrderItemsLambdaQueryWrapper = new LambdaQueryWrapper<>();
        // 查询条件：订单ID等于传入的订单ID
        exampleOrderItemsLambdaQueryWrapper.eq(ExampleOrderItems::getExampleOrderId, exampleOrderId);
        // 查询订单中每种商品的详细信息列表
        List<ExampleOrderItems> exampleOrderItemsList = exampleOrderItemsMapper.selectList(exampleOrderItemsLambdaQueryWrapper);

        // 遍历商品列表，累加总价
        for (ExampleOrderItems exampleOrderItem : exampleOrderItemsList) {
            if(exampleOrderItem.getExampleId().equals(exampleOrderItems.getExampleId())){
                continue;
            }
            SUM = SUM.add(exampleOrderItem.getTotalPrice());
        }

        // 创建Lambda更新包装器
        LambdaUpdateWrapper<ExampleOrders> exampleOrdersLambdaUpdateWrapper = new LambdaUpdateWrapper<>();
        // 更新条件：订单ID等于传入的订单ID
        // 更新内容：总价等于累加的总价
        exampleOrdersLambdaUpdateWrapper.set(ExampleOrders::getTotalAmount, SUM)
                .eq(ExampleOrders::getExampleId, exampleOrderId);
        // 执行更新操作
        int update = exampleOrdersMapper.update(exampleOrdersLambdaUpdateWrapper);
        // 如果更新失败，则返回0
        if (update < 0) {
            return 0;
        }

        return exampleOrderItemsMapper.deleteExampleOrderItemsByExampleId(exampleId);
    }
}
