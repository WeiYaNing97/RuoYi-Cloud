package com.ruoyi.order.service;

import java.util.List;
import com.ruoyi.order.domain.OrdOrder;
import com.ruoyi.system.api.domain.PaymentRecord;

/**
 * 订单主表Service接口
 * 
 * @author 韦亚宁
 * @date 2026-04-27
 */
public interface IOrdOrderService 
{
    /**
     * 查询订单主表
     * 
     * @param id 订单主表主键
     * @return 订单主表
     */
    public OrdOrder selectOrdOrderById(Long id);

    /**
     * 查询订单主表列表
     * 
     * @param ordOrder 订单主表
     * @return 订单主表集合
     */
    public List<OrdOrder> selectOrdOrderList(OrdOrder ordOrder);

    /**
     * 新增订单主表
     * 
     * @param ordOrder 订单主表
     * @return 结果
     */
    public int insertOrdOrder(OrdOrder ordOrder);

    /**
     * 修改订单主表
     * 
     * @param ordOrder 订单主表
     * @return 结果
     */
    public int updateOrdOrder(OrdOrder ordOrder);

    /**
     * 批量删除订单主表
     * 
     * @param ids 需要删除的订单主表主键集合
     * @return 结果
     */
    public int deleteOrdOrderByIds(Long[] ids);

    /**
     * 删除订单主表信息
     * 
     * @param id 订单主表主键
     * @return 结果
     */
    public int deleteOrdOrderById(Long id);

    /**
     * 修改支付状态
     * @param payment
     * @return
     */
    int updateOrdOrderStatus(PaymentRecord payment);
}
