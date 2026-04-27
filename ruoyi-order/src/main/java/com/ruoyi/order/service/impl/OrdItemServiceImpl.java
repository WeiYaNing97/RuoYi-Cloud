package com.ruoyi.order.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.order.mapper.OrdItemMapper;
import com.ruoyi.order.domain.OrdItem;
import com.ruoyi.order.service.IOrdItemService;

/**
 * 订单明细Service业务层处理
 * 
 * @author 韦亚宁
 * @date 2026-04-27
 */
@Service
public class OrdItemServiceImpl implements IOrdItemService 
{
    @Autowired
    private OrdItemMapper ordItemMapper;

    /**
     * 查询订单明细
     * 
     * @param id 订单明细主键
     * @return 订单明细
     */
    @Override
    public OrdItem selectOrdItemById(Long id)
    {
        return ordItemMapper.selectOrdItemById(id);
    }

    /**
     * 查询订单明细列表
     * 
     * @param ordItem 订单明细
     * @return 订单明细
     */
    @Override
    public List<OrdItem> selectOrdItemList(OrdItem ordItem)
    {
        return ordItemMapper.selectOrdItemList(ordItem);
    }

    /**
     * 新增订单明细
     * 
     * @param ordItem 订单明细
     * @return 结果
     */
    @Override
    public int insertOrdItem(OrdItem ordItem)
    {
        return ordItemMapper.insertOrdItem(ordItem);
    }

    /**
     * 修改订单明细
     * 
     * @param ordItem 订单明细
     * @return 结果
     */
    @Override
    public int updateOrdItem(OrdItem ordItem)
    {
        return ordItemMapper.updateOrdItem(ordItem);
    }

    /**
     * 批量删除订单明细
     * 
     * @param ids 需要删除的订单明细主键
     * @return 结果
     */
    @Override
    public int deleteOrdItemByIds(Long[] ids)
    {
        return ordItemMapper.deleteOrdItemByIds(ids);
    }

    /**
     * 删除订单明细信息
     * 
     * @param id 订单明细主键
     * @return 结果
     */
    @Override
    public int deleteOrdItemById(Long id)
    {
        return ordItemMapper.deleteOrdItemById(id);
    }
}
