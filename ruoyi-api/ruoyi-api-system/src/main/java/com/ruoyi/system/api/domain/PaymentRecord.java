package com.ruoyi.system.api.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 支付记录实体类
 * 用于映射数据库中的支付流水表
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class PaymentRecord {

    /**
     * 主键 ID (通常对应数据库自增ID或雪花算法ID)
     */
    private Long id;

    /**
     * 关联的业务订单号 (例如：商城的订单号)
     */
    private String bizOrderId;

    /**
     * 第三方支付流水号 (例如：微信/支付宝返回的交易号)
     */
    private String transactionId;

    /**
     * 支付金额 (使用 BigDecimal 确保金额精度，不使用 double)
     */
    private BigDecimal amount;

    /**
     * 支付方式 (微信、支付宝、银联等)
     */
    private Integer paymentMethod;

    /**
     * 支付时间 (记录实际支付成功的时间)
     */
    private LocalDateTime paymentTime;

    /**
     * 支付状态 (成功、失败、处理中)
     */
    private Integer status;

    /**
     * 创建时间
     */
    private LocalDateTime createTime;

    /**
     * 更新时间
     */
    private LocalDateTime updateTime;
}