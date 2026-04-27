package com.ruoyi.order.mapper;

import java.util.List;
import com.ruoyi.order.domain.OrdOrder;
import org.apache.ibatis.annotations.Mapper;

/**
 * 订单主表Mapper接口
 * 
 * @author 韦亚宁
 * @date 2026-04-27
 */
@Mapper
public interface OrdOrderMapper 
{
    /**
     * 查询订单主表
     * 
     * @param id 订单主表主键
     * @return 订单主表
     */
    public OrdOrder selectOrdOrderById(Long id);

    /**
     * 查询订单主表列表
     * 
     * @param ordOrder 订单主表
     * @return 订单主表集合
     */
    public List<OrdOrder> selectOrdOrderList(OrdOrder ordOrder);

    /**
     * 新增订单主表
     * 
     * @param ordOrder 订单主表
     * @return 结果
     */
    public int insertOrdOrder(OrdOrder ordOrder);

    /**
     * 修改订单主表
     * 
     * @param ordOrder 订单主表
     * @return 结果
     */
    public int updateOrdOrder(OrdOrder ordOrder);

    /**
     * 删除订单主表
     * 
     * @param id 订单主表主键
     * @return 结果
     */
    public int deleteOrdOrderById(Long id);

    /**
     * 批量删除订单主表
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteOrdOrderByIds(Long[] ids);
}
