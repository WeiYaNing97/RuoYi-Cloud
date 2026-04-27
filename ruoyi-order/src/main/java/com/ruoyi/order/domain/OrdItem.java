package com.ruoyi.order.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.annotation.Excel;
import com.ruoyi.common.core.web.domain.BaseEntity;

/**
 * 订单明细对象 ord_item
 * 
 * @author 韦亚宁
 * @date 2026-04-27
 */
public class OrdItem extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** $column.columnComment */
    private Long id;

    /** 关联订单ID */
    @Excel(name = "关联订单ID")
    private Long orderId;

    /** 商品ID */
    @Excel(name = "商品ID")
    private Long productId;

    /** 商品名称快照 */
    @Excel(name = "商品名称快照")
    private String productName;

    /** SKU编码快照 */
    @Excel(name = "SKU编码快照")
    private String productSkuCode;

    /** 单价(分) */
    @Excel(name = "单价(分)")
    private Long productPrice;

    /** 数量 */
    @Excel(name = "数量")
    private Long productQuantity;

    /** 总价(分) */
    @Excel(name = "总价(分)")
    private Long productTotalPrice;

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

    public void setProductId(Long productId) 
    {
        this.productId = productId;
    }

    public Long getProductId() 
    {
        return productId;
    }

    public void setProductName(String productName) 
    {
        this.productName = productName;
    }

    public String getProductName() 
    {
        return productName;
    }

    public void setProductSkuCode(String productSkuCode) 
    {
        this.productSkuCode = productSkuCode;
    }

    public String getProductSkuCode() 
    {
        return productSkuCode;
    }

    public void setProductPrice(Long productPrice) 
    {
        this.productPrice = productPrice;
    }

    public Long getProductPrice() 
    {
        return productPrice;
    }

    public void setProductQuantity(Long productQuantity) 
    {
        this.productQuantity = productQuantity;
    }

    public Long getProductQuantity() 
    {
        return productQuantity;
    }

    public void setProductTotalPrice(Long productTotalPrice) 
    {
        this.productTotalPrice = productTotalPrice;
    }

    public Long getProductTotalPrice() 
    {
        return productTotalPrice;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("orderId", getOrderId())
            .append("productId", getProductId())
            .append("productName", getProductName())
            .append("productSkuCode", getProductSkuCode())
            .append("productPrice", getProductPrice())
            .append("productQuantity", getProductQuantity())
            .append("productTotalPrice", getProductTotalPrice())
            .toString();
    }
}
