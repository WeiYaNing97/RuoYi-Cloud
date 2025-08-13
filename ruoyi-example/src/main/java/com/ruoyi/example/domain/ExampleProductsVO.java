package com.ruoyi.example.domain;

import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.core.annotation.Excel;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 存储商品的信息对象 example_products
 * 
 * @author ruoyi
 * @date 2025-07-27
 */
@Data
@TableName("example_products")
public class ExampleProductsVO
{
    private static final long serialVersionUID = 1L;

    /** 商品的唯一标识符 */
    private Long exampleId;

    /** 商品名称 */
    @Excel(name = "商品名称")
    private String productName;

    /** 商品描述 */
    @Excel(name = "商品描述")
    private String description;

    /** 商品价格 */
    @Excel(name = "商品价格")
    private BigDecimal price;

    /** 所属类别ID */
    @Excel(name = "所属类别ID")
    private Long exampleCategoryId;

    /** 库存数量 */
    @Excel(name = "库存数量")
    private Long stockQuantity;

    /** 商品状态（例如：active, inactive） */
    @Excel(name = "商品状态", readConverterExp = "例=如：active,,i=nactive")
    private String status;

    /** 商品库存保有单位(SKU) */
    @Excel(name = "商品库存保有单位(SKU)")
    private String sku;

    /** 商品图片URL */
    @Excel(name = "商品图片URL")
    private String imageUrl;

    /** 记录创建时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "记录创建时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date createdAt;

    /** 记录最后更新时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "记录最后更新时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date updatedAt;

}
