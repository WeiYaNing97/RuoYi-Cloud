package com.ruoyi.example.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.example.mapper.ExampleUsersMapper;
import com.ruoyi.example.domain.ExampleUsers;
import com.ruoyi.example.service.IExampleUsersService;

/**
 * 存储用户的信息Service业务层处理
 * 
 * @author ruoyi
 * @date 2025-07-27
 */
@Service
public class ExampleUsersServiceImpl implements IExampleUsersService 
{
    @Autowired
    private ExampleUsersMapper exampleUsersMapper;

    /**
     * 查询存储用户的信息
     * 
     * @param exampleId 存储用户的信息主键
     * @return 存储用户的信息
     */
    @Override
    public ExampleUsers selectExampleUsersByExampleId(Long exampleId)
    {
        return exampleUsersMapper.selectExampleUsersByExampleId(exampleId);
    }

    /**
     * 查询存储用户的信息列表
     * 
     * @param exampleUsers 存储用户的信息
     * @return 存储用户的信息
     */
    @Override
    public List<ExampleUsers> selectExampleUsersList(ExampleUsers exampleUsers)
    {
        return exampleUsersMapper.selectExampleUsersList(exampleUsers);
    }

    /**
     * 新增存储用户的信息
     * 
     * @param exampleUsers 存储用户的信息
     * @return 结果
     */
    @Override
    public int insertExampleUsers(ExampleUsers exampleUsers)
    {
        return exampleUsersMapper.insertExampleUsers(exampleUsers);
    }

    /**
     * 修改存储用户的信息
     * 
     * @param exampleUsers 存储用户的信息
     * @return 结果
     */
    @Override
    public int updateExampleUsers(ExampleUsers exampleUsers)
    {
        return exampleUsersMapper.updateExampleUsers(exampleUsers);
    }

    /**
     * 批量删除存储用户的信息
     * 
     * @param exampleIds 需要删除的存储用户的信息主键
     * @return 结果
     */
    @Override
    public int deleteExampleUsersByExampleIds(Long[] exampleIds)
    {
        return exampleUsersMapper.deleteExampleUsersByExampleIds(exampleIds);
    }

    /**
     * 删除存储用户的信息信息
     * 
     * @param exampleId 存储用户的信息主键
     * @return 结果
     */
    @Override
    public int deleteExampleUsersByExampleId(Long exampleId)
    {
        return exampleUsersMapper.deleteExampleUsersByExampleId(exampleId);
    }
}
