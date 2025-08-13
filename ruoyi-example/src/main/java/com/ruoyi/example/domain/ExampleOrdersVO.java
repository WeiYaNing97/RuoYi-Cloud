package com.ruoyi.example.domain;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.core.annotation.Excel;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * 存储订单的信息对象 example_orders
 *
 * @author ruoyi
 * @date 2025-07-27
 */
@Data
@TableName("example_orders")
public class ExampleOrdersVO
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

    /** 备注 */
    private String remark;

    /** 记录创建时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "记录创建时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date createdAt;

    /** 记录最后更新时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "记录最后更新时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date updatedAt;

    // ... existing code ...
    private ExampleOrderItemsVO exampleOrderItemsVOs;
// ... existing code ...

}
