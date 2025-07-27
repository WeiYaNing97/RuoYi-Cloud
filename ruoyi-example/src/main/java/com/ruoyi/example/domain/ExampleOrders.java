package com.ruoyi.example.domain;

import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.annotation.Excel;
import com.ruoyi.common.core.web.domain.BaseEntity;

/**
 * 存储订单的信息对象 example_orders
 * 
 * @author ruoyi
 * @date 2025-07-27
 */
public class ExampleOrders extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 订单的唯一标识符 */
    private Long exampleId;

    /** 下单用户的ID */
    @Excel(name = "下单用户的ID")
    private Long exampleUserId;

    /** 下单日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "下单日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date orderDate;

    /** 订单总金额 */
    @Excel(name = "订单总金额")
    private BigDecimal totalAmount;

    /** 订单状态（例如：pending, shipped, delivered, cancelled） */
    @Excel(name = "订单状态", readConverterExp = "例=如：pending,,s=hipped,,d=elivered,,c=ancelled")
    private String status;

    /** 收货地址 */
    @Excel(name = "收货地址")
    private String shippingAddress;

    /** 配送方式 */
    @Excel(name = "配送方式")
    private String shippingMethod;

    /** 支付方式 */
    @Excel(name = "支付方式")
    private String paymentMethod;

    /** 物流追踪号码 */
    @Excel(name = "物流追踪号码")
    private String trackingNumber;

    /** 记录创建时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "记录创建时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date createdAt;

    /** 记录最后更新时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "记录最后更新时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date updatedAt;

    public void setExampleId(Long exampleId) 
    {
        this.exampleId = exampleId;
    }

    public Long getExampleId() 
    {
        return exampleId;
    }

    public void setExampleUserId(Long exampleUserId) 
    {
        this.exampleUserId = exampleUserId;
    }

    public Long getExampleUserId() 
    {
        return exampleUserId;
    }

    public void setOrderDate(Date orderDate) 
    {
        this.orderDate = orderDate;
    }

    public Date getOrderDate() 
    {
        return orderDate;
    }

    public void setTotalAmount(BigDecimal totalAmount) 
    {
        this.totalAmount = totalAmount;
    }

    public BigDecimal getTotalAmount() 
    {
        return totalAmount;
    }

    public void setStatus(String status) 
    {
        this.status = status;
    }

    public String getStatus() 
    {
        return status;
    }

    public void setShippingAddress(String shippingAddress) 
    {
        this.shippingAddress = shippingAddress;
    }

    public String getShippingAddress() 
    {
        return shippingAddress;
    }

    public void setShippingMethod(String shippingMethod) 
    {
        this.shippingMethod = shippingMethod;
    }

    public String getShippingMethod() 
    {
        return shippingMethod;
    }

    public void setPaymentMethod(String paymentMethod) 
    {
        this.paymentMethod = paymentMethod;
    }

    public String getPaymentMethod() 
    {
        return paymentMethod;
    }

    public void setTrackingNumber(String trackingNumber) 
    {
        this.trackingNumber = trackingNumber;
    }

    public String getTrackingNumber() 
    {
        return trackingNumber;
    }

    public void setCreatedAt(Date createdAt) 
    {
        this.createdAt = createdAt;
    }

    public Date getCreatedAt() 
    {
        return createdAt;
    }

    public void setUpdatedAt(Date updatedAt) 
    {
        this.updatedAt = updatedAt;
    }

    public Date getUpdatedAt() 
    {
        return updatedAt;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("exampleId", getExampleId())
            .append("exampleUserId", getExampleUserId())
            .append("orderDate", getOrderDate())
            .append("totalAmount", getTotalAmount())
            .append("status", getStatus())
            .append("shippingAddress", getShippingAddress())
            .append("shippingMethod", getShippingMethod())
            .append("paymentMethod", getPaymentMethod())
            .append("trackingNumber", getTrackingNumber())
            .append("remark", getRemark())
            .append("createdAt", getCreatedAt())
            .append("updatedAt", getUpdatedAt())
            .toString();
    }
}
