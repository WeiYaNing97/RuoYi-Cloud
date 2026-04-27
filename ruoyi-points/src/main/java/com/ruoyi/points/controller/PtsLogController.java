package com.ruoyi.points.controller;

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
import com.ruoyi.points.domain.PtsLog;
import com.ruoyi.points.service.IPtsLogService;
import com.ruoyi.common.core.web.controller.BaseController;
import com.ruoyi.common.core.web.domain.AjaxResult;
import com.ruoyi.common.core.utils.poi.ExcelUtil;
import com.ruoyi.common.core.web.page.TableDataInfo;

/**
 * 积分流水Controller
 * 
 * @author 韦亚宁
 * @date 2026-04-27
 */
@RestController
@RequestMapping("/PtsLog")
public class PtsLogController extends BaseController
{
    @Autowired
    private IPtsLogService ptsLogService;

    /**
     * 查询积分流水列表
     */
    @RequiresPermissions("points:PtsLog:list")
    @GetMapping("/list")
    public TableDataInfo list(PtsLog ptsLog)
    {
        startPage();
        List<PtsLog> list = ptsLogService.selectPtsLogList(ptsLog);
        return getDataTable(list);
    }

    /**
     * 导出积分流水列表
     */
    @RequiresPermissions("points:PtsLog:export")
    @Log(title = "积分流水", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, PtsLog ptsLog)
    {
        List<PtsLog> list = ptsLogService.selectPtsLogList(ptsLog);
        ExcelUtil<PtsLog> util = new ExcelUtil<PtsLog>(PtsLog.class);
        util.exportExcel(response, list, "积分流水数据");
    }

    /**
     * 获取积分流水详细信息
     */
    @RequiresPermissions("points:PtsLog:query")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(ptsLogService.selectPtsLogById(id));
    }

    /**
     * 新增积分流水
     */
    @RequiresPermissions("points:PtsLog:add")
    @Log(title = "积分流水", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody PtsLog ptsLog)
    {
        return toAjax(ptsLogService.insertPtsLog(ptsLog));
    }

    /**
     * 修改积分流水
     */
    @RequiresPermissions("points:PtsLog:edit")
    @Log(title = "积分流水", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody PtsLog ptsLog)
    {
        return toAjax(ptsLogService.updatePtsLog(ptsLog));
    }

    /**
     * 删除积分流水
     */
    @RequiresPermissions("points:PtsLog:remove")
    @Log(title = "积分流水", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(ptsLogService.deletePtsLogByIds(ids));
    }
}
