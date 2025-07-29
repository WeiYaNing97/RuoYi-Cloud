package com.ruoyi.example.domain;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.util.List;

@Data
@TableName("example_users")
public class ExampleUsersOrders extends ExampleUsers{

    @TableField(exist = false)
    private List<ExampleOrdersProducts> ordersProductsList;
}
