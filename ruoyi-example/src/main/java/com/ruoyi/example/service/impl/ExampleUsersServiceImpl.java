package com.ruoyi.example.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ruoyi.example.domain.ExampleUsers;
import com.ruoyi.example.mapper.ExampleUsersMapper;
import com.ruoyi.example.service.IExampleUsersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 存储用户的信息Service业务层处理
 *
 * @author ruoyi
 * @date 2025-07-27
 */
@Service
public class ExampleUsersServiceImpl extends ServiceImpl<ExampleUsersMapper,ExampleUsers> implements IExampleUsersService {
    @Autowired
    private ExampleUsersMapper exampleUsersMapper;


    /**
     * 查询存储用户的信息
     *
     * @param exampleId 存储用户的信息主键
     * @return 存储用户的信息
     */
    @Override
    public ExampleUsers selectExampleUsersByExampleId(Long exampleId) {
        return exampleUsersMapper.selectExampleUsersByExampleId(exampleId);
    }

    /**
     * 查询存储用户的信息列表
     *
     * @param exampleUsers 存储用户的信息
     * @return 存储用户的信息
     */
    @Override
    public List<ExampleUsers> selectExampleUsersList(ExampleUsers exampleUsers) {
        // 使用LambdaQueryWrapper构建查询条件
        //return exampleUsersMapper.selectExampleUsersList(exampleUsers);
        LambdaQueryWrapper<ExampleUsers> queryWrapper = new LambdaQueryWrapper<ExampleUsers>();
        // 执行查询，返回查询结果列表
        List<ExampleUsers> list = exampleUsersMapper.selectList(queryWrapper);
        // 返回查询结果列表
        return list;
    }


    /**
     * 新增存储用户的信息
     *
     * @param exampleUsers 存储用户的信息
     * @return 结果
     */
    @Override
    public int insertExampleUsers(ExampleUsers exampleUsers) {
        return exampleUsersMapper.insertExampleUsers(exampleUsers);
    }

    /**
     * 修改存储用户的信息
     *
     * @param exampleUsers 存储用户的信息
     * @return 结果
     */
    @Override
    public int updateExampleUsers(ExampleUsers exampleUsers) {
        // 如果用户头像URL不为空
        if (exampleUsers.getAvatarUrl() != null) {
            // 通过用户ID查询用户信息
            ExampleUsers pojo = exampleUsersMapper.selectExampleUsersByExampleId(exampleUsers.getExampleId());

            // 如果查询到的用户信息不为空，且当前用户头像URL不为空，且当前用户头像URL不等于查询到的用户头像URL
            if (pojo != null
                    && pojo.getAvatarUrl() != null
                    && !pojo.getAvatarUrl().equals(exampleUsers.getAvatarUrl())) {
            // 删除旧头像记录
            }
        }

        // 更新用户信息
        return exampleUsersMapper.updateExampleUsers(exampleUsers);
    }


    /**
     * 批量删除存储用户的信息
     *
     * @param exampleIds 需要删除的存储用户的信息主键
     * @return 结果
     */
    @Override
    public int deleteExampleUsersByExampleIds(Long[] exampleIds) {
        // 创建LambdaQueryWrapper对象
        LambdaQueryWrapper<ExampleUsers> exampleUsersLambdaQueryWrapper = new LambdaQueryWrapper<>();
        // 添加查询条件，根据exampleIds数组进行筛选
        exampleUsersLambdaQueryWrapper.in(ExampleUsers::getExampleId, exampleIds);
        // 查询符合条件的用户信息列表
        List<ExampleUsers> exampleUsers = exampleUsersMapper.selectList(exampleUsersLambdaQueryWrapper);

        // 遍历用户信息列表，执行删除操作
        exampleUsers
                .stream()
                .forEach(exampleUser ->
                {
                    // 删除用户头像在MinIO中的记录
                    // 删除用户头像
                });

        // 删除存储用户的信息
        return exampleUsersMapper.deleteExampleUsersByExampleIds(exampleIds);
    }


    /**
     * 删除存储用户的信息信息
     *
     * @param exampleId 存储用户的信息主键
     * @return 结果
     */
    @Override
    public int deleteExampleUsersByExampleId(Long exampleId) {
        return exampleUsersMapper.deleteExampleUsersByExampleId(exampleId);
    }


}
