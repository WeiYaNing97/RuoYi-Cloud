package com.ruoyi.points.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.annotation.Excel;
import com.ruoyi.common.core.web.domain.BaseEntity;

/**
 * 积分账户对象 pts_account
 * 
 * @author 韦亚宁
 * @date 2026-04-27
 */
public class PtsAccount extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 用户ID */
    private Long userId;

    /** 总积分 */
    @Excel(name = "总积分")
    private Long totalPoints;

    /** 冻结积分 */
    @Excel(name = "冻结积分")
    private Long frozenPoints;

    /** 乐观锁版本 */
    @Excel(name = "乐观锁版本")
    private Long version;

    public void setUserId(Long userId) 
    {
        this.userId = userId;
    }

    public Long getUserId() 
    {
        return userId;
    }

    public void setTotalPoints(Long totalPoints) 
    {
        this.totalPoints = totalPoints;
    }

    public Long getTotalPoints() 
    {
        return totalPoints;
    }

    public void setFrozenPoints(Long frozenPoints) 
    {
        this.frozenPoints = frozenPoints;
    }

    public Long getFrozenPoints() 
    {
        return frozenPoints;
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
            .append("userId", getUserId())
            .append("totalPoints", getTotalPoints())
            .append("frozenPoints", getFrozenPoints())
            .append("version", getVersion())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}
