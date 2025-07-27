package com.ruoyi.example.domain;

import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.annotation.Excel;
import com.ruoyi.common.core.web.domain.BaseEntity;

/**
 * 存储商品的信息对象 example_products
 * 
 * @author ruoyi
 * @date 2025-07-27
 */
public class ExampleProducts extends BaseEntity
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

    public void setExampleId(Long exampleId) 
    {
        this.exampleId = exampleId;
    }

    public Long getExampleId() 
    {
        return exampleId;
    }

    public void setProductName(String productName) 
    {
        this.productName = productName;
    }

    public String getProductName() 
    {
        return productName;
    }

    public void setDescription(String description) 
    {
        this.description = description;
    }

    public String getDescription() 
    {
        return description;
    }

    public void setPrice(BigDecimal price) 
    {
        this.price = price;
    }

    public BigDecimal getPrice() 
    {
        return price;
    }

    public void setExampleCategoryId(Long exampleCategoryId) 
    {
        this.exampleCategoryId = exampleCategoryId;
    }

    public Long getExampleCategoryId() 
    {
        return exampleCategoryId;
    }

    public void setStockQuantity(Long stockQuantity) 
    {
        this.stockQuantity = stockQuantity;
    }

    public Long getStockQuantity() 
    {
        return stockQuantity;
    }

    public void setStatus(String status) 
    {
        this.status = status;
    }

    public String getStatus() 
    {
        return status;
    }

    public void setSku(String sku) 
    {
        this.sku = sku;
    }

    public String getSku() 
    {
        return sku;
    }

    public void setImageUrl(String imageUrl) 
    {
        this.imageUrl = imageUrl;
    }

    public String getImageUrl() 
    {
        return imageUrl;
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
            .append("productName", getProductName())
            .append("description", getDescription())
            .append("price", getPrice())
            .append("exampleCategoryId", getExampleCategoryId())
            .append("stockQuantity", getStockQuantity())
            .append("status", getStatus())
            .append("sku", getSku())
            .append("imageUrl", getImageUrl())
            .append("createdAt", getCreatedAt())
            .append("updatedAt", getUpdatedAt())
            .toString();
    }
}
