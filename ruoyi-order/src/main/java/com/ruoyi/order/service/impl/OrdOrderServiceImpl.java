package com.ruoyi.order.service.impl;

import java.util.List;
import com.ruoyi.common.core.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.order.mapper.OrdOrderMapper;
import com.ruoyi.order.domain.OrdOrder;
import com.ruoyi.order.service.IOrdOrderService;

/**
 * 订单主表Service业务层处理
 * 
 * @author 韦亚宁
 * @date 2026-04-27
 */
@Service
public class OrdOrderServiceImpl implements IOrdOrderService 
{
    @Autowired
    private OrdOrderMapper ordOrderMapper;

    /**
     * 查询订单主表
     * 
     * @param id 订单主表主键
     * @return 订单主表
     */
    @Override
    public OrdOrder selectOrdOrderById(Long id)
    {
        return ordOrderMapper.selectOrdOrderById(id);
    }

    /**
     * 查询订单主表列表
     * 
     * @param ordOrder 订单主表
     * @return 订单主表
     */
    @Override
    public List<OrdOrder> selectOrdOrderList(OrdOrder ordOrder)
    {
        return ordOrderMapper.selectOrdOrderList(ordOrder);
    }

    /**
     * 新增订单主表
     * 
     * @param ordOrder 订单主表
     * @return 结果
     */
    @Override
    public int insertOrdOrder(OrdOrder ordOrder)
    {
        ordOrder.setCreateTime(DateUtils.getNowDate());
        return ordOrderMapper.insertOrdOrder(ordOrder);
    }

    /**
     * 修改订单主表
     * 
     * @param ordOrder 订单主表
     * @return 结果
     */
    @Override
    public int updateOrdOrder(OrdOrder ordOrder)
    {
        ordOrder.setUpdateTime(DateUtils.getNowDate());
        return ordOrderMapper.updateOrdOrder(ordOrder);
    }

    /**
     * 批量删除订单主表
     * 
     * @param ids 需要删除的订单主表主键
     * @return 结果
     */
    @Override
    public int deleteOrdOrderByIds(Long[] ids)
    {
        return ordOrderMapper.deleteOrdOrderByIds(ids);
    }

    /**
     * 删除订单主表信息
     * 
     * @param id 订单主表主键
     * @return 结果
     */
    @Override
    public int deleteOrdOrderById(Long id)
    {
        return ordOrderMapper.deleteOrdOrderById(id);
    }
}
