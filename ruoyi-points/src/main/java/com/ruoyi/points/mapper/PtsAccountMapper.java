package com.ruoyi.points.mapper;

import java.util.List;
import com.ruoyi.points.domain.PtsAccount;
import org.apache.ibatis.annotations.Mapper;

/**
 * 积分账户Mapper接口
 * 
 * @author 韦亚宁
 * @date 2026-04-27
 */
@Mapper
public interface PtsAccountMapper 
{
    /**
     * 查询积分账户
     * 
     * @param userId 积分账户主键
     * @return 积分账户
     */
    public PtsAccount selectPtsAccountByUserId(Long userId);

    /**
     * 查询积分账户列表
     * 
     * @param ptsAccount 积分账户
     * @return 积分账户集合
     */
    public List<PtsAccount> selectPtsAccountList(PtsAccount ptsAccount);

    /**
     * 新增积分账户
     * 
     * @param ptsAccount 积分账户
     * @return 结果
     */
    public int insertPtsAccount(PtsAccount ptsAccount);

    /**
     * 修改积分账户
     * 
     * @param ptsAccount 积分账户
     * @return 结果
     */
    public int updatePtsAccount(PtsAccount ptsAccount);

    /**
     * 删除积分账户
     * 
     * @param userId 积分账户主键
     * @return 结果
     */
    public int deletePtsAccountByUserId(Long userId);

    /**
     * 批量删除积分账户
     * 
     * @param userIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deletePtsAccountByUserIds(Long[] userIds);
}
