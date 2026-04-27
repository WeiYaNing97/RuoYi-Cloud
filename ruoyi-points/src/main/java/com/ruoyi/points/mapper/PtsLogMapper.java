package com.ruoyi.points.mapper;

import java.util.List;
import com.ruoyi.points.domain.PtsLog;
import org.apache.ibatis.annotations.Mapper;

/**
 * 积分流水Mapper接口
 * 
 * @author 韦亚宁
 * @date 2026-04-27
 */
@Mapper
public interface PtsLogMapper 
{
    /**
     * 查询积分流水
     * 
     * @param id 积分流水主键
     * @return 积分流水
     */
    public PtsLog selectPtsLogById(Long id);

    /**
     * 查询积分流水列表
     * 
     * @param ptsLog 积分流水
     * @return 积分流水集合
     */
    public List<PtsLog> selectPtsLogList(PtsLog ptsLog);

    /**
     * 新增积分流水
     * 
     * @param ptsLog 积分流水
     * @return 结果
     */
    public int insertPtsLog(PtsLog ptsLog);

    /**
     * 修改积分流水
     * 
     * @param ptsLog 积分流水
     * @return 结果
     */
    public int updatePtsLog(PtsLog ptsLog);

    /**
     * 删除积分流水
     * 
     * @param id 积分流水主键
     * @return 结果
     */
    public int deletePtsLogById(Long id);

    /**
     * 批量删除积分流水
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deletePtsLogByIds(Long[] ids);
}
