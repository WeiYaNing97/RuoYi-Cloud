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
import com.ruoyi.example.domain.ExampleProducts;
import com.ruoyi.example.service.IExampleProductsService;
import com.ruoyi.common.core.web.controller.BaseController;
import com.ruoyi.common.core.web.domain.AjaxResult;
import com.ruoyi.common.core.utils.poi.ExcelUtil;
import com.ruoyi.common.core.web.page.TableDataInfo;

/**
 * 存储商品的信息Controller
 * 
 * @author ruoyi
 * @date 2025-07-27
 */
@RestController
@RequestMapping("/ExampleProducts")
public class ExampleProductsController extends BaseController
{
    @Autowired
    private IExampleProductsService exampleProductsService;

    /**
     * 查询存储商品的信息列表
     */
    @RequiresPermissions("example:ExampleProducts:list")
    @GetMapping("/list")
    public TableDataInfo list(ExampleProducts exampleProducts)
    {
        startPage();
        List<ExampleProducts> list = exampleProductsService.selectExampleProductsList(exampleProducts);
        return getDataTable(list);
    }

    /**
     * 导出存储商品的信息列表
     */
    @RequiresPermissions("example:ExampleProducts:export")
    @Log(title = "存储商品的信息", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, ExampleProducts exampleProducts)
    {
        List<ExampleProducts> list = exampleProductsService.selectExampleProductsList(exampleProducts);
        ExcelUtil<ExampleProducts> util = new ExcelUtil<ExampleProducts>(ExampleProducts.class);
        util.exportExcel(response, list, "存储商品的信息数据");
    }

    /**
     * 获取存储商品的信息详细信息
     */
    @RequiresPermissions("example:ExampleProducts:query")
    @GetMapping(value = "/{exampleId}")
    public AjaxResult getInfo(@PathVariable("exampleId") Long exampleId)
    {
        return success(exampleProductsService.selectExampleProductsByExampleId(exampleId));
    }

    /**
     * 新增存储商品的信息
     */
    @RequiresPermissions("example:ExampleProducts:add")
    @Log(title = "存储商品的信息", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody ExampleProducts exampleProducts)
    {
        return toAjax(exampleProductsService.insertExampleProducts(exampleProducts));
    }

    /**
     * 修改存储商品的信息
     */
    @RequiresPermissions("example:ExampleProducts:edit")
    @Log(title = "存储商品的信息", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody ExampleProducts exampleProducts)
    {
        return toAjax(exampleProductsService.updateExampleProducts(exampleProducts));
    }

    /**
     * 删除存储商品的信息
     */
    @RequiresPermissions("example:ExampleProducts:remove")
    @Log(title = "存储商品的信息", businessType = BusinessType.DELETE)
	@DeleteMapping("/{exampleIds}")
    public AjaxResult remove(@PathVariable Long[] exampleIds)
    {
        return toAjax(exampleProductsService.deleteExampleProductsByExampleIds(exampleIds));
    }
}
