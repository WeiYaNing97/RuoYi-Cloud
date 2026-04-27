package com.ruoyi.points.service.impl;

import java.util.List;
import com.ruoyi.common.core.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.points.mapper.PtsAccountMapper;
import com.ruoyi.points.domain.PtsAccount;
import com.ruoyi.points.service.IPtsAccountService;

/**
 * 积分账户Service业务层处理
 * 
 * @author 韦亚宁
 * @date 2026-04-27
 */
@Service
public class PtsAccountServiceImpl implements IPtsAccountService 
{
    @Autowired
    private PtsAccountMapper ptsAccountMapper;

    /**
     * 查询积分账户
     * 
     * @param userId 积分账户主键
     * @return 积分账户
     */
    @Override
    public PtsAccount selectPtsAccountByUserId(Long userId)
    {
        return ptsAccountMapper.selectPtsAccountByUserId(userId);
    }

    /**
     * 查询积分账户列表
     * 
     * @param ptsAccount 积分账户
     * @return 积分账户
     */
    @Override
    public List<PtsAccount> selectPtsAccountList(PtsAccount ptsAccount)
    {
        return ptsAccountMapper.selectPtsAccountList(ptsAccount);
    }

    /**
     * 新增积分账户
     * 
     * @param ptsAccount 积分账户
     * @return 结果
     */
    @Override
    public int insertPtsAccount(PtsAccount ptsAccount)
    {
        return ptsAccountMapper.insertPtsAccount(ptsAccount);
    }

    /**
     * 修改积分账户
     * 
     * @param ptsAccount 积分账户
     * @return 结果
     */
    @Override
    public int updatePtsAccount(PtsAccount ptsAccount)
    {
        ptsAccount.setUpdateTime(DateUtils.getNowDate());
        return ptsAccountMapper.updatePtsAccount(ptsAccount);
    }

    /**
     * 批量删除积分账户
     * 
     * @param userIds 需要删除的积分账户主键
     * @return 结果
     */
    @Override
    public int deletePtsAccountByUserIds(Long[] userIds)
    {
        return ptsAccountMapper.deletePtsAccountByUserIds(userIds);
    }

    /**
     * 删除积分账户信息
     * 
     * @param userId 积分账户主键
     * @return 结果
     */
    @Override
    public int deletePtsAccountByUserId(Long userId)
    {
        return ptsAccountMapper.deletePtsAccountByUserId(userId);
    }
}
