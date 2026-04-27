package com.ruoyi.order.mapper;

import java.util.List;
import com.ruoyi.order.domain.OrdPayment;
import org.apache.ibatis.annotations.Mapper;

/**
 * 支付流水Mapper接口
 * 
 * @author 韦亚宁
 * @date 2026-04-27
 */
@Mapper
public interface OrdPaymentMapper 
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
     * 删除支付流水
     * 
     * @param id 支付流水主键
     * @return 结果
     */
    public int deleteOrdPaymentById(Long id);

    /**
     * 批量删除支付流水
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteOrdPaymentByIds(Long[] ids);
}
