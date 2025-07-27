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
import com.ruoyi.example.domain.ExampleOrders;
import com.ruoyi.example.service.IExampleOrdersService;
import com.ruoyi.common.core.web.controller.BaseController;
import com.ruoyi.common.core.web.domain.AjaxResult;
import com.ruoyi.common.core.utils.poi.ExcelUtil;
import com.ruoyi.common.core.web.page.TableDataInfo;

/**
 * 存储订单的信息Controller
 * 
 * @author ruoyi
 * @date 2025-07-27
 */
@RestController
@RequestMapping("/ExampleOrders")
public class ExampleOrdersController extends BaseController
{
    @Autowired
    private IExampleOrdersService exampleOrdersService;

    /**
     * 查询存储订单的信息列表
     */
    @RequiresPermissions("example:ExampleOrders:list")
    @GetMapping("/list")
    public TableDataInfo list(ExampleOrders exampleOrders)
    {
        startPage();
        List<ExampleOrders> list = exampleOrdersService.selectExampleOrdersList(exampleOrders);
        return getDataTable(list);
    }

    /**
     * 导出存储订单的信息列表
     */
    @RequiresPermissions("example:ExampleOrders:export")
    @Log(title = "存储订单的信息", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, ExampleOrders exampleOrders)
    {
        List<ExampleOrders> list = exampleOrdersService.selectExampleOrdersList(exampleOrders);
        ExcelUtil<ExampleOrders> util = new ExcelUtil<ExampleOrders>(ExampleOrders.class);
        util.exportExcel(response, list, "存储订单的信息数据");
    }

    /**
     * 获取存储订单的信息详细信息
     */
    @RequiresPermissions("example:ExampleOrders:query")
    @GetMapping(value = "/{exampleId}")
    public AjaxResult getInfo(@PathVariable("exampleId") Long exampleId)
    {
        return success(exampleOrdersService.selectExampleOrdersByExampleId(exampleId));
    }

    /**
     * 新增存储订单的信息
     */
    @RequiresPermissions("example:ExampleOrders:add")
    @Log(title = "存储订单的信息", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody ExampleOrders exampleOrders)
    {
        return toAjax(exampleOrdersService.insertExampleOrders(exampleOrders));
    }

    /**
     * 修改存储订单的信息
     */
    @RequiresPermissions("example:ExampleOrders:edit")
    @Log(title = "存储订单的信息", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody ExampleOrders exampleOrders)
    {
        return toAjax(exampleOrdersService.updateExampleOrders(exampleOrders));
    }

    /**
     * 删除存储订单的信息
     */
    @RequiresPermissions("example:ExampleOrders:remove")
    @Log(title = "存储订单的信息", businessType = BusinessType.DELETE)
	@DeleteMapping("/{exampleIds}")
    public AjaxResult remove(@PathVariable Long[] exampleIds)
    {
        return toAjax(exampleOrdersService.deleteExampleOrdersByExampleIds(exampleIds));
    }
}
