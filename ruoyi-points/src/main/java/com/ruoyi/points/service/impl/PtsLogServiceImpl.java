package com.ruoyi.points.service.impl;

import java.util.List;
import com.ruoyi.common.core.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.points.mapper.PtsLogMapper;
import com.ruoyi.points.domain.PtsLog;
import com.ruoyi.points.service.IPtsLogService;

/**
 * 积分流水Service业务层处理
 * 
 * @author 韦亚宁
 * @date 2026-04-27
 */
@Service
public class PtsLogServiceImpl implements IPtsLogService 
{
    @Autowired
    private PtsLogMapper ptsLogMapper;

    /**
     * 查询积分流水
     * 
     * @param id 积分流水主键
     * @return 积分流水
     */
    @Override
    public PtsLog selectPtsLogById(Long id)
    {
        return ptsLogMapper.selectPtsLogById(id);
    }

    /**
     * 查询积分流水列表
     * 
     * @param ptsLog 积分流水
     * @return 积分流水
     */
    @Override
    public List<PtsLog> selectPtsLogList(PtsLog ptsLog)
    {
        return ptsLogMapper.selectPtsLogList(ptsLog);
    }

    /**
     * 新增积分流水
     * 
     * @param ptsLog 积分流水
     * @return 结果
     */
    @Override
    public int insertPtsLog(PtsLog ptsLog)
    {
        ptsLog.setCreateTime(DateUtils.getNowDate());
        return ptsLogMapper.insertPtsLog(ptsLog);
    }

    /**
     * 修改积分流水
     * 
     * @param ptsLog 积分流水
     * @return 结果
     */
    @Override
    public int updatePtsLog(PtsLog ptsLog)
    {
        return ptsLogMapper.updatePtsLog(ptsLog);
    }

    /**
     * 批量删除积分流水
     * 
     * @param ids 需要删除的积分流水主键
     * @return 结果
     */
    @Override
    public int deletePtsLogByIds(Long[] ids)
    {
        return ptsLogMapper.deletePtsLogByIds(ids);
    }

    /**
     * 删除积分流水信息
     * 
     * @param id 积分流水主键
     * @return 结果
     */
    @Override
    public int deletePtsLogById(Long id)
    {
        return ptsLogMapper.deletePtsLogById(id);
    }
}
