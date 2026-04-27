package com.ruoyi.order.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.annotation.Excel;
import com.ruoyi.common.core.web.domain.BaseEntity;

/**
 * 订单主表对象 ord_order
 * 
 * @author 韦亚宁
 * @date 2026-04-27
 */
public class OrdOrder extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键ID */
    private Long id;

    /** 订单编号 */
    @Excel(name = "订单编号")
    private String orderSn;

    /** 用户ID */
    @Excel(name = "用户ID")
    private Long memberId;

    /** 状态:0-待支付;1-待发货;2-已发货;3-已完成;4-已关闭 */
    @Excel(name = "状态:0-待支付;1-待发货;2-已发货;3-已完成;4-已关闭")
    private Integer status;

    /** 总金额(分) */
    @Excel(name = "总金额(分)")
    private Long totalAmount;

    /** 应付金额(分) */
    @Excel(name = "应付金额(分)")
    private Long payAmount;

    /** 优惠金额(分) */
    @Excel(name = "优惠金额(分)")
    private Long promotionAmount;

    /** 运费(分) */
    @Excel(name = "运费(分)")
    private Long freightAmount;

    /** 支付方式:1-微信;2-支付宝 */
    @Excel(name = "支付方式:1-微信;2-支付宝")
    private Integer paymentType;

    /** 支付时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "支付时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date paymentTime;

    /** 过期时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "过期时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date expireTime;

    /** 乐观锁版本号 */
    @Excel(name = "乐观锁版本号")
    private Long version;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }

    public void setOrderSn(String orderSn) 
    {
        this.orderSn = orderSn;
    }

    public String getOrderSn() 
    {
        return orderSn;
    }

    public void setMemberId(Long memberId) 
    {
        this.memberId = memberId;
    }

    public Long getMemberId() 
    {
        return memberId;
    }

    public void setStatus(Integer status) 
    {
        this.status = status;
    }

    public Integer getStatus() 
    {
        return status;
    }

    public void setTotalAmount(Long totalAmount) 
    {
        this.totalAmount = totalAmount;
    }

    public Long getTotalAmount() 
    {
        return totalAmount;
    }

    public void setPayAmount(Long payAmount) 
    {
        this.payAmount = payAmount;
    }

    public Long getPayAmount() 
    {
        return payAmount;
    }

    public void setPromotionAmount(Long promotionAmount) 
    {
        this.promotionAmount = promotionAmount;
    }

    public Long getPromotionAmount() 
    {
        return promotionAmount;
    }

    public void setFreightAmount(Long freightAmount) 
    {
        this.freightAmount = freightAmount;
    }

    public Long getFreightAmount() 
    {
        return freightAmount;
    }

    public void setPaymentType(Integer paymentType) 
    {
        this.paymentType = paymentType;
    }

    public Integer getPaymentType() 
    {
        return paymentType;
    }

    public void setPaymentTime(Date paymentTime) 
    {
        this.paymentTime = paymentTime;
    }

    public Date getPaymentTime() 
    {
        return paymentTime;
    }

    public void setExpireTime(Date expireTime) 
    {
        this.expireTime = expireTime;
    }

    public Date getExpireTime() 
    {
        return expireTime;
    }

    public void setVersion(Long version) 
    {
        this.version = version;
    }

    public Long getVersion() 
    {
        return version;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("orderSn", getOrderSn())
            .append("memberId", getMemberId())
            .append("status", getStatus())
            .append("totalAmount", getTotalAmount())
            .append("payAmount", getPayAmount())
            .append("promotionAmount", getPromotionAmount())
            .append("freightAmount", getFreightAmount())
            .append("paymentType", getPaymentType())
            .append("paymentTime", getPaymentTime())
            .append("expireTime", getExpireTime())
            .append("version", getVersion())
            .append("createTime", getCreateTime())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}
