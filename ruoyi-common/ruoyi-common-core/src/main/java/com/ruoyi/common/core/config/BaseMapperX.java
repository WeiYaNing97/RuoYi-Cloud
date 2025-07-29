package com.ruoyi.common.core.config;


import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.github.yulichang.base.MPJBaseMapper; // MPJ 的 JoinBaseMapper
// import tk.mybatis.mapper.common.Mapper; // 如果你同时用到了 tk.mybatis, 可以在这里引入

/**
 * 自定义通用 Mapper 接口
 * 所有需要使用 MPJ 连表查询功能的 Mapper 都应继承此类
 * @param <T> 实体类型
 */
public interface BaseMapperX<T> extends BaseMapper<T>, MPJBaseMapper<T> {
    // 这里可以添加你项目中所有 Mapper 都需要的通用方法
    // 例如：逻辑删除的特殊处理、自定义的批量操作等
    // 目前可以先留空，仅作继承用
}