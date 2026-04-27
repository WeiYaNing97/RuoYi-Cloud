package com.ruoyi.points.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.annotation.Excel;
import com.ruoyi.common.core.web.domain.BaseEntity;

/**
 * 积分流水对象 pts_log
 * 
 * @author 韦亚宁
 * @date 2026-04-27
 */
public class PtsLog extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** $column.columnComment */
    private Long id;

    /** 用户ID */
    @Excel(name = "用户ID")
    private Long userId;

    /** 类型:1-增加;2-扣减 */
    @Excel(name = "类型:1-增加;2-扣减")
    private Integer type;

    /** 变动数值 */
    @Excel(name = "变动数值")
    private Long amount;

    /** 变动后余额快照 */
    @Excel(name = "变动后余额快照")
    private Long balanceSnapshot;

    /** 来源:ORDER,SIGN */
    @Excel(name = "来源:ORDER,SIGN")
    private String sourceType;

    /** 来源业务ID(幂等) */
    @Excel(name = "来源业务ID(幂等)")
    private String sourceId;

    /** $column.columnComment */
    @Excel(name = "${comment}", readConverterExp = "$column.readConverterExp()")
    private String description;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }

    public void setUserId(Long userId) 
    {
        this.userId = userId;
    }

    public Long getUserId() 
    {
        return userId;
    }

    public void setType(Integer type) 
    {
        this.type = type;
    }

    public Integer getType() 
    {
        return type;
    }

    public void setAmount(Long amount) 
    {
        this.amount = amount;
    }

    public Long getAmount() 
    {
        return amount;
    }

    public void setBalanceSnapshot(Long balanceSnapshot) 
    {
        this.balanceSnapshot = balanceSnapshot;
    }

    public Long getBalanceSnapshot() 
    {
        return balanceSnapshot;
    }

    public void setSourceType(String sourceType) 
    {
        this.sourceType = sourceType;
    }

    public String getSourceType() 
    {
        return sourceType;
    }

    public void setSourceId(String sourceId) 
    {
        this.sourceId = sourceId;
    }

    public String getSourceId() 
    {
        return sourceId;
    }

    public void setDescription(String description) 
    {
        this.description = description;
    }

    public String getDescription() 
    {
        return description;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("userId", getUserId())
            .append("type", getType())
            .append("amount", getAmount())
            .append("balanceSnapshot", getBalanceSnapshot())
            .append("sourceType", getSourceType())
            .append("sourceId", getSourceId())
            .append("description", getDescription())
            .append("createTime", getCreateTime())
            .toString();
    }
}
