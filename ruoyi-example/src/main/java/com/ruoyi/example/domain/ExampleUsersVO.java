package com.ruoyi.example.domain;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.core.annotation.Excel;
import lombok.Data;

import java.util.Date;
import java.util.List;

/**
 * 存储用户的信息对象 example_users
 *
 * @author ruoyi
 * @date 2025-07-27
 */
@Data
@TableName("example_users")
public class ExampleUsersVO {
    private static final long serialVersionUID = 1L;

    /**
     * 用户的唯一标识符
     */
    private Long exampleId;

    /**
     * 用户名
     */
    @Excel(name = "用户名")
    private String username;

    /**
     * 用户邮箱地址
     */
    @Excel(name = "用户邮箱地址")
    private String email;

    /**
     * 用户密码哈希值
     */
    @Excel(name = "用户密码哈希值")
    private String passwordHash;

    /**
     * 用户联系电话
     */
    @Excel(name = "用户联系电话")
    private String phone;

    /**
     * 用户头像URL
     */
    @Excel(name = "用户头像URL")
    private String avatarUrl;

    /**
     * 用户角色（例如：user, admin）
     */
    @Excel(name = "用户角色", readConverterExp = "例=如：user,,admin")
    private Long role;

    /**
     * 用户账户是否激活
     */
    @Excel(name = "用户账户是否激活")
    private Integer isActive;

    /**
     * 用户上次登录时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "用户上次登录时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date lastLogin;

    /**
     * 记录创建时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "记录创建时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date createdAt;

    /**
     * 记录最后更新时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "记录最后更新时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date updatedAt;

    // ... existing code ...
    private ExampleOrdersVO exampleOrdersVOs;
// ... existing code ...

}
