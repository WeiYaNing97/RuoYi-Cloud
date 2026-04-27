package com.ruoyi.order.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.annotation.Excel;
import com.ruoyi.common.core.web.domain.BaseEntity;

/**
 * 支付流水对象 ord_payment
 * 
 * @author 韦亚宁
 * @date 2026-04-27
 */
public class OrdPayment extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** $column.columnComment */
    private Long id;

    /** 关联订单ID */
    @Excel(name = "关联订单ID")
    private Long orderId;

    /** 支付流水号 */
    @Excel(name = "支付流水号")
    private String paymentSn;

    /** 第三方交易号 */
    @Excel(name = "第三方交易号")
    private String transactionId;

    /** 金额(分) */
    @Excel(name = "金额(分)")
    private Long amount;

    /** 状态:0-未支付;1-成功 */
    @Excel(name = "状态:0-未支付;1-成功")
    private Integer status;

    /** $column.columnComment */
    @Excel(name = "${comment}", readConverterExp = "$column.readConverterExp()")
    private Date paymentTime;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }

    public void setOrderId(Long orderId) 
    {
        this.orderId = orderId;
    }

    public Long getOrderId() 
    {
        return orderId;
    }

    public void setPaymentSn(String paymentSn) 
    {
        this.paymentSn = paymentSn;
    }

    public String getPaymentSn() 
    {
        return paymentSn;
    }

    public void setTransactionId(String transactionId) 
    {
        this.transactionId = transactionId;
    }

    public String getTransactionId() 
    {
        return transactionId;
    }

    public void setAmount(Long amount) 
    {
        this.amount = amount;
    }

    public Long getAmount() 
    {
        return amount;
    }

    public void setStatus(Integer status) 
    {
        this.status = status;
    }

    public Integer getStatus() 
    {
        return status;
    }

    public void setPaymentTime(Date paymentTime) 
    {
        this.paymentTime = paymentTime;
    }

    public Date getPaymentTime() 
    {
        return paymentTime;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("orderId", getOrderId())
            .append("paymentSn", getPaymentSn())
            .append("transactionId", getTransactionId())
            .append("amount", getAmount())
            .append("status", getStatus())
            .append("paymentTime", getPaymentTime())
            .append("createTime", getCreateTime())
            .toString();
    }
}
