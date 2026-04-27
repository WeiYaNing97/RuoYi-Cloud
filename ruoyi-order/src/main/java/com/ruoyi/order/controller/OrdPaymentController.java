package com.ruoyi.order.controller;

import java.util.List;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.log.annotation.Log;
import com.ruoyi.common.log.enums.BusinessType;
import com.ruoyi.common.security.annotation.RequiresPermissions;
import com.ruoyi.order.domain.OrdPayment;
import com.ruoyi.order.service.IOrdPaymentService;
import com.ruoyi.common.core.web.controller.BaseController;
import com.ruoyi.common.core.web.domain.AjaxResult;
import com.ruoyi.common.core.utils.poi.ExcelUtil;
import com.ruoyi.common.core.web.page.TableDataInfo;

/**
 * 支付流水Controller
 * 
 * @author 韦亚宁
 * @date 2026-04-27
 */
@RestController
@RequestMapping("/OrdPayment")
public class OrdPaymentController extends BaseController
{
    @Autowired
    private IOrdPaymentService ordPaymentService;

    /**
     * 查询支付流水列表
     */
    @RequiresPermissions("order:OrdPayment:list")
    @GetMapping("/list")
    public TableDataInfo list(OrdPayment ordPayment)
    {
        startPage();
        List<OrdPayment> list = ordPaymentService.selectOrdPaymentList(ordPayment);
        return getDataTable(list);
    }

    /**
     * 导出支付流水列表
     */
    @RequiresPermissions("order:OrdPayment:export")
    @Log(title = "支付流水", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, OrdPayment ordPayment)
    {
        List<OrdPayment> list = ordPaymentService.selectOrdPaymentList(ordPayment);
        ExcelUtil<OrdPayment> util = new ExcelUtil<OrdPayment>(OrdPayment.class);
        util.exportExcel(response, list, "支付流水数据");
    }

    /**
     * 获取支付流水详细信息
     */
    @RequiresPermissions("order:OrdPayment:query")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(ordPaymentService.selectOrdPaymentById(id));
    }

    /**
     * 新增支付流水
     */
    @RequiresPermissions("order:OrdPayment:add")
    @Log(title = "支付流水", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody OrdPayment ordPayment)
    {
        return toAjax(ordPaymentService.insertOrdPayment(ordPayment));
    }

    /**
     * 修改支付流水
     */
    @RequiresPermissions("order:OrdPayment:edit")
    @Log(title = "支付流水", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody OrdPayment ordPayment)
    {
        return toAjax(ordPaymentService.updateOrdPayment(ordPayment));
    }

    /**
     * 删除支付流水
     */
    @RequiresPermissions("order:OrdPayment:remove")
    @Log(title = "支付流水", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(ordPaymentService.deleteOrdPaymentByIds(ids));
    }
}
