package com.ruoyi.example.service.impl;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.ruoyi.minio.domain.MinioRecord;
import com.ruoyi.minio.mapper.MinioRecordMapper;
import com.ruoyi.minio.service.IMinioRecordService;
import com.ruoyi.minio.service.MinioOssService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.example.mapper.ExampleUsersMapper;
import com.ruoyi.example.domain.ExampleUsers;
import com.ruoyi.example.service.IExampleUsersService;

import javax.annotation.Resource;

/**
 * 存储用户的信息Service业务层处理
 *
 * @author ruoyi
 * @date 2025-07-27
 */
@Service
public class ExampleUsersServiceImpl implements IExampleUsersService {
    @Autowired
    private ExampleUsersMapper exampleUsersMapper;

    @Resource
    private MinioRecordMapper minioRecordMapper;
    @Resource
    private IMinioRecordService minioRecordService;

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
                // 删除Minio存储中的旧头像记录
                delMinioRecord(pojo.getAvatarUrl());
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
                    // /*minioOssService.deleteByFilePath(exampleUser.getAvatarUrl());*/
                    delMinioRecord(exampleUser.getAvatarUrl());
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

    /**
     * 删除 Minio 记录
     *
     * @param avatarUrl 文件路径
     * @return 删除的记录数
     */
    public Integer delMinioRecord(String avatarUrl) {
        // 从 minioRecordMapper 中查询符合条件的记录ID列表
        List<Long> collect = minioRecordMapper.selectList(new LambdaQueryWrapper<MinioRecord>()
                        .ge(MinioRecord::getFilePath, avatarUrl)) // 查询文件路径大于等于 avatarUrl 的记录
                .stream().map(MinioRecord::getId).collect(Collectors.toList()); // 将查询结果转换为ID列表

        // 通过 minioRecordService 删除查询到的记录
        int i = minioRecordService.deleteMinioRecordByIds(collect.toArray(new Long[0])); // 根据ID数组删除记录

        return i;
    }

}
