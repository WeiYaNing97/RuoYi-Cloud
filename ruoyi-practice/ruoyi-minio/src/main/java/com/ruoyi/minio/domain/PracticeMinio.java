package com.ruoyi.minio.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.annotation.Excel;
import com.ruoyi.common.core.web.domain.BaseEntity;

/**
 * minio操作记录对象 practice_minio
 * 
 * @author ruoyi
 * @date 2025-07-20
 */
public class PracticeMinio extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键 */
    private Long id;

    /** 文件名称 */
    @Excel(name = "文件名称")
    private String filedName;

    /** 文件路径 */
    @Excel(name = "文件路径")
    private String filedPath;

    /** 删除标志（0代表存在 2代表删除） */
    private String delFlag;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }

    public void setFiledName(String filedName) 
    {
        this.filedName = filedName;
    }

    public String getFiledName() 
    {
        return filedName;
    }

    public void setFiledPath(String filedPath) 
    {
        this.filedPath = filedPath;
    }

    public String getFiledPath() 
    {
        return filedPath;
    }

    public void setDelFlag(String delFlag) 
    {
        this.delFlag = delFlag;
    }

    public String getDelFlag() 
    {
        return delFlag;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("filedName", getFiledName())
            .append("filedPath", getFiledPath())
            .append("delFlag", getDelFlag())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
