package com.ruoyi.example.domain;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.util.List;
@Data
@TableName("example_orders")
public class ExampleOrdersProducts extends ExampleOrders {

    @TableField(exist = false)
    private List<ExampleProducts> productsList;
}
