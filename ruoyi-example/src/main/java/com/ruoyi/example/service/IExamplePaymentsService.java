package com.ruoyi.example.service;

import java.util.List;
import com.ruoyi.example.domain.ExamplePayments;

/**
 * 存储支付信息Service接口
 * 
 * @author ruoyi
 * @date 2025-07-27
 */
public interface IExamplePaymentsService 
{
    /**
     * 查询存储支付信息
     * 
     * @param exampleId 存储支付信息主键
     * @return 存储支付信息
     */
    public ExamplePayments selectExamplePaymentsByExampleId(Long exampleId);

    /**
     * 查询存储支付信息列表
     * 
     * @param examplePayments 存储支付信息
     * @return 存储支付信息集合
     */
    public List<ExamplePayments> selectExamplePaymentsList(ExamplePayments examplePayments);

    /**
     * 新增存储支付信息
     * 
     * @param examplePayments 存储支付信息
     * @return 结果
     */
    public int insertExamplePayments(ExamplePayments examplePayments);

    /**
     * 修改存储支付信息
     * 
     * @param examplePayments 存储支付信息
     * @return 结果
     */
    public int updateExamplePayments(ExamplePayments examplePayments);

    /**
     * 批量删除存储支付信息
     * 
     * @param exampleIds 需要删除的存储支付信息主键集合
     * @return 结果
     */
    public int deleteExamplePaymentsByExampleIds(Long[] exampleIds);

    /**
     * 删除存储支付信息信息
     * 
     * @param exampleId 存储支付信息主键
     * @return 结果
     */
    public int deleteExamplePaymentsByExampleId(Long exampleId);
}
