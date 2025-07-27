package com.ruoyi.example.mapper;

import java.util.List;
import com.ruoyi.example.domain.ExamplePayments;

/**
 * 存储支付信息Mapper接口
 * 
 * @author ruoyi
 * @date 2025-07-27
 */
public interface ExamplePaymentsMapper 
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
     * 删除存储支付信息
     * 
     * @param exampleId 存储支付信息主键
     * @return 结果
     */
    public int deleteExamplePaymentsByExampleId(Long exampleId);

    /**
     * 批量删除存储支付信息
     * 
     * @param exampleIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteExamplePaymentsByExampleIds(Long[] exampleIds);
}
