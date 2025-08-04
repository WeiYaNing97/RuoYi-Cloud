package com.ruoyi.example.service;

import java.util.List;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ruoyi.example.domain.ExampleUsers;

/**
 * 存储用户的信息Service接口
 * 
 * @author ruoyi
 * @date 2025-07-27
 */
public interface IExampleUsersService extends IService<ExampleUsers>
{
    /**
     * 查询存储用户的信息
     * 
     * @param exampleId 存储用户的信息主键
     * @return 存储用户的信息
     */
    public ExampleUsers selectExampleUsersByExampleId(Long exampleId);

    /**
     * 查询存储用户的信息列表
     * 
     * @param exampleUsers 存储用户的信息
     * @return 存储用户的信息集合
     */
    public List<ExampleUsers> selectExampleUsersList(ExampleUsers exampleUsers);

    /**
     * 新增存储用户的信息
     * 
     * @param exampleUsers 存储用户的信息
     * @return 结果
     */
    public int insertExampleUsers(ExampleUsers exampleUsers);

    /**
     * 修改存储用户的信息
     * 
     * @param exampleUsers 存储用户的信息
     * @return 结果
     */
    public int updateExampleUsers(ExampleUsers exampleUsers);

    /**
     * 批量删除存储用户的信息
     * 
     * @param exampleIds 需要删除的存储用户的信息主键集合
     * @return 结果
     */
    public int deleteExampleUsersByExampleIds(Long[] exampleIds);

    /**
     * 删除存储用户的信息信息
     * 
     * @param exampleId 存储用户的信息主键
     * @return 结果
     */
    public int deleteExampleUsersByExampleId(Long exampleId);
}
