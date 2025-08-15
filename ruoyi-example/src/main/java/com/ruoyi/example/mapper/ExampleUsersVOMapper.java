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

    List<ExampleUsersVO> selectUserProductsList();
}
