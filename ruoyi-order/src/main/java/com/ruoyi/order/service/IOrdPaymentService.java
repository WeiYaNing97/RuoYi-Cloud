package com.ruoyi.order.service;

import java.util.List;
import com.ruoyi.order.domain.OrdPayment;

/**
 * 支付流水Service接口
 * 
 * @author 韦亚宁
 * @date 2026-04-27
 */
public interface IOrdPaymentService 
{
    /**
     * 查询支付流水
     * 
     * @param id 支付流水主键
     * @return 支付流水
     */
    public OrdPayment selectOrdPaymentById(Long id);

    /**
     * 查询支付流水列表
     * 
     * @param ordPayment 支付流水
     * @return 支付流水集合
     */
    public List<OrdPayment> selectOrdPaymentList(OrdPayment ordPayment);

    /**
     * 新增支付流水
     * 
     * @param ordPayment 支付流水
     * @return 结果
     */
    public int insertOrdPayment(OrdPayment ordPayment);

    /**
     * 修改支付流水
     * 
     * @param ordPayment 支付流水
     * @return 结果
     */
    public int updateOrdPayment(OrdPayment ordPayment);

    /**
     * 批量删除支付流水
     * 
     * @param ids 需要删除的支付流水主键集合
     * @return 结果
     */
    public int deleteOrdPaymentByIds(Long[] ids);

    /**
     * 删除支付流水信息
     * 
     * @param id 支付流水主键
     * @return 结果
     */
    public int deleteOrdPaymentById(Long id);
}
