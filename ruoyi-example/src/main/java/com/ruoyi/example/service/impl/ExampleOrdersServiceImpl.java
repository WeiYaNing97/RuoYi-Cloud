package com.ruoyi.example.service.impl;

import java.util.List;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.example.mapper.ExampleOrdersMapper;
import com.ruoyi.example.domain.ExampleOrders;
import com.ruoyi.example.service.IExampleOrdersService;

/**
 * 存储订单的信息Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-07-27
 */
@Service
public class ExampleOrdersServiceImpl extends ServiceImpl<ExampleOrdersMapper,ExampleOrders> implements IExampleOrdersService
{
    @Autowired
    private ExampleOrdersMapper exampleOrdersMapper;

    /**
     * 查询存储订单的信息
     * 
     * @param exampleId 存储订单的信息主键
     * @return 存储订单的信息
     */
    @Override
    public ExampleOrders selectExampleOrdersByExampleId(Long exampleId)
    {
        return exampleOrdersMapper.selectExampleOrdersByExampleId(exampleId);
    }

    /**
     * 查询存储订单的信息列表
     * 
     * @param exampleOrders 存储订单的信息
     * @return 存储订单的信息
     */
    @Override
    public List<ExampleOrders> selectExampleOrdersList(ExampleOrders exampleOrders)
    {
        return exampleOrdersMapper.selectExampleOrdersList(exampleOrders);
    }

    /**
     * 新增存储订单的信息
     * 
     * @param exampleOrders 存储订单的信息
     * @return 结果
     */
    @Override
    public int insertExampleOrders(ExampleOrders exampleOrders)
    {
        return exampleOrdersMapper.insertExampleOrders(exampleOrders);
    }

    /**
     * 修改存储订单的信息
     * 
     * @param exampleOrders 存储订单的信息
     * @return 结果
     */
    @Override
    public int updateExampleOrders(ExampleOrders exampleOrders)
    {
        return exampleOrdersMapper.updateExampleOrders(exampleOrders);
    }

    /**
     * 批量删除存储订单的信息
     * 
     * @param exampleIds 需要删除的存储订单的信息主键
     * @return 结果
     */
    @Override
    public int deleteExampleOrdersByExampleIds(Long[] exampleIds)
    {
        return exampleOrdersMapper.deleteExampleOrdersByExampleIds(exampleIds);
    }

    /**
     * 删除存储订单的信息信息
     * 
     * @param exampleId 存储订单的信息主键
     * @return 结果
     */
    @Override
    public int deleteExampleOrdersByExampleId(Long exampleId)
    {
        return exampleOrdersMapper.deleteExampleOrdersByExampleId(exampleId);
    }
}
