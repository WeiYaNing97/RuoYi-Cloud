package com.ruoyi.minio.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.annotation.Excel;
import com.ruoyi.common.core.web.domain.BaseEntity;

/**
 * minio操作记录对象 minio_record
 * 
 * @author ruoyi
 * @date 2025-07-20
 */
public class MinioRecord extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键 */
    private Long id;

    /** 文件名 */
    @Excel(name = "文件名")
    private String fileName;

    /** 文件路径 */
    @Excel(name = "文件路径")
    private String filePath;

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

    public void setFileName(String fileName) 
    {
        this.fileName = fileName;
    }

    public String getFileName() 
    {
        return fileName;
    }

    public void setFilePath(String filePath) 
    {
        this.filePath = filePath;
    }

    public String getFilePath() 
    {
        return filePath;
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
            .append("fileName", getFileName())
            .append("filePath", getFilePath())
            .append("delFlag", getDelFlag())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
