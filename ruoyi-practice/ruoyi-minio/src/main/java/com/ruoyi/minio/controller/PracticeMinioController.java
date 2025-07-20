package com.ruoyi.minio.controller;

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
import com.ruoyi.minio.domain.PracticeMinio;
import com.ruoyi.minio.service.IPracticeMinioService;
import com.ruoyi.common.core.web.controller.BaseController;
import com.ruoyi.common.core.web.domain.AjaxResult;
import com.ruoyi.common.core.utils.poi.ExcelUtil;
import com.ruoyi.common.core.web.page.TableDataInfo;

/**
 * minio操作记录Controller
 * 
 * @author ruoyi
 * @date 2025-07-20
 */
@RestController
@RequestMapping("/practice_minio")
public class PracticeMinioController extends BaseController
{
    @Autowired
    private IPracticeMinioService practiceMinioService;

    /**
     * 查询minio操作记录列表
     */
    @RequiresPermissions("minio:practice_minio:list")
    @GetMapping("/list")
    public TableDataInfo list(PracticeMinio practiceMinio)
    {
        startPage();
        List<PracticeMinio> list = practiceMinioService.selectPracticeMinioList(practiceMinio);
        return getDataTable(list);
    }

    /**
     * 导出minio操作记录列表
     */
    @RequiresPermissions("minio:practice_minio:export")
    @Log(title = "minio操作记录", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, PracticeMinio practiceMinio)
    {
        List<PracticeMinio> list = practiceMinioService.selectPracticeMinioList(practiceMinio);
        ExcelUtil<PracticeMinio> util = new ExcelUtil<PracticeMinio>(PracticeMinio.class);
        util.exportExcel(response, list, "minio操作记录数据");
    }

    /**
     * 获取minio操作记录详细信息
     */
    @RequiresPermissions("minio:practice_minio:query")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(practiceMinioService.selectPracticeMinioById(id));
    }

    /**
     * 新增minio操作记录
     */
    @RequiresPermissions("minio:practice_minio:add")
    @Log(title = "minio操作记录", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody PracticeMinio practiceMinio)
    {
        return toAjax(practiceMinioService.insertPracticeMinio(practiceMinio));
    }

    /**
     * 修改minio操作记录
     */
    @RequiresPermissions("minio:practice_minio:edit")
    @Log(title = "minio操作记录", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody PracticeMinio practiceMinio)
    {
        return toAjax(practiceMinioService.updatePracticeMinio(practiceMinio));
    }

    /**
     * 删除minio操作记录
     */
    @RequiresPermissions("minio:practice_minio:remove")
    @Log(title = "minio操作记录", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(practiceMinioService.deletePracticeMinioByIds(ids));
    }
}
