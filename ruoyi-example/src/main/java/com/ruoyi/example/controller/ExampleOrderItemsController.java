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
import com.ruoyi.example.domain.ExampleOrderItems;
import com.ruoyi.example.service.IExampleOrderItemsService;
import com.ruoyi.common.core.web.controller.BaseController;
import com.ruoyi.common.core.web.domain.AjaxResult;
import com.ruoyi.common.core.utils.poi.ExcelUtil;
import com.ruoyi.common.core.web.page.TableDataInfo;

/**
 * 存储订单中每种商品的详细信息Controller
 * 
 * @author ruoyi
 * @date 2025-07-27
 */
@RestController
@RequestMapping("/ExampleOrderItems")
public class ExampleOrderItemsController extends BaseController
{
    @Autowired
    private IExampleOrderItemsService exampleOrderItemsService;

    /**
     * 查询存储订单中每种商品的详细信息列表
     */
    @RequiresPermissions("example:ExampleOrderItems:list")
    @GetMapping("/list")
    public TableDataInfo list(ExampleOrderItems exampleOrderItems)
    {
        startPage();
        List<ExampleOrderItems> list = exampleOrderItemsService.selectExampleOrderItemsList(exampleOrderItems);
        return getDataTable(list);
    }

    /**
     * 导出存储订单中每种商品的详细信息列表
     */
    @RequiresPermissions("example:ExampleOrderItems:export")
    @Log(title = "存储订单中每种商品的详细信息", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, ExampleOrderItems exampleOrderItems)
    {
        List<ExampleOrderItems> list = exampleOrderItemsService.selectExampleOrderItemsList(exampleOrderItems);
        ExcelUtil<ExampleOrderItems> util = new ExcelUtil<ExampleOrderItems>(ExampleOrderItems.class);
        util.exportExcel(response, list, "存储订单中每种商品的详细信息数据");
    }

    /**
     * 获取存储订单中每种商品的详细信息详细信息
     */
    @RequiresPermissions("example:ExampleOrderItems:query")
    @GetMapping(value = "/{exampleId}")
    public AjaxResult getInfo(@PathVariable("exampleId") Long exampleId)
    {
        return success(exampleOrderItemsService.selectExampleOrderItemsByExampleId(exampleId));
    }

    /**
     * 新增存储订单中每种商品的详细信息
     */
    @RequiresPermissions("example:ExampleOrderItems:add")
    @Log(title = "存储订单中每种商品的详细信息", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody ExampleOrderItems exampleOrderItems)
    {
        return toAjax(exampleOrderItemsService.insertExampleOrderItems(exampleOrderItems));
    }

    /**
     * 修改存储订单中每种商品的详细信息
     */
    @RequiresPermissions("example:ExampleOrderItems:edit")
    @Log(title = "存储订单中每种商品的详细信息", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody ExampleOrderItems exampleOrderItems)
    {
        return toAjax(exampleOrderItemsService.updateExampleOrderItems(exampleOrderItems));
    }

    /**
     * 删除存储订单中每种商品的详细信息
     */
    @RequiresPermissions("example:ExampleOrderItems:remove")
    @Log(title = "存储订单中每种商品的详细信息", businessType = BusinessType.DELETE)
	@DeleteMapping("/{exampleIds}")
    public AjaxResult remove(@PathVariable Long[] exampleIds)
    {
        return toAjax(exampleOrderItemsService.deleteExampleOrderItemsByExampleIds(exampleIds));
    }
}
