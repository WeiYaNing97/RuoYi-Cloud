package com.ruoyi.example.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.annotation.Excel;
import com.ruoyi.common.core.web.domain.BaseEntity;

/**
 * 存储商品类别的信息对象 example_categories
 * 
 * @author ruoyi
 * @date 2025-07-27
 */
public class ExampleCategories extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 类别的唯一标识符 */
    private Long exampleId;

    /** 类别的名称 */
    @Excel(name = "类别的名称")
    private String categoryName;

    /** 类别的描述信息 */
    @Excel(name = "类别的描述信息")
    private String description;

    /** 父类别的ID，NULL表示顶级类别 */
    @Excel(name = "父类别的ID，NULL表示顶级类别")
    private Long exampleParentId;

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

    public void setCategoryName(String categoryName) 
    {
        this.categoryName = categoryName;
    }

    public String getCategoryName() 
    {
        return categoryName;
    }

    public void setDescription(String description) 
    {
        this.description = description;
    }

    public String getDescription() 
    {
        return description;
    }

    public void setExampleParentId(Long exampleParentId) 
    {
        this.exampleParentId = exampleParentId;
    }

    public Long getExampleParentId() 
    {
        return exampleParentId;
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
            .append("categoryName", getCategoryName())
            .append("description", getDescription())
            .append("exampleParentId", getExampleParentId())
            .append("createdAt", getCreatedAt())
            .append("updatedAt", getUpdatedAt())
            .toString();
    }
}
