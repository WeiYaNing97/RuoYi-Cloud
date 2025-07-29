package com.ruoyi.example.controller;

import com.github.yulichang.query.MPJLambdaQueryWrapper;
import com.github.yulichang.wrapper.MPJLambdaWrapper;
import com.ruoyi.common.core.web.domain.AjaxResult;
import com.ruoyi.example.domain.*;
import com.ruoyi.example.mapper.ExampleUsersOrdersMapper;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.List;

/**
 * 存储用户的信息Controller
 *
 * @author ruoyi
 * @date 2025-07-27
 */
@RestController
@RequestMapping("/MPJTest")
public class MPJTestController {

    @Resource
    private ExampleUsersOrdersMapper exampleUsersOrdersMapper;

    /**
     * 注意：
     *
     * - 一条 SQL 只能有一个主表（from 后的表），但可以多次 join 其他表。
     * - 如果你在 join 时引用了还未 join 的表的别名，或者 on 条件写错，就会报“unknown column”之类的错误。
     * - join 顺序要严格按照实体依赖关系（如 用户→订单→订单商品→商品）来写，不能跳级或乱序。
     * 如果你有具体的 join 代码和表结构，可以贴出来，我帮你分析具体原因。
     * @return
     */
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

}
