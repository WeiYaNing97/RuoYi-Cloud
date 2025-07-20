package com.ruoyi.minio.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.annotation.Excel;
import com.ruoyi.common.core.web.domain.BaseEntity;

import java.util.Date;

/**
 * minio操作记录对象 practice_minio
 * 
 * @author ruoyi
 * @date 2025-07-20
 */
@Data
public class PracticeMinio
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
    @Excel(name = "删除标志（0代表存在 2代表删除）")
    private Integer delFlag;

    /** 创建者 */
    private String createBy;

    /** 创建时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    /** 更新者 */
    private String updateBy;

    /** 更新时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date updateTime;

    /** 备注 */
    private String remark;
}
