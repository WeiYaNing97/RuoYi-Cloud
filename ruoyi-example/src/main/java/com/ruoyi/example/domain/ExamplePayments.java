package com.ruoyi.example.domain;

import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.annotation.Excel;
import com.ruoyi.common.core.web.domain.BaseEntity;

/**
 * 存储支付信息对象 example_payments
 * 
 * @author ruoyi
 * @date 2025-07-27
 */
public class ExamplePayments extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 支付记录的唯一标识符 */
    private Long exampleId;

    /** 关联订单的ID */
    @Excel(name = "关联订单的ID")
    private Long exampleOrderId;

    /** 支付方式 */
    @Excel(name = "支付方式")
    private String paymentMethod;

    /** 支付金额 */
    @Excel(name = "支付金额")
    private BigDecimal amount;

    /** 支付状态（例如：pending, completed, failed） */
    @Excel(name = "支付状态", readConverterExp = "例=如：pending,,c=ompleted,,f=ailed")
    private String paymentStatus;

    /** 支付日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "支付日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date paymentDate;

    /** 交易编号 */
    @Excel(name = "交易编号")
    private String transactionId;

    /** 支付渠道 */
    @Excel(name = "支付渠道")
    private String paymentChannel;

    /** 额外信息 */
    @Excel(name = "额外信息")
    private String extraInfo;

    public void setExampleId(Long exampleId) 
    {
        this.exampleId = exampleId;
    }

    public Long getExampleId() 
    {
        return exampleId;
    }

    public void setExampleOrderId(Long exampleOrderId) 
    {
        this.exampleOrderId = exampleOrderId;
    }

    public Long getExampleOrderId() 
    {
        return exampleOrderId;
    }

    public void setPaymentMethod(String paymentMethod) 
    {
        this.paymentMethod = paymentMethod;
    }

    public String getPaymentMethod() 
    {
        return paymentMethod;
    }

    public void setAmount(BigDecimal amount) 
    {
        this.amount = amount;
    }

    public BigDecimal getAmount() 
    {
        return amount;
    }

    public void setPaymentStatus(String paymentStatus) 
    {
        this.paymentStatus = paymentStatus;
    }

    public String getPaymentStatus() 
    {
        return paymentStatus;
    }

    public void setPaymentDate(Date paymentDate) 
    {
        this.paymentDate = paymentDate;
    }

    public Date getPaymentDate() 
    {
        return paymentDate;
    }

    public void setTransactionId(String transactionId) 
    {
        this.transactionId = transactionId;
    }

    public String getTransactionId() 
    {
        return transactionId;
    }

    public void setPaymentChannel(String paymentChannel) 
    {
        this.paymentChannel = paymentChannel;
    }

    public String getPaymentChannel() 
    {
        return paymentChannel;
    }

    public void setExtraInfo(String extraInfo) 
    {
        this.extraInfo = extraInfo;
    }

    public String getExtraInfo() 
    {
        return extraInfo;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("exampleId", getExampleId())
            .append("exampleOrderId", getExampleOrderId())
            .append("paymentMethod", getPaymentMethod())
            .append("amount", getAmount())
            .append("paymentStatus", getPaymentStatus())
            .append("paymentDate", getPaymentDate())
            .append("transactionId", getTransactionId())
            .append("paymentChannel", getPaymentChannel())
            .append("extraInfo", getExtraInfo())
            .toString();
    }
}
