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
import com.ruoyi.order.domain.OrdItem;
import com.ruoyi.order.service.IOrdItemService;
import com.ruoyi.common.core.web.controller.BaseController;
import com.ruoyi.common.core.web.domain.AjaxResult;
import com.ruoyi.common.core.utils.poi.ExcelUtil;
import com.ruoyi.common.core.web.page.TableDataInfo;

/**
 * 订单明细Controller
 * 
 * @author 韦亚宁
 * @date 2026-04-27
 */
@RestController
@RequestMapping("/OrdItem")
public class OrdItemController extends BaseController
{
    @Autowired
    private IOrdItemService ordItemService;

    /**
     * 查询订单明细列表
     */
    @RequiresPermissions("order:OrdItem:list")
    @GetMapping("/list")
    public TableDataInfo list(OrdItem ordItem)
    {
        startPage();
        List<OrdItem> list = ordItemService.selectOrdItemList(ordItem);
        return getDataTable(list);
    }

    /**
     * 导出订单明细列表
     */
    @RequiresPermissions("order:OrdItem:export")
    @Log(title = "订单明细", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, OrdItem ordItem)
    {
        List<OrdItem> list = ordItemService.selectOrdItemList(ordItem);
        ExcelUtil<OrdItem> util = new ExcelUtil<OrdItem>(OrdItem.class);
        util.exportExcel(response, list, "订单明细数据");
    }

    /**
     * 获取订单明细详细信息
     */
    @RequiresPermissions("order:OrdItem:query")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(ordItemService.selectOrdItemById(id));
    }

    /**
     * 新增订单明细
     */
    @RequiresPermissions("order:OrdItem:add")
    @Log(title = "订单明细", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody OrdItem ordItem)
    {
        return toAjax(ordItemService.insertOrdItem(ordItem));
    }

    /**
     * 修改订单明细
     */
    @RequiresPermissions("order:OrdItem:edit")
    @Log(title = "订单明细", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody OrdItem ordItem)
    {
        return toAjax(ordItemService.updateOrdItem(ordItem));
    }

    /**
     * 删除订单明细
     */
    @RequiresPermissions("order:OrdItem:remove")
    @Log(title = "订单明细", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(ordItemService.deleteOrdItemByIds(ids));
    }
}
