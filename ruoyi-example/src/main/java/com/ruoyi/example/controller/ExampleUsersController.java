package com.ruoyi.example.controller;

import java.util.List;
import java.io.IOException;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import com.github.yulichang.wrapper.MPJLambdaWrapper;
import com.ruoyi.example.domain.*;
import com.ruoyi.example.mapper.ExampleUsersOrdersMapper;
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
import com.ruoyi.example.service.IExampleUsersService;
import com.ruoyi.common.core.web.controller.BaseController;
import com.ruoyi.common.core.web.domain.AjaxResult;
import com.ruoyi.common.core.utils.poi.ExcelUtil;
import com.ruoyi.common.core.web.page.TableDataInfo;

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
    private ExampleUsersOrdersMapper exampleUsersOrdersMapper;

    public AjaxResult getExampleUsersOrdersProducts() {
        MPJLambdaWrapper<ExampleUsersOrders> queryWrapper = new MPJLambdaWrapper<>();
        queryWrapper.selectAll(ExampleUsersOrders.class)
                .selectCollection(ExampleOrdersProducts.class, ExampleUsersOrders::getOrdersProductsList)
                .selectCollection(ExampleProducts.class, ExampleOrdersProducts::getProductsList)
                .leftJoin(ExampleOrders.class, ExampleOrders::getExampleUserId, ExampleUsers::getExampleId)
                .leftJoin(ExampleOrderItems.class, ExampleOrderItems::getExampleOrderId, ExampleOrders::getExampleId)
                .leftJoin(ExampleProducts.class, ExampleProducts::getExampleId, ExampleOrderItems::getExampleProductId);
        List<ExampleUsersOrders> exampleUsersOrders = exampleUsersOrdersMapper.selectJoinList(queryWrapper);
        return AjaxResult.success(exampleUsersOrders);
    }

    /**
     * 查询存储用户的信息列表
     */
    @RequiresPermissions("example:ExampleUsers:list")
    @GetMapping("/list")
    public TableDataInfo list(ExampleUsers exampleUsers) {

        startPage();

        getExampleUsersOrdersProducts();

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
