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
import com.ruoyi.example.domain.ExampleCategories;
import com.ruoyi.example.service.IExampleCategoriesService;
import com.ruoyi.common.core.web.controller.BaseController;
import com.ruoyi.common.core.web.domain.AjaxResult;
import com.ruoyi.common.core.utils.poi.ExcelUtil;
import com.ruoyi.common.core.web.page.TableDataInfo;

/**
 * 存储商品类别的信息Controller
 * 
 * @author ruoyi
 * @date 2025-07-27
 */
@RestController
@RequestMapping("/ExampleCategories")
public class ExampleCategoriesController extends BaseController
{
    @Autowired
    private IExampleCategoriesService exampleCategoriesService;

    /**
     * 查询存储商品类别的信息列表
     */
    @RequiresPermissions("example:ExampleCategories:list")
    @GetMapping("/list")
    public TableDataInfo list(ExampleCategories exampleCategories)
    {
        startPage();
        List<ExampleCategories> list = exampleCategoriesService.selectExampleCategoriesList(exampleCategories);
        return getDataTable(list);
    }

    /**
     * 导出存储商品类别的信息列表
     */
    @RequiresPermissions("example:ExampleCategories:export")
    @Log(title = "存储商品类别的信息", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, ExampleCategories exampleCategories)
    {
        List<ExampleCategories> list = exampleCategoriesService.selectExampleCategoriesList(exampleCategories);
        ExcelUtil<ExampleCategories> util = new ExcelUtil<ExampleCategories>(ExampleCategories.class);
        util.exportExcel(response, list, "存储商品类别的信息数据");
    }

    /**
     * 获取存储商品类别的信息详细信息
     */
    @RequiresPermissions("example:ExampleCategories:query")
    @GetMapping(value = "/{exampleId}")
    public AjaxResult getInfo(@PathVariable("exampleId") Long exampleId)
    {
        return success(exampleCategoriesService.selectExampleCategoriesByExampleId(exampleId));
    }

    /**
     * 新增存储商品类别的信息
     */
    @RequiresPermissions("example:ExampleCategories:add")
    @Log(title = "存储商品类别的信息", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody ExampleCategories exampleCategories)
    {
        return toAjax(exampleCategoriesService.insertExampleCategories(exampleCategories));
    }

    /**
     * 修改存储商品类别的信息
     */
    @RequiresPermissions("example:ExampleCategories:edit")
    @Log(title = "存储商品类别的信息", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody ExampleCategories exampleCategories)
    {
        return toAjax(exampleCategoriesService.updateExampleCategories(exampleCategories));
    }

    /**
     * 删除存储商品类别的信息
     */
    @RequiresPermissions("example:ExampleCategories:remove")
    @Log(title = "存储商品类别的信息", businessType = BusinessType.DELETE)
	@DeleteMapping("/{exampleIds}")
    public AjaxResult remove(@PathVariable Long[] exampleIds)
    {
        return toAjax(exampleCategoriesService.deleteExampleCategoriesByExampleIds(exampleIds));
    }
}
