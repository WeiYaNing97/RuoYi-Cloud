package com.ruoyi.example.domain;

import java.math.BigDecimal;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.annotation.Excel;
import com.ruoyi.common.core.web.domain.BaseEntity;

/**
 * 存储订单中每种商品的详细信息对象 example_order_items
 * 
 * @author ruoyi
 * @date 2025-07-27
 */
public class ExampleOrderItems extends BaseEntity
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

    public void setExampleProductId(Long exampleProductId) 
    {
        this.exampleProductId = exampleProductId;
    }

    public Long getExampleProductId() 
    {
        return exampleProductId;
    }

    public void setQuantity(Long quantity) 
    {
        this.quantity = quantity;
    }

    public Long getQuantity() 
    {
        return quantity;
    }

    public void setUnitPrice(BigDecimal unitPrice) 
    {
        this.unitPrice = unitPrice;
    }

    public BigDecimal getUnitPrice() 
    {
        return unitPrice;
    }

    public void setTotalPrice(BigDecimal totalPrice) 
    {
        this.totalPrice = totalPrice;
    }

    public BigDecimal getTotalPrice() 
    {
        return totalPrice;
    }

    public void setProductName(String productName) 
    {
        this.productName = productName;
    }

    public String getProductName() 
    {
        return productName;
    }

    public void setSku(String sku) 
    {
        this.sku = sku;
    }

    public String getSku() 
    {
        return sku;
    }

    public void setStatus(String status) 
    {
        this.status = status;
    }

    public String getStatus() 
    {
        return status;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("exampleId", getExampleId())
            .append("exampleOrderId", getExampleOrderId())
            .append("exampleProductId", getExampleProductId())
            .append("quantity", getQuantity())
            .append("unitPrice", getUnitPrice())
            .append("totalPrice", getTotalPrice())
            .append("productName", getProductName())
            .append("sku", getSku())
            .append("status", getStatus())
            .toString();
    }
}
