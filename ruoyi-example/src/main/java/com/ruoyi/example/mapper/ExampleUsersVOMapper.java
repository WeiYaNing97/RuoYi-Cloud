package com.ruoyi.example.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.github.yulichang.base.MPJBaseMapper;
import com.ruoyi.common.core.config.BaseMapperX;
import com.ruoyi.example.domain.ExampleUsers;
import com.ruoyi.example.domain.ExampleUsersVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * 存储用户的信息Mapper接口
 * 
 * @author ruoyi
 * @date 2025-07-27
 */
@Mapper
public interface ExampleUsersVOMapper extends MPJBaseMapper<ExampleUsersVO>
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
     * 删除存储用户的信息
     * 
     * @param exampleId 存储用户的信息主键
     * @return 结果
     */
    public int deleteExampleUsersByExampleId(Long exampleId);

    /**
     * 批量删除存储用户的信息
     * 
     * @param exampleIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteExampleUsersByExampleIds(Long[] exampleIds);

    List<ExampleUsersVO> selectJoinListALL();
}
