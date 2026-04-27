package com.ruoyi.order.mapper;

import java.util.List;
import com.ruoyi.order.domain.OrdItem;
import org.apache.ibatis.annotations.Mapper;

/**
 * 订单明细Mapper接口
 * 
 * @author 韦亚宁
 * @date 2026-04-27
 */
@Mapper
public interface OrdItemMapper 
{
    /**
     * 查询订单明细
     * 
     * @param id 订单明细主键
     * @return 订单明细
     */
    public OrdItem selectOrdItemById(Long id);

    /**
     * 查询订单明细列表
     * 
     * @param ordItem 订单明细
     * @return 订单明细集合
     */
    public List<OrdItem> selectOrdItemList(OrdItem ordItem);

    /**
     * 新增订单明细
     * 
     * @param ordItem 订单明细
     * @return 结果
     */
    public int insertOrdItem(OrdItem ordItem);

    /**
     * 修改订单明细
     * 
     * @param ordItem 订单明细
     * @return 结果
     */
    public int updateOrdItem(OrdItem ordItem);

    /**
     * 删除订单明细
     * 
     * @param id 订单明细主键
     * @return 结果
     */
    public int deleteOrdItemById(Long id);

    /**
     * 批量删除订单明细
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteOrdItemByIds(Long[] ids);
}
