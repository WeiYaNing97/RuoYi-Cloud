package com.ruoyi.example.service.impl;

import java.util.List;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.example.mapper.ExamplePaymentsMapper;
import com.ruoyi.example.domain.ExamplePayments;
import com.ruoyi.example.service.IExamplePaymentsService;

/**
 * 存储支付信息Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-07-27
 */
@Service
public class ExamplePaymentsServiceImpl extends ServiceImpl<ExamplePaymentsMapper, ExamplePayments> implements IExamplePaymentsService
{
    @Autowired
    private ExamplePaymentsMapper examplePaymentsMapper;

    /**
     * 查询存储支付信息
     * 
     * @param exampleId 存储支付信息主键
     * @return 存储支付信息
     */
    @Override
    public ExamplePayments selectExamplePaymentsByExampleId(Long exampleId)
    {
        return examplePaymentsMapper.selectExamplePaymentsByExampleId(exampleId);
    }

    /**
     * 查询存储支付信息列表
     * 
     * @param examplePayments 存储支付信息
     * @return 存储支付信息
     */
    @Override
    public List<ExamplePayments> selectExamplePaymentsList(ExamplePayments examplePayments)
    {
        return examplePaymentsMapper.selectExamplePaymentsList(examplePayments);
    }

    /**
     * 新增存储支付信息
     * 
     * @param examplePayments 存储支付信息
     * @return 结果
     */
    @Override
    public int insertExamplePayments(ExamplePayments examplePayments)
    {
        return examplePaymentsMapper.insertExamplePayments(examplePayments);
    }

    /**
     * 修改存储支付信息
     * 
     * @param examplePayments 存储支付信息
     * @return 结果
     */
    @Override
    public int updateExamplePayments(ExamplePayments examplePayments)
    {
        return examplePaymentsMapper.updateExamplePayments(examplePayments);
    }

    /**
     * 批量删除存储支付信息
     * 
     * @param exampleIds 需要删除的存储支付信息主键
     * @return 结果
     */
    @Override
    public int deleteExamplePaymentsByExampleIds(Long[] exampleIds)
    {
        return examplePaymentsMapper.deleteExamplePaymentsByExampleIds(exampleIds);
    }

    /**
     * 删除存储支付信息信息
     * 
     * @param exampleId 存储支付信息主键
     * @return 结果
     */
    @Override
    public int deleteExamplePaymentsByExampleId(Long exampleId)
    {
        return examplePaymentsMapper.deleteExamplePaymentsByExampleId(exampleId);
    }
}
