package com.ruoyi.example.controller;

import java.util.List;
import java.io.IOException;
import javax.servlet.http.HttpServletResponse;
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
import com.ruoyi.example.domain.ExamplePayments;
import com.ruoyi.example.service.IExamplePaymentsService;
import com.ruoyi.common.core.web.controller.BaseController;
import com.ruoyi.common.core.web.domain.AjaxResult;
import com.ruoyi.common.core.utils.poi.ExcelUtil;
import com.ruoyi.common.core.web.page.TableDataInfo;

/**
 * 存储支付信息Controller
 * 
 * @author ruoyi
 * @date 2025-07-27
 */
@RestController
@RequestMapping("/ExamplePayments")
public class ExamplePaymentsController extends BaseController
{
    @Autowired
    private IExamplePaymentsService examplePaymentsService;

    /**
     * 查询存储支付信息列表
     */
    @RequiresPermissions("example:ExamplePayments:list")
    @GetMapping("/list")
    public TableDataInfo list(ExamplePayments examplePayments)
    {
        startPage();
        List<ExamplePayments> list = examplePaymentsService.selectExamplePaymentsList(examplePayments);
        return getDataTable(list);
    }

    /**
     * 导出存储支付信息列表
     */
    @RequiresPermissions("example:ExamplePayments:export")
    @Log(title = "存储支付信息", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, ExamplePayments examplePayments)
    {
        List<ExamplePayments> list = examplePaymentsService.selectExamplePaymentsList(examplePayments);
        ExcelUtil<ExamplePayments> util = new ExcelUtil<ExamplePayments>(ExamplePayments.class);
        util.exportExcel(response, list, "存储支付信息数据");
    }

    /**
     * 获取存储支付信息详细信息
     */
    @RequiresPermissions("example:ExamplePayments:query")
    @GetMapping(value = "/{exampleId}")
    public AjaxResult getInfo(@PathVariable("exampleId") Long exampleId)
    {
        return success(examplePaymentsService.selectExamplePaymentsByExampleId(exampleId));
    }

    /**
     * 新增存储支付信息
     */
    @RequiresPermissions("example:ExamplePayments:add")
    @Log(title = "存储支付信息", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody ExamplePayments examplePayments)
    {
        return toAjax(examplePaymentsService.insertExamplePayments(examplePayments));
    }

    /**
     * 修改存储支付信息
     */
    @RequiresPermissions("example:ExamplePayments:edit")
    @Log(title = "存储支付信息", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody ExamplePayments examplePayments)
    {
        return toAjax(examplePaymentsService.updateExamplePayments(examplePayments));
    }

    /**
     * 删除存储支付信息
     */
    @RequiresPermissions("example:ExamplePayments:remove")
    @Log(title = "存储支付信息", businessType = BusinessType.DELETE)
	@DeleteMapping("/{exampleIds}")
    public AjaxResult remove(@PathVariable Long[] exampleIds)
    {
        return toAjax(examplePaymentsService.deleteExamplePaymentsByExampleIds(exampleIds));
    }
}
