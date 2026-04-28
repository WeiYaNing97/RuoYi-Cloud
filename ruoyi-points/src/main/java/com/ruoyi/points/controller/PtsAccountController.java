package com.ruoyi.points.controller;

import java.time.LocalDateTime;
import java.util.List;

import com.ruoyi.common.core.domain.R;
import com.ruoyi.system.api.domain.PaymentRecord;
import com.ruoyi.system.api.enums.PaymentMethodEnum;
import com.ruoyi.system.api.enums.PaymentStatusEnum;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.log.annotation.Log;
import com.ruoyi.common.log.enums.BusinessType;
import com.ruoyi.common.security.annotation.RequiresPermissions;
import com.ruoyi.points.domain.PtsAccount;
import com.ruoyi.points.service.IPtsAccountService;
import com.ruoyi.common.core.web.controller.BaseController;
import com.ruoyi.common.core.web.domain.AjaxResult;
import com.ruoyi.common.core.utils.poi.ExcelUtil;
import com.ruoyi.common.core.web.page.TableDataInfo;

/**
 * 积分账户Controller
 * 
 * @author 韦亚宁
 * @date 2026-04-27
 */
@RestController
@RequestMapping("/PtsAccount")
public class PtsAccountController extends BaseController
{
    @Autowired
    private IPtsAccountService ptsAccountService;

    /**
     * 查询积分账户列表
     */
    @RequiresPermissions("points:PtsAccount:list")
    @GetMapping("/list")
    public TableDataInfo list(PtsAccount ptsAccount)
    {
        startPage();
        List<PtsAccount> list = ptsAccountService.selectPtsAccountList(ptsAccount);
        return getDataTable(list);
    }

    /**
     * 导出积分账户列表
     */
    @RequiresPermissions("points:PtsAccount:export")
    @Log(title = "积分账户", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, PtsAccount ptsAccount)
    {
        List<PtsAccount> list = ptsAccountService.selectPtsAccountList(ptsAccount);
        ExcelUtil<PtsAccount> util = new ExcelUtil<PtsAccount>(PtsAccount.class);
        util.exportExcel(response, list, "积分账户数据");
    }

    /**
     * 获取积分账户详细信息
     */
    @RequiresPermissions("points:PtsAccount:query")
    @GetMapping(value = "/{userId}")
    public AjaxResult getInfo(@PathVariable("userId") Long userId)
    {
        return success(ptsAccountService.selectPtsAccountByUserId(userId));
    }

    /**
     * 新增积分账户
     */
    @RequiresPermissions("points:PtsAccount:add")
    @Log(title = "积分账户", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody PtsAccount ptsAccount)
    {
        return toAjax(ptsAccountService.insertPtsAccount(ptsAccount));
    }

    /**
     * 修改积分账户
     */
    @RequiresPermissions("points:PtsAccount:edit")
    @Log(title = "积分账户", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody PtsAccount ptsAccount)
    {
        return toAjax(ptsAccountService.updatePtsAccount(ptsAccount));
    }

    /**
     * 删除积分账户
     */
    @RequiresPermissions("points:PtsAccount:remove")
    @Log(title = "积分账户", businessType = BusinessType.DELETE)
	@DeleteMapping("/{userIds}")
    public AjaxResult remove(@PathVariable Long[] userIds)
    {
        return toAjax(ptsAccountService.deletePtsAccountByUserIds(userIds));
    }



    /**
     * 默认支付成功
     * @param id
     * @return
     */
    @GetMapping("/getPaymentRecord")
    public PaymentRecord getPaymentRecord(@RequestParam("id") Long id) {
        PaymentRecord paymentRecord = PaymentRecord.builder()
                .id(id)
                .paymentMethod(PaymentMethodEnum.WECHAT.getCode())
                .paymentTime(LocalDateTime.now())
                .status(PaymentStatusEnum.SUCCESS.getCode())
                .build();
        return paymentRecord;
    }
}
