package com.ruoyi.example.controller;

import com.github.yulichang.wrapper.MPJLambdaWrapper;
import com.ruoyi.common.core.utils.poi.ExcelUtil;
import com.ruoyi.common.core.web.controller.BaseController;
import com.ruoyi.common.core.web.domain.AjaxResult;
import com.ruoyi.common.core.web.page.TableDataInfo;
import com.ruoyi.common.log.annotation.Log;
import com.ruoyi.common.log.enums.BusinessType;
import com.ruoyi.common.security.annotation.RequiresPermissions;
import com.ruoyi.example.domain.*;
import com.ruoyi.example.mapper.ExampleUsersVOMapper;
import com.ruoyi.example.service.IExampleUsersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 存储用户的信息Controller
 *
 * @author ruoyi
 * @date 2025-07-27
 */
@RestController
@RequestMapping("/ExampleUsers")
public class ExampleUsersController extends BaseController {
    @Autowired
    private IExampleUsersService exampleUsersService;
    @Resource
    private ExampleUsersVOMapper exampleUsersVOMapper;

    /**
     * 查询存储用户的信息列表
     */
    @RequiresPermissions("example:ExampleUsers:list")
    @GetMapping("/list")
    public TableDataInfo list(ExampleUsers exampleUsers) {

        try {
            MPJLambdaWrapper<ExampleUsersVO> wrapper = new MPJLambdaWrapper<>();
            wrapper.selectAll(ExampleUsersVO.class)
                    .selectAll(ExampleOrdersVO.class)
                    .selectAll(ExampleOrderItemsVO.class)
                    .selectAll(ExampleProductsVO.class)
                    .selectAssociation(ExampleOrdersVO.class, ExampleUsersVO::getExampleOrdersVOs)
                    .selectAssociation(ExampleOrderItemsVO.class, ExampleOrdersVO::getExampleOrderItemsVOs)
                    .selectCollection(ExampleProductsVO.class, ExampleOrderItemsVO::getExampleProductsVOs)
                    .leftJoin(ExampleOrdersVO.class, ExampleOrdersVO::getExampleUserId, ExampleUsersVO::getExampleId)
                    .leftJoin(ExampleOrderItemsVO.class, ExampleOrderItemsVO::getExampleOrderId, ExampleOrdersVO::getExampleId)
                    .leftJoin(ExampleProductsVO.class, ExampleProductsVO::getExampleId, ExampleOrderItemsVO::getExampleProductId);
            List<ExampleUsersVO> exampleUsersVOS = exampleUsersVOMapper.selectJoinList(ExampleUsersVO.class,wrapper);
            exampleUsersVOS.stream().forEach(exampleUsersVO ->{
                System.out.println(exampleUsersVO.toString());
            });
        }catch (Exception e){
            logger.error(e.getMessage(), e);
        }
        startPage();
        List<ExampleUsers> list = exampleUsersService.selectExampleUsersList(exampleUsers);
        return getDataTable(list);
    }

    /**
     * 导出存储用户的信息列表
     */
    @RequiresPermissions("example:ExampleUsers:export")
    @Log(title = "存储用户的信息", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, ExampleUsers exampleUsers) {
        List<ExampleUsers> list = exampleUsersService.selectExampleUsersList(exampleUsers);
        ExcelUtil<ExampleUsers> util = new ExcelUtil<ExampleUsers>(ExampleUsers.class);
        util.exportExcel(response, list, "存储用户的信息数据");
    }

    /**
     * 获取存储用户的信息详细信息
     */
    @RequiresPermissions("example:ExampleUsers:query")
    @GetMapping(value = "/{exampleId}")
    public AjaxResult getInfo(@PathVariable("exampleId") Long exampleId) {
        return success(exampleUsersService.selectExampleUsersByExampleId(exampleId));
    }

    /**
     * 新增存储用户的信息
     */
    @RequiresPermissions("example:ExampleUsers:add")
    @Log(title = "存储用户的信息", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody ExampleUsers exampleUsers) {
        return toAjax(exampleUsersService.insertExampleUsers(exampleUsers));
    }

    /**
     * 修改存储用户的信息
     */
    @RequiresPermissions("example:ExampleUsers:edit")
    @Log(title = "存储用户的信息", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody ExampleUsers exampleUsers) {
        return toAjax(exampleUsersService.updateExampleUsers(exampleUsers));
    }

    /**
     * 删除存储用户的信息
     */
    @RequiresPermissions("example:ExampleUsers:remove")
    @Log(title = "存储用户的信息", businessType = BusinessType.DELETE)
    @DeleteMapping("/{exampleIds}")
    public AjaxResult remove(@PathVariable Long[] exampleIds) {
        return toAjax(exampleUsersService.deleteExampleUsersByExampleIds(exampleIds));
    }
}
