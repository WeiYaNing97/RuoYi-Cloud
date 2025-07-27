package com.ruoyi.example.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.annotation.Excel;
import com.ruoyi.common.core.web.domain.BaseEntity;

/**
 * 存储用户的信息对象 example_users
 * 
 * @author ruoyi
 * @date 2025-07-27
 */
public class ExampleUsers extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 用户的唯一标识符 */
    private Long exampleId;

    /** 用户名 */
    @Excel(name = "用户名")
    private String username;

    /** 用户邮箱地址 */
    @Excel(name = "用户邮箱地址")
    private String email;

    /** 用户密码哈希值 */
    @Excel(name = "用户密码哈希值")
    private String passwordHash;

    /** 用户联系电话 */
    @Excel(name = "用户联系电话")
    private String phone;

    /** 用户头像URL */
    @Excel(name = "用户头像URL")
    private String avatarUrl;

    /** 用户角色（例如：user, admin） */
    @Excel(name = "用户角色", readConverterExp = "例=如：user,,a=dmin")
    private String role;

    /** 用户账户是否激活 */
    @Excel(name = "用户账户是否激活")
    private Integer isActive;

    /** 用户上次登录时间 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "用户上次登录时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date lastLogin;

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

    public void setUsername(String username) 
    {
        this.username = username;
    }

    public String getUsername() 
    {
        return username;
    }

    public void setEmail(String email) 
    {
        this.email = email;
    }

    public String getEmail() 
    {
        return email;
    }

    public void setPasswordHash(String passwordHash) 
    {
        this.passwordHash = passwordHash;
    }

    public String getPasswordHash() 
    {
        return passwordHash;
    }

    public void setPhone(String phone) 
    {
        this.phone = phone;
    }

    public String getPhone() 
    {
        return phone;
    }

    public void setAvatarUrl(String avatarUrl) 
    {
        this.avatarUrl = avatarUrl;
    }

    public String getAvatarUrl() 
    {
        return avatarUrl;
    }

    public void setRole(String role) 
    {
        this.role = role;
    }

    public String getRole() 
    {
        return role;
    }

    public void setIsActive(Integer isActive) 
    {
        this.isActive = isActive;
    }

    public Integer getIsActive() 
    {
        return isActive;
    }

    public void setLastLogin(Date lastLogin) 
    {
        this.lastLogin = lastLogin;
    }

    public Date getLastLogin() 
    {
        return lastLogin;
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
            .append("username", getUsername())
            .append("email", getEmail())
            .append("passwordHash", getPasswordHash())
            .append("phone", getPhone())
            .append("avatarUrl", getAvatarUrl())
            .append("role", getRole())
            .append("isActive", getIsActive())
            .append("lastLogin", getLastLogin())
            .append("createdAt", getCreatedAt())
            .append("updatedAt", getUpdatedAt())
            .toString();
    }
}
