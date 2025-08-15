package com.ruoyi.example.domain;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.ruoyi.common.core.annotation.Excel;
import lombok.Data;

import java.math.BigDecimal;
import java.util.List;

/**
 * 存储订单中每种商品的详细信息对象 example_order_items
 * 
 * @author ruoyi
 * @date 2025-07-27
 */
@Data
@TableName("example_order_items")
public class ExampleOrderItemsVO
{
    private static final long serialVersionUID = 1L;

    /** 订单项的唯一标识符 */
    private Long exampleId;

    /** 关联订单的ID */
    @Excel(name = "关联订单的ID")
    private Long exampleOrderId;

    /** 商品的ID */
    @Excel(name = "商品的ID")
    private Long exampleProductId;

    /** 商品数量 */
    @Excel(name = "商品数量")
    private Long quantity;

    /** 单价 */
    @Excel(name = "单价")
    private BigDecimal unitPrice;

    /** 总价 */
    @Excel(name = "总价")
    private BigDecimal totalPrice;

    /** 商品名称 */
    @Excel(name = "商品名称")
    private String productName;

    /** 商品库存保有单位(SKU) */
    @Excel(name = "商品库存保有单位(SKU)")
    private String sku;

    /** 订单项状态（例如：normal, returned, exchanged） */
    @Excel(name = "订单项状态", readConverterExp = "例=如：normal,,r=eturned,,e=xchanged")
    private String status;

    @TableField(exist = false)
    private ExampleProductsVO exampleProductsVOs;
}
