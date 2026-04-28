package com.ruoyi.order.service.impl;

import com.ruoyi.common.core.utils.DateUtils;
import com.ruoyi.order.domain.OrdPayment;
import com.ruoyi.order.mapper.OrdPaymentMapper;
import com.ruoyi.order.service.IOrdPaymentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 支付流水Service业务层处理
 * 
 * @author 韦亚宁
 * @date 2026-04-27
 */
@Service
public class OrdPaymentServiceImpl implements IOrdPaymentService 
{
    @Autowired
    private OrdPaymentMapper ordPaymentMapper;

    /**
     * 查询支付流水
     * 
     * @param id 支付流水主键
     * @return 支付流水
     */
    @Override
    public OrdPayment selectOrdPaymentById(Long id)
    {
        return ordPaymentMapper.selectOrdPaymentById(id);
    }

    /**
     * 查询支付流水列表
     * 
     * @param ordPayment 支付流水
     * @return 支付流水
     */
    @Override
    public List<OrdPayment> selectOrdPaymentList(OrdPayment ordPayment)
    {
        return ordPaymentMapper.selectOrdPaymentList(ordPayment);
    }

    /**
     * 新增支付流水
     * 
     * @param ordPayment 支付流水
     * @return 结果
     */
    @Override
    public int insertOrdPayment(OrdPayment ordPayment)
    {
        ordPayment.setCreateTime(DateUtils.getNowDate());
        return ordPaymentMapper.insertOrdPayment(ordPayment);
    }

    /**
     * 修改支付流水
     * 
     * @param ordPayment 支付流水
     * @return 结果
     */
    @Override
    public int updateOrdPayment(OrdPayment ordPayment)
    {
        return ordPaymentMapper.updateOrdPayment(ordPayment);
    }

    /**
     * 批量删除支付流水
     * 
     * @param ids 需要删除的支付流水主键
     * @return 结果
     */
    @Override
    public int deleteOrdPaymentByIds(Long[] ids)
    {
        return ordPaymentMapper.deleteOrdPaymentByIds(ids);
    }

    /**
     * 删除支付流水信息
     * 
     * @param id 支付流水主键
     * @return 结果
     */
    @Override
    public int deleteOrdPaymentById(Long id)
    {
        return ordPaymentMapper.deleteOrdPaymentById(id);
    }
}
