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
import com.ruoyi.minio.domain.MinioRecord;
import com.ruoyi.minio.service.IMinioRecordService;
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
@RequestMapping("/minio_record")
public class MinioRecordController extends BaseController
{
    @Autowired
    private IMinioRecordService minioRecordService;

    /**
     * 查询minio操作记录列表
     */
    @RequiresPermissions("practice:minio_record:list")
    @GetMapping("/list")
    public TableDataInfo list(MinioRecord minioRecord)
    {
        startPage();
        List<MinioRecord> list = minioRecordService.selectMinioRecordList(minioRecord);
        return getDataTable(list);
    }

    /**
     * 导出minio操作记录列表
     */
    @RequiresPermissions("practice:minio_record:export")
    @Log(title = "minio操作记录", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, MinioRecord minioRecord)
    {
        List<MinioRecord> list = minioRecordService.selectMinioRecordList(minioRecord);
        ExcelUtil<MinioRecord> util = new ExcelUtil<MinioRecord>(MinioRecord.class);
        util.exportExcel(response, list, "minio操作记录数据");
    }

    /**
     * 获取minio操作记录详细信息
     */
    @RequiresPermissions("practice:minio_record:query")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(minioRecordService.selectMinioRecordById(id));
    }

    /**
     * 新增minio操作记录
     */
    @RequiresPermissions("practice:minio_record:add")
    @Log(title = "minio操作记录", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody MinioRecord minioRecord)
    {
        return toAjax(minioRecordService.insertMinioRecord(minioRecord));
    }

    /**
     * 修改minio操作记录
     */
    @RequiresPermissions("practice:minio_record:edit")
    @Log(title = "minio操作记录", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody MinioRecord minioRecord)
    {
        return toAjax(minioRecordService.updateMinioRecord(minioRecord));
    }

    /**
     * 删除minio操作记录
     */
    @RequiresPermissions("practice:minio_record:remove")
    @Log(title = "minio操作记录", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(minioRecordService.deleteMinioRecordByIds(ids));
    }
}
