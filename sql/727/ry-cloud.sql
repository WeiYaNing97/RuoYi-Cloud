/*
 Navicat Premium Dump SQL

 Source Server         : MySQL
 Source Server Type    : MySQL
 Source Server Version : 80018 (8.0.18)
 Source Host           : localhost:3306
 Source Schema         : ry-cloud

 Target Server Type    : MySQL
 Target Server Version : 80018 (8.0.18)
 File Encoding         : 65001

 Date: 27/07/2025 22:14:35
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for example_categories
-- ----------------------------
DROP TABLE IF EXISTS `example_categories`;
CREATE TABLE `example_categories`  (
  `example_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '类别的唯一标识符',
  `category_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '类别的名称',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '类别的描述信息',
  `example_parent_id` int(11) NULL DEFAULT NULL COMMENT '父类别的ID，NULL表示顶级类别',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录最后更新时间',
  PRIMARY KEY (`example_id`) USING BTREE,
  UNIQUE INDEX `category_name`(`category_name` ASC) USING BTREE,
  INDEX `example_parent_id`(`example_parent_id` ASC) USING BTREE,
  CONSTRAINT `example_categories_ibfk_1` FOREIGN KEY (`example_parent_id`) REFERENCES `example_categories` (`example_id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '存储商品类别的信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of example_categories
-- ----------------------------

-- ----------------------------
-- Table structure for example_order_items
-- ----------------------------
DROP TABLE IF EXISTS `example_order_items`;
CREATE TABLE `example_order_items`  (
  `example_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '订单项的唯一标识符',
  `example_order_id` int(11) NOT NULL COMMENT '关联订单的ID',
  `example_product_id` int(11) NOT NULL COMMENT '商品的ID',
  `quantity` int(11) NOT NULL COMMENT '商品数量',
  `unit_price` decimal(10, 2) NOT NULL COMMENT '单价',
  `total_price` decimal(10, 2) NOT NULL COMMENT '总价',
  `product_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '商品名称',
  `sku` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '商品库存保有单位(SKU)',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'normal' COMMENT '订单项状态（例如：normal, returned, exchanged）',
  PRIMARY KEY (`example_id`) USING BTREE,
  INDEX `example_order_id`(`example_order_id` ASC) USING BTREE,
  INDEX `example_product_id`(`example_product_id` ASC) USING BTREE,
  CONSTRAINT `example_order_items_ibfk_1` FOREIGN KEY (`example_order_id`) REFERENCES `example_orders` (`example_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `example_order_items_ibfk_2` FOREIGN KEY (`example_product_id`) REFERENCES `example_products` (`example_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `example_order_items_chk_1` CHECK (`quantity` > 0)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '存储订单中每种商品的详细信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of example_order_items
-- ----------------------------

-- ----------------------------
-- Table structure for example_orders
-- ----------------------------
DROP TABLE IF EXISTS `example_orders`;
CREATE TABLE `example_orders`  (
  `example_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '订单的唯一标识符',
  `example_user_id` int(11) NOT NULL COMMENT '下单用户的ID',
  `order_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '下单日期',
  `total_amount` decimal(12, 2) NOT NULL COMMENT '订单总金额',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'pending' COMMENT '订单状态（例如：pending, shipped, delivered, cancelled）',
  `shipping_address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '收货地址',
  `shipping_method` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '配送方式',
  `payment_method` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '支付方式',
  `tracking_number` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '物流追踪号码',
  `remark` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '备注信息',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录最后更新时间',
  PRIMARY KEY (`example_id`) USING BTREE,
  INDEX `example_user_id`(`example_user_id` ASC) USING BTREE,
  CONSTRAINT `example_orders_ibfk_1` FOREIGN KEY (`example_user_id`) REFERENCES `example_users` (`example_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '存储订单的信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of example_orders
-- ----------------------------

-- ----------------------------
-- Table structure for example_payments
-- ----------------------------
DROP TABLE IF EXISTS `example_payments`;
CREATE TABLE `example_payments`  (
  `example_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '支付记录的唯一标识符',
  `example_order_id` int(11) NOT NULL COMMENT '关联订单的ID',
  `payment_method` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '支付方式',
  `amount` decimal(12, 2) NOT NULL COMMENT '支付金额',
  `payment_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'pending' COMMENT '支付状态（例如：pending, completed, failed）',
  `payment_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '支付日期',
  `transaction_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '交易编号',
  `payment_channel` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '支付渠道',
  `extra_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '额外信息',
  PRIMARY KEY (`example_id`) USING BTREE,
  UNIQUE INDEX `transaction_id`(`transaction_id` ASC) USING BTREE,
  INDEX `example_order_id`(`example_order_id` ASC) USING BTREE,
  CONSTRAINT `example_payments_ibfk_1` FOREIGN KEY (`example_order_id`) REFERENCES `example_orders` (`example_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '存储支付信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of example_payments
-- ----------------------------

-- ----------------------------
-- Table structure for example_products
-- ----------------------------
DROP TABLE IF EXISTS `example_products`;
CREATE TABLE `example_products`  (
  `example_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '商品的唯一标识符',
  `product_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '商品名称',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '商品描述',
  `price` decimal(10, 2) NOT NULL COMMENT '商品价格',
  `example_category_id` int(11) NOT NULL COMMENT '所属类别ID',
  `stock_quantity` int(11) NOT NULL DEFAULT 0 COMMENT '库存数量',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'active' COMMENT '商品状态（例如：active, inactive）',
  `sku` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '商品库存保有单位(SKU)',
  `image_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '商品图片URL',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录最后更新时间',
  PRIMARY KEY (`example_id`) USING BTREE,
  UNIQUE INDEX `sku`(`sku` ASC) USING BTREE,
  INDEX `example_category_id`(`example_category_id` ASC) USING BTREE,
  CONSTRAINT `example_products_ibfk_1` FOREIGN KEY (`example_category_id`) REFERENCES `example_categories` (`example_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `example_products_chk_1` CHECK (`price` >= 0)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '存储商品的信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of example_products
-- ----------------------------

-- ----------------------------
-- Table structure for example_users
-- ----------------------------
DROP TABLE IF EXISTS `example_users`;
CREATE TABLE `example_users`  (
  `example_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户的唯一标识符',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '用户名',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '用户邮箱地址',
  `password_hash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '用户密码哈希值',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '用户联系电话',
  `avatar_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '用户头像URL',
  `role` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'user' COMMENT '用户角色（例如：user, admin）',
  `is_active` tinyint(1) NOT NULL DEFAULT 1 COMMENT '用户账户是否激活',
  `last_login` timestamp NULL DEFAULT NULL COMMENT '用户上次登录时间',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录最后更新时间',
  PRIMARY KEY (`example_id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE,
  UNIQUE INDEX `email`(`email` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '存储用户的信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of example_users
-- ----------------------------

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '代码生成业务表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES (3, 'example_order_items', '存储订单中每种商品的详细信息', NULL, NULL, 'ExampleOrderItems', 'crud', 'element-ui', 'com.ruoyi.example', 'example', 'ExampleOrderItems', '存储订单中每种商品的详细信息', 'ruoyi', '0', '/', '{\"parentMenuId\":2029}', 'admin', '2025-07-27 21:59:25', '', '2025-07-27 22:05:35', NULL);
INSERT INTO `gen_table` VALUES (4, 'example_orders', '存储订单的信息', NULL, NULL, 'ExampleOrders', 'crud', 'element-ui', 'com.ruoyi.example', 'example', 'ExampleOrders', '存储订单的信息', 'ruoyi', '0', '/', '{\"parentMenuId\":2029}', 'admin', '2025-07-27 21:59:25', '', '2025-07-27 22:06:19', NULL);
INSERT INTO `gen_table` VALUES (5, 'example_payments', '存储支付信息', NULL, NULL, 'ExamplePayments', 'crud', 'element-ui', 'com.ruoyi.example', 'example', 'ExamplePayments', '存储支付信息', 'ruoyi', '0', '/', '{\"parentMenuId\":2029}', 'admin', '2025-07-27 21:59:25', '', '2025-07-27 22:07:01', NULL);
INSERT INTO `gen_table` VALUES (6, 'example_products', '存储商品的信息', NULL, NULL, 'ExampleProducts', 'crud', 'element-ui', 'com.ruoyi.example', 'example', 'ExampleProducts', '存储商品的信息', 'ruoyi', '0', '/', '{\"parentMenuId\":2029}', 'admin', '2025-07-27 21:59:42', '', '2025-07-27 22:03:32', NULL);
INSERT INTO `gen_table` VALUES (7, 'example_users', '存储用户的信息', NULL, NULL, 'ExampleUsers', 'crud', 'element-ui', 'com.ruoyi.example', 'example', 'ExampleUsers', '存储用户的信息', 'ruoyi', '0', '/', '{\"parentMenuId\":2029}', 'admin', '2025-07-27 21:59:42', '', '2025-07-27 22:04:32', NULL);
INSERT INTO `gen_table` VALUES (8, 'example_categories', '存储商品类别的信息', NULL, NULL, 'ExampleCategories', 'crud', 'element-ui', 'com.ruoyi.example', 'example', 'ExampleCategories', '存储商品类别的信息', 'ruoyi', '0', '/', '{\"parentMenuId\":2029}', 'admin', '2025-07-27 21:59:54', '', '2025-07-27 22:03:47', NULL);

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint(20) NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '字典类型',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 77 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '代码生成业务表字段' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES (19, 3, 'example_id', '订单项的唯一标识符', 'int(11)', 'Long', 'exampleId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-07-27 21:59:25', '', '2025-07-27 22:05:35');
INSERT INTO `gen_table_column` VALUES (20, 3, 'example_order_id', '关联订单的ID', 'int(11)', 'Long', 'exampleOrderId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2025-07-27 21:59:25', '', '2025-07-27 22:05:35');
INSERT INTO `gen_table_column` VALUES (21, 3, 'example_product_id', '商品的ID', 'int(11)', 'Long', 'exampleProductId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2025-07-27 21:59:25', '', '2025-07-27 22:05:35');
INSERT INTO `gen_table_column` VALUES (22, 3, 'quantity', '商品数量', 'int(11)', 'Long', 'quantity', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2025-07-27 21:59:25', '', '2025-07-27 22:05:35');
INSERT INTO `gen_table_column` VALUES (23, 3, 'unit_price', '单价', 'decimal(10,2)', 'BigDecimal', 'unitPrice', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2025-07-27 21:59:25', '', '2025-07-27 22:05:35');
INSERT INTO `gen_table_column` VALUES (24, 3, 'total_price', '总价', 'decimal(10,2)', 'BigDecimal', 'totalPrice', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2025-07-27 21:59:25', '', '2025-07-27 22:05:35');
INSERT INTO `gen_table_column` VALUES (25, 3, 'product_name', '商品名称', 'varchar(255)', 'String', 'productName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 7, 'admin', '2025-07-27 21:59:25', '', '2025-07-27 22:05:35');
INSERT INTO `gen_table_column` VALUES (26, 3, 'sku', '商品库存保有单位(SKU)', 'varchar(100)', 'String', 'sku', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 8, 'admin', '2025-07-27 21:59:25', '', '2025-07-27 22:05:35');
INSERT INTO `gen_table_column` VALUES (27, 3, 'status', '订单项状态（例如：normal, returned, exchanged）', 'varchar(20)', 'String', 'status', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'radio', '', 9, 'admin', '2025-07-27 21:59:25', '', '2025-07-27 22:05:35');
INSERT INTO `gen_table_column` VALUES (28, 4, 'example_id', '订单的唯一标识符', 'int(11)', 'Long', 'exampleId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-07-27 21:59:25', '', '2025-07-27 22:06:19');
INSERT INTO `gen_table_column` VALUES (29, 4, 'example_user_id', '下单用户的ID', 'int(11)', 'Long', 'exampleUserId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2025-07-27 21:59:25', '', '2025-07-27 22:06:19');
INSERT INTO `gen_table_column` VALUES (30, 4, 'order_date', '下单日期', 'timestamp', 'Date', 'orderDate', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 3, 'admin', '2025-07-27 21:59:25', '', '2025-07-27 22:06:19');
INSERT INTO `gen_table_column` VALUES (31, 4, 'total_amount', '订单总金额', 'decimal(12,2)', 'BigDecimal', 'totalAmount', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2025-07-27 21:59:25', '', '2025-07-27 22:06:19');
INSERT INTO `gen_table_column` VALUES (32, 4, 'status', '订单状态（例如：pending, shipped, delivered, cancelled）', 'varchar(20)', 'String', 'status', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'radio', '', 5, 'admin', '2025-07-27 21:59:25', '', '2025-07-27 22:06:19');
INSERT INTO `gen_table_column` VALUES (33, 4, 'shipping_address', '收货地址', 'text', 'String', 'shippingAddress', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'textarea', '', 6, 'admin', '2025-07-27 21:59:25', '', '2025-07-27 22:06:19');
INSERT INTO `gen_table_column` VALUES (34, 4, 'shipping_method', '配送方式', 'varchar(50)', 'String', 'shippingMethod', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2025-07-27 21:59:25', '', '2025-07-27 22:06:19');
INSERT INTO `gen_table_column` VALUES (35, 4, 'payment_method', '支付方式', 'varchar(50)', 'String', 'paymentMethod', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 8, 'admin', '2025-07-27 21:59:25', '', '2025-07-27 22:06:19');
INSERT INTO `gen_table_column` VALUES (36, 4, 'tracking_number', '物流追踪号码', 'varchar(100)', 'String', 'trackingNumber', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 9, 'admin', '2025-07-27 21:59:25', '', '2025-07-27 22:06:19');
INSERT INTO `gen_table_column` VALUES (37, 4, 'remark', '备注信息', 'text', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 10, 'admin', '2025-07-27 21:59:25', '', '2025-07-27 22:06:19');
INSERT INTO `gen_table_column` VALUES (38, 4, 'created_at', '记录创建时间', 'timestamp', 'Date', 'createdAt', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 11, 'admin', '2025-07-27 21:59:25', '', '2025-07-27 22:06:19');
INSERT INTO `gen_table_column` VALUES (39, 4, 'updated_at', '记录最后更新时间', 'timestamp', 'Date', 'updatedAt', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 12, 'admin', '2025-07-27 21:59:25', '', '2025-07-27 22:06:19');
INSERT INTO `gen_table_column` VALUES (40, 5, 'example_id', '支付记录的唯一标识符', 'int(11)', 'Long', 'exampleId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-07-27 21:59:25', '', '2025-07-27 22:07:01');
INSERT INTO `gen_table_column` VALUES (41, 5, 'example_order_id', '关联订单的ID', 'int(11)', 'Long', 'exampleOrderId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2025-07-27 21:59:25', '', '2025-07-27 22:07:01');
INSERT INTO `gen_table_column` VALUES (42, 5, 'payment_method', '支付方式', 'varchar(50)', 'String', 'paymentMethod', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2025-07-27 21:59:25', '', '2025-07-27 22:07:01');
INSERT INTO `gen_table_column` VALUES (43, 5, 'amount', '支付金额', 'decimal(12,2)', 'BigDecimal', 'amount', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2025-07-27 21:59:25', '', '2025-07-27 22:07:01');
INSERT INTO `gen_table_column` VALUES (44, 5, 'payment_status', '支付状态（例如：pending, completed, failed）', 'varchar(20)', 'String', 'paymentStatus', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'radio', '', 5, 'admin', '2025-07-27 21:59:25', '', '2025-07-27 22:07:01');
INSERT INTO `gen_table_column` VALUES (45, 5, 'payment_date', '支付日期', 'timestamp', 'Date', 'paymentDate', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 6, 'admin', '2025-07-27 21:59:25', '', '2025-07-27 22:07:01');
INSERT INTO `gen_table_column` VALUES (46, 5, 'transaction_id', '交易编号', 'varchar(100)', 'String', 'transactionId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2025-07-27 21:59:25', '', '2025-07-27 22:07:01');
INSERT INTO `gen_table_column` VALUES (47, 5, 'payment_channel', '支付渠道', 'varchar(50)', 'String', 'paymentChannel', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 8, 'admin', '2025-07-27 21:59:25', '', '2025-07-27 22:07:01');
INSERT INTO `gen_table_column` VALUES (48, 5, 'extra_info', '额外信息', 'text', 'String', 'extraInfo', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'textarea', '', 9, 'admin', '2025-07-27 21:59:25', '', '2025-07-27 22:07:01');
INSERT INTO `gen_table_column` VALUES (49, 6, 'example_id', '商品的唯一标识符', 'int(11)', 'Long', 'exampleId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-07-27 21:59:42', '', '2025-07-27 22:03:32');
INSERT INTO `gen_table_column` VALUES (50, 6, 'product_name', '商品名称', 'varchar(255)', 'String', 'productName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2025-07-27 21:59:42', '', '2025-07-27 22:03:32');
INSERT INTO `gen_table_column` VALUES (51, 6, 'description', '商品描述', 'text', 'String', 'description', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'textarea', '', 3, 'admin', '2025-07-27 21:59:42', '', '2025-07-27 22:03:32');
INSERT INTO `gen_table_column` VALUES (52, 6, 'price', '商品价格', 'decimal(10,2)', 'BigDecimal', 'price', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2025-07-27 21:59:42', '', '2025-07-27 22:03:32');
INSERT INTO `gen_table_column` VALUES (53, 6, 'example_category_id', '所属类别ID', 'int(11)', 'Long', 'exampleCategoryId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2025-07-27 21:59:42', '', '2025-07-27 22:03:32');
INSERT INTO `gen_table_column` VALUES (54, 6, 'stock_quantity', '库存数量', 'int(11)', 'Long', 'stockQuantity', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2025-07-27 21:59:42', '', '2025-07-27 22:03:32');
INSERT INTO `gen_table_column` VALUES (55, 6, 'status', '商品状态（例如：active, inactive）', 'varchar(20)', 'String', 'status', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'radio', '', 7, 'admin', '2025-07-27 21:59:42', '', '2025-07-27 22:03:32');
INSERT INTO `gen_table_column` VALUES (56, 6, 'sku', '商品库存保有单位(SKU)', 'varchar(100)', 'String', 'sku', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 8, 'admin', '2025-07-27 21:59:42', '', '2025-07-27 22:03:32');
INSERT INTO `gen_table_column` VALUES (57, 6, 'image_url', '商品图片URL', 'varchar(512)', 'String', 'imageUrl', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'textarea', '', 9, 'admin', '2025-07-27 21:59:42', '', '2025-07-27 22:03:32');
INSERT INTO `gen_table_column` VALUES (58, 6, 'created_at', '记录创建时间', 'timestamp', 'Date', 'createdAt', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 10, 'admin', '2025-07-27 21:59:42', '', '2025-07-27 22:03:32');
INSERT INTO `gen_table_column` VALUES (59, 6, 'updated_at', '记录最后更新时间', 'timestamp', 'Date', 'updatedAt', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 11, 'admin', '2025-07-27 21:59:42', '', '2025-07-27 22:03:32');
INSERT INTO `gen_table_column` VALUES (60, 7, 'example_id', '用户的唯一标识符', 'int(11)', 'Long', 'exampleId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-07-27 21:59:42', '', '2025-07-27 22:04:32');
INSERT INTO `gen_table_column` VALUES (61, 7, 'username', '用户名', 'varchar(50)', 'String', 'username', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2025-07-27 21:59:42', '', '2025-07-27 22:04:32');
INSERT INTO `gen_table_column` VALUES (62, 7, 'email', '用户邮箱地址', 'varchar(100)', 'String', 'email', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2025-07-27 21:59:42', '', '2025-07-27 22:04:32');
INSERT INTO `gen_table_column` VALUES (63, 7, 'password_hash', '用户密码哈希值', 'varchar(255)', 'String', 'passwordHash', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2025-07-27 21:59:42', '', '2025-07-27 22:04:32');
INSERT INTO `gen_table_column` VALUES (64, 7, 'phone', '用户联系电话', 'varchar(20)', 'String', 'phone', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2025-07-27 21:59:42', '', '2025-07-27 22:04:32');
INSERT INTO `gen_table_column` VALUES (65, 7, 'avatar_url', '用户头像URL', 'varchar(512)', 'String', 'avatarUrl', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'textarea', '', 6, 'admin', '2025-07-27 21:59:42', '', '2025-07-27 22:04:32');
INSERT INTO `gen_table_column` VALUES (66, 7, 'role', '用户角色（例如：user, admin）', 'varchar(20)', 'String', 'role', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2025-07-27 21:59:42', '', '2025-07-27 22:04:32');
INSERT INTO `gen_table_column` VALUES (67, 7, 'is_active', '用户账户是否激活', 'tinyint(1)', 'Integer', 'isActive', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 8, 'admin', '2025-07-27 21:59:42', '', '2025-07-27 22:04:32');
INSERT INTO `gen_table_column` VALUES (68, 7, 'last_login', '用户上次登录时间', 'timestamp', 'Date', 'lastLogin', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 9, 'admin', '2025-07-27 21:59:42', '', '2025-07-27 22:04:32');
INSERT INTO `gen_table_column` VALUES (69, 7, 'created_at', '记录创建时间', 'timestamp', 'Date', 'createdAt', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 10, 'admin', '2025-07-27 21:59:42', '', '2025-07-27 22:04:32');
INSERT INTO `gen_table_column` VALUES (70, 7, 'updated_at', '记录最后更新时间', 'timestamp', 'Date', 'updatedAt', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 11, 'admin', '2025-07-27 21:59:42', '', '2025-07-27 22:04:32');
INSERT INTO `gen_table_column` VALUES (71, 8, 'example_id', '类别的唯一标识符', 'int(11)', 'Long', 'exampleId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-07-27 21:59:54', '', '2025-07-27 22:03:47');
INSERT INTO `gen_table_column` VALUES (72, 8, 'category_name', '类别的名称', 'varchar(100)', 'String', 'categoryName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2025-07-27 21:59:54', '', '2025-07-27 22:03:47');
INSERT INTO `gen_table_column` VALUES (73, 8, 'description', '类别的描述信息', 'text', 'String', 'description', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'textarea', '', 3, 'admin', '2025-07-27 21:59:54', '', '2025-07-27 22:03:47');
INSERT INTO `gen_table_column` VALUES (74, 8, 'example_parent_id', '父类别的ID，NULL表示顶级类别', 'int(11)', 'Long', 'exampleParentId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2025-07-27 21:59:54', '', '2025-07-27 22:03:47');
INSERT INTO `gen_table_column` VALUES (75, 8, 'created_at', '记录创建时间', 'timestamp', 'Date', 'createdAt', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 5, 'admin', '2025-07-27 21:59:54', '', '2025-07-27 22:03:47');
INSERT INTO `gen_table_column` VALUES (76, 8, 'updated_at', '记录最后更新时间', 'timestamp', 'Date', 'updatedAt', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 6, 'admin', '2025-07-27 21:59:54', '', '2025-07-27 22:03:47');

-- ----------------------------
-- Table structure for minio_record
-- ----------------------------
DROP TABLE IF EXISTS `minio_record`;
CREATE TABLE `minio_record`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `file_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '文件名',
  `file_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '文件路径',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = 'minio操作记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of minio_record
-- ----------------------------

-- ----------------------------
-- Table structure for practice_minio
-- ----------------------------
DROP TABLE IF EXISTS `practice_minio`;
CREATE TABLE `practice_minio`  (
  `id` int(11) NOT NULL COMMENT '主键',
  `filed_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '文件名称',
  `filed_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '文件路径',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = 'minio操作记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of practice_minio
-- ----------------------------
INSERT INTO `practice_minio` VALUES (1, 'user_template_17529975158921753006226861.xlsx', 'user_template_17529975158921753006226861.xlsx', '0', 'admin', '2025-07-20 18:10:27', '', NULL, NULL);
INSERT INTO `practice_minio` VALUES (2, 'user_template_17529975158921753009335953.xlsx', 'user_template_17529975158921753009335953.xlsx', '0', 'admin', '2025-07-20 19:02:16', '', NULL, NULL);

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `blob_data` blob NULL COMMENT '存放持久化Trigger对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = 'Blob类型的触发器表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '调度名称',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '日历名称',
  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
  PRIMARY KEY (`sched_name`, `calendar_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '日历信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `cron_expression` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'cron表达式',
  `time_zone_id` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = 'Cron类型的触发器表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '调度名称',
  `entry_id` varchar(95) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '调度器实例id',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '调度器实例名',
  `fired_time` bigint(13) NOT NULL COMMENT '触发的时间',
  `sched_time` bigint(13) NOT NULL COMMENT '定时器制定的时间',
  `priority` int(11) NOT NULL COMMENT '优先级',
  `state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '状态',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '任务组名',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '是否并发',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '是否接受恢复执行',
  PRIMARY KEY (`sched_name`, `entry_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '已触发的触发器表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '调度名称',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '任务组名',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '相关介绍',
  `job_class_name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '执行任务类名称',
  `is_durable` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '是否持久化',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '是否并发',
  `is_update_data` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '是否更新数据',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '是否接受恢复执行',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '任务详细信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '调度名称',
  `lock_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '悲观锁名称',
  PRIMARY KEY (`sched_name`, `lock_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '存储的悲观锁信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '调度名称',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  PRIMARY KEY (`sched_name`, `trigger_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '暂停的触发器表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '调度名称',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '实例名称',
  `last_checkin_time` bigint(13) NOT NULL COMMENT '上次检查时间',
  `checkin_interval` bigint(13) NOT NULL COMMENT '检查间隔时间',
  PRIMARY KEY (`sched_name`, `instance_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '调度器状态表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `repeat_count` bigint(7) NOT NULL COMMENT '重复的次数统计',
  `repeat_interval` bigint(12) NOT NULL COMMENT '重复的间隔时间',
  `times_triggered` bigint(10) NOT NULL COMMENT '已经触发的次数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '简单触发器的信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `str_prop_1` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',
  `str_prop_2` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',
  `str_prop_3` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',
  `int_prop_1` int(11) NULL DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',
  `int_prop_2` int(11) NULL DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',
  `long_prop_1` bigint(20) NULL DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',
  `long_prop_2` bigint(20) NULL DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',
  `dec_prop_1` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',
  `dec_prop_2` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',
  `bool_prop_1` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',
  `bool_prop_2` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '同步机制的行锁表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '触发器的名字',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '触发器所属组的名字',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '相关介绍',
  `next_fire_time` bigint(13) NULL DEFAULT NULL COMMENT '上一次触发时间（毫秒）',
  `prev_fire_time` bigint(13) NULL DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
  `priority` int(11) NULL DEFAULT NULL COMMENT '优先级',
  `trigger_state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '触发器状态',
  `trigger_type` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '触发器的类型',
  `start_time` bigint(13) NOT NULL COMMENT '开始时间',
  `end_time` bigint(13) NULL DEFAULT NULL COMMENT '结束时间',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '日程表名称',
  `misfire_instr` smallint(2) NULL DEFAULT NULL COMMENT '补偿执行的策略',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  INDEX `sched_name`(`sched_name` ASC, `job_name` ASC, `job_group` ASC) USING BTREE,
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '触发器详细信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int(5) NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '参数配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2025-07-15 22:53:55', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2025-07-15 22:53:55', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2025-07-15 22:53:55', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (4, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 'admin', '2025-07-15 22:53:55', '', NULL, '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 'admin', '2025-07-15 22:53:55', '', NULL, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');
INSERT INTO `sys_config` VALUES (6, '用户管理-初始密码修改策略', 'sys.account.initPasswordModify', '1', 'Y', 'admin', '2025-07-15 22:53:55', '', NULL, '0：初始密码修改策略关闭，没有任何提示，1：提醒用户，如果未修改初始密码，则在登录时就会提醒修改密码对话框');
INSERT INTO `sys_config` VALUES (7, '用户管理-账号密码更新周期', 'sys.account.passwordValidateDays', '0', 'Y', 'admin', '2025-07-15 22:53:55', '', NULL, '密码更新周期（填写数字，数据初始化值为0不限制，若修改必须为大于0小于365的正整数），如果超过这个周期登录系统时，则在登录时就会提醒修改密码对话框');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint(20) NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int(4) NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 200 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '部门表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '若依科技', 0, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-07-15 22:53:55', '', NULL);
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '深圳总公司', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-07-15 22:53:55', '', NULL);
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '长沙分公司', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-07-15 22:53:55', '', NULL);
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '研发部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-07-15 22:53:55', '', NULL);
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '市场部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-07-15 22:53:55', '', NULL);
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '测试部门', 3, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-07-15 22:53:55', '', NULL);
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '财务部门', 4, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-07-15 22:53:55', '', NULL);
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '运维部门', 5, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-07-15 22:53:55', '', NULL);
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '市场部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-07-15 22:53:55', '', NULL);
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '财务部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-07-15 22:53:55', '', NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int(4) NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '字典数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2025-07-15 22:53:55', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-07-15 22:53:55', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-07-15 22:53:55', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2025-07-15 22:53:55', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2025-07-15 22:53:55', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2025-07-15 22:53:55', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2025-07-15 22:53:55', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2025-07-15 22:53:55', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2025-07-15 22:53:55', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2025-07-15 22:53:55', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2025-07-15 22:53:55', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2025-07-15 22:53:55', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2025-07-15 22:53:55', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2025-07-15 22:53:55', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2025-07-15 22:53:55', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2025-07-15 22:53:55', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2025-07-15 22:53:55', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-07-15 22:53:55', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-07-15 22:53:55', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-07-15 22:53:55', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-07-15 22:53:55', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2025-07-15 22:53:55', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-07-15 22:53:55', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-07-15 22:53:55', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-07-15 22:53:55', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-07-15 22:53:55', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-07-15 22:53:55', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2025-07-15 22:53:55', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2025-07-15 22:53:55', '', NULL, '停用状态');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '字典类型表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2025-07-15 22:53:55', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2025-07-15 22:53:55', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2025-07-15 22:53:55', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2025-07-15 22:53:55', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2025-07-15 22:53:55', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2025-07-15 22:53:55', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2025-07-15 22:53:55', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2025-07-15 22:53:55', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2025-07-15 22:53:55', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2025-07-15 22:53:55', '', NULL, '登录状态列表');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '定时任务调度表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2025-07-15 22:53:55', '', NULL, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '异常信息',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '定时任务调度日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '登录IP地址',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '提示信息',
  `access_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `idx_sys_logininfor_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_logininfor_lt`(`access_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 124 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '系统访问记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (100, 'admin', '127.0.0.1', '0', '登录成功', '2025-07-15 23:50:31');
INSERT INTO `sys_logininfor` VALUES (101, 'admin', '127.0.0.1', '0', '登录成功', '2025-07-16 17:22:57');
INSERT INTO `sys_logininfor` VALUES (102, 'admin', '127.0.0.1', '0', '登录成功', '2025-07-17 10:04:16');
INSERT INTO `sys_logininfor` VALUES (103, 'admin', '127.0.0.1', '0', '登录成功', '2025-07-20 11:49:05');
INSERT INTO `sys_logininfor` VALUES (104, 'admin', '127.0.0.1', '0', '登录成功', '2025-07-20 14:21:45');
INSERT INTO `sys_logininfor` VALUES (105, 'admin', '127.0.0.1', '0', '登录成功', '2025-07-20 16:32:52');
INSERT INTO `sys_logininfor` VALUES (106, 'admin', '127.0.0.1', '0', '登录成功', '2025-07-20 18:03:32');
INSERT INTO `sys_logininfor` VALUES (107, 'admin', '127.0.0.1', '0', '登录成功', '2025-07-20 18:14:43');
INSERT INTO `sys_logininfor` VALUES (108, 'admin', '127.0.0.1', '0', '登录成功', '2025-07-20 18:32:03');
INSERT INTO `sys_logininfor` VALUES (109, 'admin', '127.0.0.1', '0', '登录成功', '2025-07-20 19:27:00');
INSERT INTO `sys_logininfor` VALUES (110, 'admin', '127.0.0.1', '0', '登录成功', '2025-07-20 21:48:00');
INSERT INTO `sys_logininfor` VALUES (111, 'admin', '127.0.0.1', '0', '登录成功', '2025-07-20 21:51:34');
INSERT INTO `sys_logininfor` VALUES (112, 'admin', '127.0.0.1', '0', '登录成功', '2025-07-20 22:22:50');
INSERT INTO `sys_logininfor` VALUES (113, 'admin', '127.0.0.1', '0', '登录成功', '2025-07-21 20:22:09');
INSERT INTO `sys_logininfor` VALUES (114, 'admin', '127.0.0.1', '0', '登录成功', '2025-07-22 11:00:18');
INSERT INTO `sys_logininfor` VALUES (115, 'admin', '127.0.0.1', '0', '登录成功', '2025-07-22 14:54:40');
INSERT INTO `sys_logininfor` VALUES (116, 'admin', '127.0.0.1', '0', '登录成功', '2025-07-22 22:01:48');
INSERT INTO `sys_logininfor` VALUES (117, 'admin', '10.1.2.105', '0', '登录成功', '2025-07-22 22:20:21');
INSERT INTO `sys_logininfor` VALUES (118, 'admin', '127.0.0.1', '0', '登录成功', '2025-07-23 21:18:09');
INSERT INTO `sys_logininfor` VALUES (119, 'admin', '127.0.0.1', '0', '登录成功', '2025-07-24 11:03:57');
INSERT INTO `sys_logininfor` VALUES (120, 'admin', '127.0.0.1', '0', '登录成功', '2025-07-24 22:11:37');
INSERT INTO `sys_logininfor` VALUES (121, 'admin', '127.0.0.1', '0', '登录成功', '2025-07-25 13:44:05');
INSERT INTO `sys_logininfor` VALUES (122, 'admin', '127.0.0.1', '0', '登录成功', '2025-07-25 15:27:53');
INSERT INTO `sys_logininfor` VALUES (123, 'admin', '127.0.0.1', '0', '登录成功', '2025-07-27 21:57:57');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '菜单名称',
  `parent_id` bigint(20) NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int(4) NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '路由参数',
  `route_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '路由名称',
  `is_frame` int(1) NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int(1) NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2066 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '菜单权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 1, 'system', NULL, '', '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2025-07-15 22:53:55', '', NULL, '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 2, 'monitor', NULL, '', '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2025-07-15 22:53:55', '', NULL, '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 99, 'tool', NULL, '', '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2025-07-15 22:53:55', 'admin', '2025-07-20 14:25:00', '系统工具目录');
INSERT INTO `sys_menu` VALUES (4, '若依官网', 0, 100, 'http://ruoyi.vip', NULL, '', '', 0, 0, 'M', '0', '0', '', 'guide', 'admin', '2025-07-15 22:53:55', 'admin', '2025-07-20 14:25:09', '若依官网地址');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2025-07-15 22:53:55', '', NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2025-07-15 22:53:55', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2025-07-15 22:53:55', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2025-07-15 22:53:55', '', NULL, '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2025-07-15 22:53:55', '', NULL, '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2025-07-15 22:53:55', '', NULL, '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2025-07-15 22:53:55', '', NULL, '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2025-07-15 22:53:55', '', NULL, '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2025-07-15 22:53:55', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2025-07-15 22:53:55', '', NULL, '在线用户菜单');
INSERT INTO `sys_menu` VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2025-07-15 22:53:55', '', NULL, '定时任务菜单');
INSERT INTO `sys_menu` VALUES (111, 'Sentinel控制台', 2, 3, 'http://localhost:8718', '', '', '', 0, 0, 'C', '0', '0', 'monitor:sentinel:list', 'sentinel', 'admin', '2025-07-15 22:53:55', '', NULL, '流量控制菜单');
INSERT INTO `sys_menu` VALUES (112, 'Nacos控制台', 2, 4, 'http://localhost:8848/nacos', '', '', '', 0, 0, 'C', '0', '0', 'monitor:nacos:list', 'nacos', 'admin', '2025-07-15 22:53:55', '', NULL, '服务治理菜单');
INSERT INTO `sys_menu` VALUES (113, 'Admin控制台', 2, 6, 'http://localhost:9100/login', '', '', '', 0, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2025-07-15 22:53:55', 'admin', '2025-07-20 15:48:22', '服务监控菜单');
INSERT INTO `sys_menu` VALUES (114, '表单构建', 3, 1, 'build', 'tool/build/index', '', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2025-07-15 22:53:55', '', NULL, '表单构建菜单');
INSERT INTO `sys_menu` VALUES (115, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2025-07-15 22:53:55', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (116, '系统接口', 3, 3, 'http://localhost:8080/swagger-ui/index.html', '', '', '', 0, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2025-07-15 22:53:55', '', NULL, '系统接口菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'system/operlog/index', '', '', 1, 0, 'C', '0', '0', 'system:operlog:list', 'form', 'admin', '2025-07-15 22:53:55', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'system/logininfor/index', '', '', 1, 0, 'C', '0', '0', 'system:logininfor:list', 'logininfor', 'admin', '2025-07-15 22:53:55', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1000, '用户查询', 100, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1001, '用户新增', 100, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户修改', 100, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户删除', 100, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户导出', 100, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导入', 100, 6, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '重置密码', 100, 7, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '角色查询', 101, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色新增', 101, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色修改', 101, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色删除', 101, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色导出', 101, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '菜单查询', 102, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单新增', 102, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单修改', 102, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单删除', 102, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '部门查询', 103, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门新增', 103, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门修改', 103, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门删除', 103, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '岗位查询', 104, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位新增', 104, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位修改', 104, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位删除', 104, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位导出', 104, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '字典查询', 105, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典新增', 105, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典修改', 105, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典删除', 105, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典导出', 105, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '参数查询', 106, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数新增', 106, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数修改', 106, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数删除', 106, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数导出', 106, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '公告查询', 107, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告新增', 107, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告修改', 107, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告删除', 107, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '操作查询', 500, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:operlog:query', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作删除', 500, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:operlog:remove', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '日志导出', 500, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:operlog:export', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '登录查询', 501, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:logininfor:query', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录删除', 501, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:logininfor:remove', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '日志导出', 501, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:logininfor:export', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '账户解锁', 501, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:logininfor:unlock', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1049, '任务查询', 110, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '任务新增', 110, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1051, '任务修改', 110, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1052, '任务删除', 110, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1053, '状态修改', 110, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1054, '任务导出', 110, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 115, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 115, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 115, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 115, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 115, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 115, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2000, 'minio练习模块', 0, 3, 'minio', NULL, NULL, '', 1, 0, 'M', '0', '0', '', 'education', 'admin', '2025-07-20 14:24:51', 'admin', '2025-07-20 22:16:15', '');
INSERT INTO `sys_menu` VALUES (2008, 'minio', 2, 4, 'http://127.0.0.1:9000', NULL, NULL, '', 0, 0, 'M', '0', '0', '', 'upload', 'admin', '2025-07-20 15:48:16', 'admin', '2025-07-20 15:48:54', '');
INSERT INTO `sys_menu` VALUES (2010, '上传下载', 2000, 1, 'upload_download', 'practice/upload_download/index', NULL, '', 1, 0, 'C', '0', '0', '', 'upload', 'admin', '2025-07-20 22:05:48', 'admin', '2025-07-21 20:43:47', '');
INSERT INTO `sys_menu` VALUES (2023, 'minio操作记录', 2000, 1, 'minio_record', 'practice/minio_record/index', NULL, '', 1, 0, 'C', '0', '0', 'practice:minio_record:list', '#', 'admin', '2025-07-21 20:31:20', '', NULL, 'minio操作记录菜单');
INSERT INTO `sys_menu` VALUES (2024, 'minio操作记录查询', 2023, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'practice:minio_record:query', '#', 'admin', '2025-07-21 20:31:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2025, 'minio操作记录新增', 2023, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'practice:minio_record:add', '#', 'admin', '2025-07-21 20:31:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2026, 'minio操作记录修改', 2023, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'practice:minio_record:edit', '#', 'admin', '2025-07-21 20:31:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2027, 'minio操作记录删除', 2023, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'practice:minio_record:remove', '#', 'admin', '2025-07-21 20:31:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2028, 'minio操作记录导出', 2023, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'practice:minio_record:export', '#', 'admin', '2025-07-21 20:31:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2029, '实例模块', 0, 4, 'example', NULL, NULL, '', 1, 0, 'M', '0', '0', NULL, 'example', 'admin', '2025-07-27 22:02:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2030, '存储商品类别的信息', 2029, 2, 'ExampleCategories', 'example/ExampleCategories/index', NULL, '', 1, 0, 'C', '0', '0', 'example:ExampleCategories:list', '#', 'admin', '2025-07-27 22:10:14', 'admin', '2025-07-27 22:12:14', '存储商品类别的信息菜单');
INSERT INTO `sys_menu` VALUES (2031, '存储商品类别的信息查询', 2030, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'example:ExampleCategories:query', '#', 'admin', '2025-07-27 22:10:14', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2032, '存储商品类别的信息新增', 2030, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'example:ExampleCategories:add', '#', 'admin', '2025-07-27 22:10:14', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2033, '存储商品类别的信息修改', 2030, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'example:ExampleCategories:edit', '#', 'admin', '2025-07-27 22:10:14', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2034, '存储商品类别的信息删除', 2030, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'example:ExampleCategories:remove', '#', 'admin', '2025-07-27 22:10:14', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2035, '存储商品类别的信息导出', 2030, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'example:ExampleCategories:export', '#', 'admin', '2025-07-27 22:10:14', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2036, '存储订单中每种商品的详细信息', 2029, 5, 'ExampleOrderItems', 'example/ExampleOrderItems/index', NULL, '', 1, 0, 'C', '0', '0', 'example:ExampleOrderItems:list', '#', 'admin', '2025-07-27 22:10:30', 'admin', '2025-07-27 22:12:46', '存储订单中每种商品的详细信息菜单');
INSERT INTO `sys_menu` VALUES (2037, '存储订单中每种商品的详细信息查询', 2036, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'example:ExampleOrderItems:query', '#', 'admin', '2025-07-27 22:10:30', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2038, '存储订单中每种商品的详细信息新增', 2036, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'example:ExampleOrderItems:add', '#', 'admin', '2025-07-27 22:10:30', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2039, '存储订单中每种商品的详细信息修改', 2036, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'example:ExampleOrderItems:edit', '#', 'admin', '2025-07-27 22:10:30', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2040, '存储订单中每种商品的详细信息删除', 2036, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'example:ExampleOrderItems:remove', '#', 'admin', '2025-07-27 22:10:30', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2041, '存储订单中每种商品的详细信息导出', 2036, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'example:ExampleOrderItems:export', '#', 'admin', '2025-07-27 22:10:30', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2042, '存储订单的信息', 2029, 4, 'ExampleOrders', 'example/ExampleOrders/index', NULL, '', 1, 0, 'C', '0', '0', 'example:ExampleOrders:list', '#', 'admin', '2025-07-27 22:10:44', 'admin', '2025-07-27 22:12:37', '存储订单的信息菜单');
INSERT INTO `sys_menu` VALUES (2043, '存储订单的信息查询', 2042, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'example:ExampleOrders:query', '#', 'admin', '2025-07-27 22:10:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2044, '存储订单的信息新增', 2042, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'example:ExampleOrders:add', '#', 'admin', '2025-07-27 22:10:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2045, '存储订单的信息修改', 2042, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'example:ExampleOrders:edit', '#', 'admin', '2025-07-27 22:10:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2046, '存储订单的信息删除', 2042, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'example:ExampleOrders:remove', '#', 'admin', '2025-07-27 22:10:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2047, '存储订单的信息导出', 2042, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'example:ExampleOrders:export', '#', 'admin', '2025-07-27 22:10:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2048, '存储支付信息', 2029, 6, 'ExamplePayments', 'example/ExamplePayments/index', NULL, '', 1, 0, 'C', '0', '0', 'example:ExamplePayments:list', '#', 'admin', '2025-07-27 22:10:57', 'admin', '2025-07-27 22:12:54', '存储支付信息菜单');
INSERT INTO `sys_menu` VALUES (2049, '存储支付信息查询', 2048, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'example:ExamplePayments:query', '#', 'admin', '2025-07-27 22:10:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2050, '存储支付信息新增', 2048, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'example:ExamplePayments:add', '#', 'admin', '2025-07-27 22:10:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2051, '存储支付信息修改', 2048, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'example:ExamplePayments:edit', '#', 'admin', '2025-07-27 22:10:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2052, '存储支付信息删除', 2048, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'example:ExamplePayments:remove', '#', 'admin', '2025-07-27 22:10:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2053, '存储支付信息导出', 2048, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'example:ExamplePayments:export', '#', 'admin', '2025-07-27 22:10:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2054, '存储商品的信息', 2029, 3, 'ExampleProducts', 'example/ExampleProducts/index', NULL, '', 1, 0, 'C', '0', '0', 'example:ExampleProducts:list', '#', 'admin', '2025-07-27 22:11:07', 'admin', '2025-07-27 22:12:23', '存储商品的信息菜单');
INSERT INTO `sys_menu` VALUES (2055, '存储商品的信息查询', 2054, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'example:ExampleProducts:query', '#', 'admin', '2025-07-27 22:11:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2056, '存储商品的信息新增', 2054, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'example:ExampleProducts:add', '#', 'admin', '2025-07-27 22:11:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2057, '存储商品的信息修改', 2054, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'example:ExampleProducts:edit', '#', 'admin', '2025-07-27 22:11:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2058, '存储商品的信息删除', 2054, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'example:ExampleProducts:remove', '#', 'admin', '2025-07-27 22:11:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2059, '存储商品的信息导出', 2054, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'example:ExampleProducts:export', '#', 'admin', '2025-07-27 22:11:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2060, '存储用户的信息', 2029, 1, 'ExampleUsers', 'example/ExampleUsers/index', NULL, '', 1, 0, 'C', '0', '0', 'example:ExampleUsers:list', '#', 'admin', '2025-07-27 22:11:20', '', NULL, '存储用户的信息菜单');
INSERT INTO `sys_menu` VALUES (2061, '存储用户的信息查询', 2060, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'example:ExampleUsers:query', '#', 'admin', '2025-07-27 22:11:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2062, '存储用户的信息新增', 2060, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'example:ExampleUsers:add', '#', 'admin', '2025-07-27 22:11:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2063, '存储用户的信息修改', 2060, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'example:ExampleUsers:edit', '#', 'admin', '2025-07-27 22:11:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2064, '存储用户的信息删除', 2060, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'example:ExampleUsers:remove', '#', 'admin', '2025-07-27 22:11:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2065, '存储用户的信息导出', 2060, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'example:ExampleUsers:export', '#', 'admin', '2025-07-27 22:11:20', '', NULL, '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int(4) NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '通知公告表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '温馨提醒：2018-07-01 若依新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 'admin', '2025-07-15 22:53:55', '', NULL, '管理员');
INSERT INTO `sys_notice` VALUES (2, '维护通知：2018-07-01 若依系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2025-07-15 22:53:55', '', NULL, '管理员');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int(2) NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int(1) NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '返回参数',
  `status` int(1) NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint(20) NULL DEFAULT 0 COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`) USING BTREE,
  INDEX `idx_sys_oper_log_bt`(`business_type` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_ot`(`oper_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 185 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '操作日志记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (100, '菜单管理', 1, 'com.ruoyi.system.controller.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"education\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"练习模块\",\"menuType\":\"M\",\"orderNum\":3,\"params\":{},\"parentId\":0,\"path\":\"practice\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 14:24:52', 80);
INSERT INTO `sys_oper_log` VALUES (101, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"createTime\":\"2025-07-15 22:53:55\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":3,\"menuName\":\"系统工具\",\"menuType\":\"M\",\"orderNum\":99,\"params\":{},\"parentId\":0,\"path\":\"tool\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 14:25:00', 17);
INSERT INTO `sys_oper_log` VALUES (102, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"createTime\":\"2025-07-15 22:53:55\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":4,\"menuName\":\"若依官网\",\"menuType\":\"M\",\"orderNum\":100,\"params\":{},\"parentId\":0,\"path\":\"http://ruoyi.vip\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 14:25:09', 11);
INSERT INTO `sys_oper_log` VALUES (103, '代码生成', 6, 'com.ruoyi.gen.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/gen/importTable', '127.0.0.1', '', '{\"tables\":\"practice_minio\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 14:28:47', 186);
INSERT INTO `sys_oper_log` VALUES (104, '代码生成', 2, 'com.ruoyi.gen.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/gen', '127.0.0.1', '', '{\"businessName\":\"practice_minio\",\"className\":\"PracticeMinio\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"主键\",\"columnId\":1,\"columnName\":\"id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-20 14:28:46\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"FiledName\",\"columnComment\":\"文件名称\",\"columnId\":2,\"columnName\":\"filed_name\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-20 14:28:46\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"filedName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"FiledPath\",\"columnComment\":\"文件路径\",\"columnId\":3,\"columnName\":\"filed_path\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-20 14:28:46\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"filedPath\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"DelFlag\",\"columnComment\":\"删除标志（0代表存在 2代表删除）\",\"columnId\":4,\"columnName\":\"del_flag\",\"columnType\":\"char(1)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-20 14:28:46\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"0\",\"javaField\":\"delFlag\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":false,\"query\":fal', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 14:30:26', 192);
INSERT INTO `sys_oper_log` VALUES (105, '代码生成', 2, 'com.ruoyi.gen.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/gen', '127.0.0.1', '', '{\"businessName\":\"practice_minio\",\"className\":\"PracticeMinio\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"主键\",\"columnId\":1,\"columnName\":\"id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-20 14:28:46\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-07-20 14:30:26\",\"usableColumn\":false},{\"capJavaField\":\"FiledName\",\"columnComment\":\"文件名称\",\"columnId\":2,\"columnName\":\"filed_name\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-20 14:28:46\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"filedName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-07-20 14:30:26\",\"usableColumn\":false},{\"capJavaField\":\"FiledPath\",\"columnComment\":\"文件路径\",\"columnId\":3,\"columnName\":\"filed_path\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-20 14:28:46\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"filedPath\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-07-20 14:30:26\",\"usableColumn\":false},{\"capJavaField\":\"DelFlag\",\"columnComment\":\"删除标志（0代表存在 2代表删除）\",\"columnId\":4,\"columnName\":\"del_flag\",\"columnType\":\"char(1)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-20 14:28:46\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\"', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 14:33:55', 39);
INSERT INTO `sys_oper_log` VALUES (106, '代码生成', 8, 'com.ruoyi.gen.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/gen/batchGenCode', '127.0.0.1', '', '{\"tables\":\"practice_minio\"}', NULL, 0, NULL, '2025-07-20 14:34:07', 404);
INSERT INTO `sys_oper_log` VALUES (107, '代码生成', 8, 'com.ruoyi.gen.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/gen/batchGenCode', '127.0.0.1', '', '{\"tables\":\"practice_minio\"}', NULL, 0, NULL, '2025-07-20 14:34:17', 315);
INSERT INTO `sys_oper_log` VALUES (108, '菜单管理', 1, 'com.ruoyi.system.controller.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"minio/practice_minio/index\",\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"minio上传下载\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"practice_minio\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 14:51:45', 11);
INSERT INTO `sys_oper_log` VALUES (109, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"minio/practice_minio/index\",\"createTime\":\"2025-07-20 14:36:11\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"minio操作记录\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2000,\"path\":\"practice_minio\",\"perms\":\"minio:practice_minio:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 14:51:53', 12);
INSERT INTO `sys_oper_log` VALUES (110, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"minio/upload_download/index\",\"createTime\":\"2025-07-20 14:51:45\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2007,\"menuName\":\"minio上传下载\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"practice_minio\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 14:58:36', 9);
INSERT INTO `sys_oper_log` VALUES (111, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"minio/practice_minio/upload_download\",\"createTime\":\"2025-07-20 14:51:45\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2007,\"menuName\":\"minio上传下载\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"practice_minio\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 15:01:01', 15);
INSERT INTO `sys_oper_log` VALUES (112, '菜单管理', 1, 'com.ruoyi.system.controller.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"upload\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"minio\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":2,\"path\":\"http://127.0.0.1:9000\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 15:48:16', 16);
INSERT INTO `sys_oper_log` VALUES (113, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"\",\"createTime\":\"2025-07-15 22:53:55\",\"icon\":\"server\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":113,\"menuName\":\"Admin控制台\",\"menuType\":\"C\",\"orderNum\":6,\"params\":{},\"parentId\":2,\"path\":\"http://localhost:9100/login\",\"perms\":\"monitor:server:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 15:48:22', 10);
INSERT INTO `sys_oper_log` VALUES (114, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"createTime\":\"2025-07-20 15:48:16\",\"icon\":\"upload\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":2008,\"menuName\":\"minio\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":2,\"path\":\"http://127.0.0.1:9000\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 15:48:54', 6);
INSERT INTO `sys_oper_log` VALUES (115, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"minio/upload_download/index\",\"createTime\":\"2025-07-20 14:51:45\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2007,\"menuName\":\"minio上传下载\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"practice_minio\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 18:13:56', 14);
INSERT INTO `sys_oper_log` VALUES (116, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"practice/upload_download/index\",\"createTime\":\"2025-07-20 14:51:45\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2007,\"menuName\":\"minio上传下载\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"practice_minio\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 18:37:37', 63);
INSERT INTO `sys_oper_log` VALUES (117, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"practice/practice_minio/index\",\"createTime\":\"2025-07-20 14:36:11\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"minio操作记录\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2000,\"path\":\"practice_minio\",\"perms\":\"minio:practice_minio:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 18:37:45', 18);
INSERT INTO `sys_oper_log` VALUES (118, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"practice/practice_minio/index\",\"createTime\":\"2025-07-20 14:36:11\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"minio操作记录\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2000,\"path\":\"practice_minio\",\"perms\":\"practice:practice_minio:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 18:50:27', 63);
INSERT INTO `sys_oper_log` VALUES (119, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"\",\"createTime\":\"2025-07-20 14:36:11\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2002,\"menuName\":\"minio操作记录查询\",\"menuType\":\"F\",\"orderNum\":1,\"params\":{},\"parentId\":2001,\"path\":\"#\",\"perms\":\"practice:practice_minio:query\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 18:50:35', 16);
INSERT INTO `sys_oper_log` VALUES (120, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"\",\"createTime\":\"2025-07-20 14:36:11\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2003,\"menuName\":\"minio操作记录新增\",\"menuType\":\"F\",\"orderNum\":2,\"params\":{},\"parentId\":2001,\"path\":\"#\",\"perms\":\"practice:practice_minio:add\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 18:50:40', 13);
INSERT INTO `sys_oper_log` VALUES (121, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"\",\"createTime\":\"2025-07-20 14:36:11\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2004,\"menuName\":\"minio操作记录修改\",\"menuType\":\"F\",\"orderNum\":3,\"params\":{},\"parentId\":2001,\"path\":\"#\",\"perms\":\"practice:practice_minio:edit\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 18:50:45', 12);
INSERT INTO `sys_oper_log` VALUES (122, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"\",\"createTime\":\"2025-07-20 14:36:11\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2005,\"menuName\":\"minio操作记录删除\",\"menuType\":\"F\",\"orderNum\":4,\"params\":{},\"parentId\":2001,\"path\":\"#\",\"perms\":\"practice:practice_minio:remove\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 18:50:50', 11);
INSERT INTO `sys_oper_log` VALUES (123, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"\",\"createTime\":\"2025-07-20 14:36:11\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2006,\"menuName\":\"minio操作记录导出\",\"menuType\":\"F\",\"orderNum\":5,\"params\":{},\"parentId\":2001,\"path\":\"#\",\"perms\":\"practice:practice_minio:export\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 18:50:55', 21);
INSERT INTO `sys_oper_log` VALUES (124, '代码生成', 3, 'com.ruoyi.gen.controller.GenController.remove()', 'DELETE', 1, 'admin', NULL, '/gen/1', '127.0.0.1', '', '[1]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 19:13:11', 81);
INSERT INTO `sys_oper_log` VALUES (125, '代码生成', 6, 'com.ruoyi.gen.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/gen/importTable', '127.0.0.1', '', '{\"tables\":\"minio_record\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 19:13:16', 155);
INSERT INTO `sys_oper_log` VALUES (126, '代码生成', 2, 'com.ruoyi.gen.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/gen', '127.0.0.1', '', '{\"businessName\":\"minio_record\",\"className\":\"MinioRecord\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"主键\",\"columnId\":10,\"columnName\":\"id\",\"columnType\":\"bigint(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-20 19:13:16\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"FileName\",\"columnComment\":\"文件名\",\"columnId\":11,\"columnName\":\"file_name\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-20 19:13:16\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"fileName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"FilePath\",\"columnComment\":\"文件路径\",\"columnId\":12,\"columnName\":\"file_path\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-20 19:13:16\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"filePath\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"DelFlag\",\"columnComment\":\"删除标志（0代表存在 2代表删除）\",\"columnId\":13,\"columnName\":\"del_flag\",\"columnType\":\"char(1)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-20 19:13:16\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"0\",\"javaField\":\"delFlag\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":false,\"query\":false,\"qu', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 19:14:33', 190);
INSERT INTO `sys_oper_log` VALUES (127, '代码生成', 2, 'com.ruoyi.gen.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/gen', '127.0.0.1', '', '{\"businessName\":\"minio_record\",\"className\":\"MinioRecord\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"主键\",\"columnId\":10,\"columnName\":\"id\",\"columnType\":\"bigint(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-20 19:13:16\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2025-07-20 19:14:33\",\"usableColumn\":false},{\"capJavaField\":\"FileName\",\"columnComment\":\"文件名\",\"columnId\":11,\"columnName\":\"file_name\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-20 19:13:16\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"fileName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2025-07-20 19:14:33\",\"usableColumn\":false},{\"capJavaField\":\"FilePath\",\"columnComment\":\"文件路径\",\"columnId\":12,\"columnName\":\"file_path\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-20 19:13:16\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"filePath\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2025-07-20 19:14:33\",\"usableColumn\":false},{\"capJavaField\":\"DelFlag\",\"columnComment\":\"删除标志（0代表存在 2代表删除）\",\"columnId\":13,\"columnName\":\"del_flag\",\"columnType\":\"char(1)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-20 19:13:16\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 19:15:15', 17);
INSERT INTO `sys_oper_log` VALUES (128, '代码生成', 8, 'com.ruoyi.gen.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/gen/batchGenCode', '127.0.0.1', '', '{\"tables\":\"minio_record\"}', NULL, 0, NULL, '2025-07-20 19:15:17', 63);
INSERT INTO `sys_oper_log` VALUES (129, '菜单管理', 3, 'com.ruoyi.system.controller.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/menu/2007', '127.0.0.1', '', '2007', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 22:03:13', 18);
INSERT INTO `sys_oper_log` VALUES (130, '菜单管理', 1, 'com.ruoyi.system.controller.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"upload\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"上传下载\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"upload_download/index\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 22:03:53', 13);
INSERT INTO `sys_oper_log` VALUES (131, '菜单管理', 1, 'com.ruoyi.system.controller.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"upload_download/index\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"上传下载\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"upload_download\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"新增菜单\'上传下载\'失败，菜单名称已存在\",\"code\":500}', 0, NULL, '2025-07-20 22:04:46', 2);
INSERT INTO `sys_oper_log` VALUES (132, '菜单管理', 3, 'com.ruoyi.system.controller.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/menu/2009', '127.0.0.1', '', '2009', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 22:04:53', 5);
INSERT INTO `sys_oper_log` VALUES (133, '菜单管理', 1, 'com.ruoyi.system.controller.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"upload_download/index\",\"createBy\":\"admin\",\"icon\":\"upload\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"上传下载\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"upload_download\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 22:05:48', 8);
INSERT INTO `sys_oper_log` VALUES (134, '菜单管理', 3, 'com.ruoyi.system.controller.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/menu/2006', '127.0.0.1', '', '2006', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 22:06:57', 6);
INSERT INTO `sys_oper_log` VALUES (135, '菜单管理', 3, 'com.ruoyi.system.controller.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/menu/2005', '127.0.0.1', '', '2005', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 22:07:00', 7);
INSERT INTO `sys_oper_log` VALUES (136, '菜单管理', 3, 'com.ruoyi.system.controller.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/menu/2004', '127.0.0.1', '', '2004', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 22:07:03', 8);
INSERT INTO `sys_oper_log` VALUES (137, '菜单管理', 3, 'com.ruoyi.system.controller.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/menu/2003', '127.0.0.1', '', '2003', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 22:07:06', 5);
INSERT INTO `sys_oper_log` VALUES (138, '菜单管理', 3, 'com.ruoyi.system.controller.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/menu/2002', '127.0.0.1', '', '2002', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 22:07:09', 5);
INSERT INTO `sys_oper_log` VALUES (139, '菜单管理', 3, 'com.ruoyi.system.controller.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/menu/2001', '127.0.0.1', '', '2001', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 22:07:12', 6);
INSERT INTO `sys_oper_log` VALUES (140, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"createTime\":\"2025-07-20 14:24:51\",\"icon\":\"education\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"练习模块\",\"menuType\":\"M\",\"orderNum\":3,\"params\":{},\"parentId\":0,\"path\":\"minio\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 22:15:59', 18);
INSERT INTO `sys_oper_log` VALUES (141, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"createTime\":\"2025-07-20 14:24:51\",\"icon\":\"education\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"minio练习模块\",\"menuType\":\"M\",\"orderNum\":3,\"params\":{},\"parentId\":0,\"path\":\"minio\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 22:16:15', 10);
INSERT INTO `sys_oper_log` VALUES (142, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"minio/minio_record/index\",\"createTime\":\"2025-07-20 22:07:50\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2011,\"menuName\":\"minio操作记录\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"minio_record\",\"perms\":\"minio:minio_record:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 22:16:38', 16);
INSERT INTO `sys_oper_log` VALUES (143, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"\",\"createTime\":\"2025-07-20 22:07:50\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2012,\"menuName\":\"minio操作记录查询\",\"menuType\":\"F\",\"orderNum\":1,\"params\":{},\"parentId\":2011,\"path\":\"#\",\"perms\":\"minio:minio_record:query\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 22:16:48', 13);
INSERT INTO `sys_oper_log` VALUES (144, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"\",\"createTime\":\"2025-07-20 22:07:50\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2013,\"menuName\":\"minio操作记录新增\",\"menuType\":\"F\",\"orderNum\":2,\"params\":{},\"parentId\":2011,\"path\":\"#\",\"perms\":\"minio:minio_record:add\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 22:16:54', 11);
INSERT INTO `sys_oper_log` VALUES (145, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"\",\"createTime\":\"2025-07-20 22:07:50\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2014,\"menuName\":\"minio操作记录修改\",\"menuType\":\"F\",\"orderNum\":3,\"params\":{},\"parentId\":2011,\"path\":\"#\",\"perms\":\"minio:minio_record:edit\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 22:17:01', 12);
INSERT INTO `sys_oper_log` VALUES (146, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"\",\"createTime\":\"2025-07-20 22:07:50\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2015,\"menuName\":\"minio操作记录删除\",\"menuType\":\"F\",\"orderNum\":4,\"params\":{},\"parentId\":2011,\"path\":\"#\",\"perms\":\"minio:minio_record:remove\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 22:17:08', 12);
INSERT INTO `sys_oper_log` VALUES (147, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"\",\"createTime\":\"2025-07-20 22:07:50\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2015,\"menuName\":\"minio操作记录删除\",\"menuType\":\"F\",\"orderNum\":4,\"params\":{},\"parentId\":2011,\"path\":\"#\",\"perms\":\"minio:minio_record:remove\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 22:17:14', 11);
INSERT INTO `sys_oper_log` VALUES (148, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"\",\"createTime\":\"2025-07-20 22:07:50\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2016,\"menuName\":\"minio操作记录导出\",\"menuType\":\"F\",\"orderNum\":5,\"params\":{},\"parentId\":2011,\"path\":\"#\",\"perms\":\"minio:minio_record:export\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 22:17:20', 11);
INSERT INTO `sys_oper_log` VALUES (149, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"upload_download/index\",\"createTime\":\"2025-07-20 22:05:48\",\"icon\":\"upload\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2010,\"menuName\":\"上传下载\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":2000,\"path\":\"upload_download\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 22:17:47', 11);
INSERT INTO `sys_oper_log` VALUES (150, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"minio/upload_download/index\",\"createTime\":\"2025-07-20 22:05:48\",\"icon\":\"upload\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2010,\"menuName\":\"上传下载\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"minio\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 22:18:19', 10);
INSERT INTO `sys_oper_log` VALUES (151, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"minio/minio_record/index\",\"createTime\":\"2025-07-20 22:07:50\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2011,\"menuName\":\"minio操作记录\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2000,\"path\":\"minio_record\",\"perms\":\"minio:minio_record:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 22:18:37', 8);
INSERT INTO `sys_oper_log` VALUES (152, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"minio/upload_download/index\",\"createTime\":\"2025-07-20 22:05:48\",\"icon\":\"upload\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2010,\"menuName\":\"上传下载\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"upload_download\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 22:18:52', 16);
INSERT INTO `sys_oper_log` VALUES (153, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"minio/minio_record/upload_download\",\"createTime\":\"2025-07-20 22:05:48\",\"icon\":\"upload\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2010,\"menuName\":\"上传下载\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"minio_record\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 22:25:59', 15);
INSERT INTO `sys_oper_log` VALUES (154, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"minio/upload_download/index\",\"createTime\":\"2025-07-20 22:05:48\",\"icon\":\"upload\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2010,\"menuName\":\"上传下载\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"upload_download\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 22:28:47', 6);
INSERT INTO `sys_oper_log` VALUES (155, '代码生成', 2, 'com.ruoyi.gen.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/gen', '127.0.0.1', '', '{\"businessName\":\"minio_record\",\"className\":\"MinioRecord\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"主键\",\"columnId\":10,\"columnName\":\"id\",\"columnType\":\"bigint(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-20 19:13:16\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2025-07-20 19:15:15\",\"usableColumn\":false},{\"capJavaField\":\"FileName\",\"columnComment\":\"文件名\",\"columnId\":11,\"columnName\":\"file_name\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-20 19:13:16\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"fileName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2025-07-20 19:15:15\",\"usableColumn\":false},{\"capJavaField\":\"FilePath\",\"columnComment\":\"文件路径\",\"columnId\":12,\"columnName\":\"file_path\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-20 19:13:16\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"filePath\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2025-07-20 19:15:15\",\"usableColumn\":false},{\"capJavaField\":\"DelFlag\",\"columnComment\":\"删除标志（0代表存在 2代表删除）\",\"columnId\":13,\"columnName\":\"del_flag\",\"columnType\":\"char(1)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-20 19:13:16\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 22:31:16', 49);
INSERT INTO `sys_oper_log` VALUES (156, '代码生成', 8, 'com.ruoyi.gen.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/gen/batchGenCode', '127.0.0.1', '', '{\"tables\":\"minio_record\"}', NULL, 0, NULL, '2025-07-20 22:31:21', 102);
INSERT INTO `sys_oper_log` VALUES (157, '代码生成', 8, 'com.ruoyi.gen.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/gen/batchGenCode', '127.0.0.1', '', '{\"tables\":\"minio_record\"}', NULL, 0, NULL, '2025-07-20 22:32:04', 18);
INSERT INTO `sys_oper_log` VALUES (158, 'minio操作记录', 3, 'com.ruoyi.minio.controller.MinioRecordController.remove()', 'DELETE', 1, 'admin', NULL, '/minio_record/1,2,3,4', '127.0.0.1', '', '[1,2,3,4]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 22:53:20', 63);
INSERT INTO `sys_oper_log` VALUES (159, 'minio操作记录', 3, 'com.ruoyi.minio.controller.MinioRecordController.remove()', 'DELETE', 1, 'admin', NULL, '/minio_record/5', '127.0.0.1', '', '[5]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 23:11:04', 12381);
INSERT INTO `sys_oper_log` VALUES (160, 'minio操作记录', 3, 'com.ruoyi.minio.controller.MinioRecordController.remove()', 'DELETE', 1, 'admin', NULL, '/minio_record/5,6,7', '127.0.0.1', '', '[5,6,7]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-20 23:15:58', 52);
INSERT INTO `sys_oper_log` VALUES (161, '代码生成', 2, 'com.ruoyi.gen.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/gen', '127.0.0.1', '', '{\"businessName\":\"minio_record\",\"className\":\"MinioRecord\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"主键\",\"columnId\":10,\"columnName\":\"id\",\"columnType\":\"bigint(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-20 19:13:16\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2025-07-20 22:31:16\",\"usableColumn\":false},{\"capJavaField\":\"FileName\",\"columnComment\":\"文件名\",\"columnId\":11,\"columnName\":\"file_name\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-20 19:13:16\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"fileName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2025-07-20 22:31:16\",\"usableColumn\":false},{\"capJavaField\":\"FilePath\",\"columnComment\":\"文件路径\",\"columnId\":12,\"columnName\":\"file_path\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-20 19:13:16\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"filePath\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2025-07-20 22:31:16\",\"usableColumn\":false},{\"capJavaField\":\"DelFlag\",\"columnComment\":\"删除标志（0代表存在 2代表删除）\",\"columnId\":13,\"columnName\":\"del_flag\",\"columnType\":\"char(1)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-20 19:13:16\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-21 20:28:42', 234);
INSERT INTO `sys_oper_log` VALUES (162, '代码生成', 8, 'com.ruoyi.gen.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/gen/batchGenCode', '127.0.0.1', '', '{\"tables\":\"minio_record\"}', NULL, 0, NULL, '2025-07-21 20:29:05', 163);
INSERT INTO `sys_oper_log` VALUES (163, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"practice/upload_download/index\",\"createTime\":\"2025-07-20 22:05:48\",\"icon\":\"upload\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2010,\"menuName\":\"上传下载\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"upload_download\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-21 20:43:48', 71);
INSERT INTO `sys_oper_log` VALUES (164, 'minio操作记录', 3, 'com.ruoyi.minio.controller.MinioRecordController.remove()', 'DELETE', 1, 'admin', NULL, '/minio_record/8', '127.0.0.1', '', '[8]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-21 20:44:34', 94);
INSERT INTO `sys_oper_log` VALUES (165, 'minio操作记录', 3, 'com.ruoyi.minio.controller.MinioRecordController.remove()', 'DELETE', 1, 'admin', NULL, '/minio_record/9', '127.0.0.1', '', '[9]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-24 22:13:52', 91);
INSERT INTO `sys_oper_log` VALUES (166, '代码生成', 6, 'com.ruoyi.gen.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/gen/importTable', '127.0.0.1', '', '{\"tables\":\"example_order_items,example_orders,example_payments\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-27 21:59:25', 356);
INSERT INTO `sys_oper_log` VALUES (167, '代码生成', 6, 'com.ruoyi.gen.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/gen/importTable', '127.0.0.1', '', '{\"tables\":\"example_products,example_users\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-27 21:59:42', 130);
INSERT INTO `sys_oper_log` VALUES (168, '代码生成', 6, 'com.ruoyi.gen.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/gen/importTable', '127.0.0.1', '', '{\"tables\":\"example_categories\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-27 21:59:54', 41);
INSERT INTO `sys_oper_log` VALUES (169, '代码生成', 2, 'com.ruoyi.gen.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/gen', '127.0.0.1', '', '{\"businessName\":\"ExampleCategories\",\"className\":\"ExampleCategories\",\"columns\":[{\"capJavaField\":\"ExampleId\",\"columnComment\":\"类别的唯一标识符\",\"columnId\":71,\"columnName\":\"example_id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-27 21:59:54\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"exampleId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":8,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"CategoryName\",\"columnComment\":\"类别的名称\",\"columnId\":72,\"columnName\":\"category_name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-27 21:59:54\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"categoryName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":8,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Description\",\"columnComment\":\"类别的描述信息\",\"columnId\":73,\"columnName\":\"description\",\"columnType\":\"text\",\"createBy\":\"admin\",\"createTime\":\"2025-07-27 21:59:54\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"description\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":8,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ExampleParentId\",\"columnComment\":\"父类别的ID，NULL表示顶级类别\",\"columnId\":74,\"columnName\":\"example_parent_id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-27 21:59:54\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isL', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-27 22:00:48', 140);
INSERT INTO `sys_oper_log` VALUES (170, '菜单管理', 1, 'com.ruoyi.system.controller.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"example\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"实例模块\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"example\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-27 22:02:18', 58);
INSERT INTO `sys_oper_log` VALUES (171, '代码生成', 2, 'com.ruoyi.gen.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/gen', '127.0.0.1', '', '{\"businessName\":\"ExampleCategories\",\"className\":\"ExampleCategories\",\"columns\":[{\"capJavaField\":\"ExampleId\",\"columnComment\":\"类别的唯一标识符\",\"columnId\":71,\"columnName\":\"example_id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-27 21:59:54\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"exampleId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":8,\"updateBy\":\"\",\"updateTime\":\"2025-07-27 22:00:48\",\"usableColumn\":false},{\"capJavaField\":\"CategoryName\",\"columnComment\":\"类别的名称\",\"columnId\":72,\"columnName\":\"category_name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-27 21:59:54\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"categoryName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":8,\"updateBy\":\"\",\"updateTime\":\"2025-07-27 22:00:48\",\"usableColumn\":false},{\"capJavaField\":\"Description\",\"columnComment\":\"类别的描述信息\",\"columnId\":73,\"columnName\":\"description\",\"columnType\":\"text\",\"createBy\":\"admin\",\"createTime\":\"2025-07-27 21:59:54\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"description\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":8,\"updateBy\":\"\",\"updateTime\":\"2025-07-27 22:00:48\",\"usableColumn\":false},{\"capJavaField\":\"ExampleParentId\",\"columnComment\":\"父类别的ID，NULL表示顶级类别\",\"columnId\":74,\"columnName\":\"example_parent_id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-27 21:59:54\",\"dictType\":\"\",\"edit\":t', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-27 22:02:58', 34);
INSERT INTO `sys_oper_log` VALUES (172, '代码生成', 2, 'com.ruoyi.gen.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/gen', '127.0.0.1', '', '{\"businessName\":\"ExampleProducts\",\"className\":\"ExampleProducts\",\"columns\":[{\"capJavaField\":\"ExampleId\",\"columnComment\":\"商品的唯一标识符\",\"columnId\":49,\"columnName\":\"example_id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-27 21:59:42\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"exampleId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ProductName\",\"columnComment\":\"商品名称\",\"columnId\":50,\"columnName\":\"product_name\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-27 21:59:42\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"productName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Description\",\"columnComment\":\"商品描述\",\"columnId\":51,\"columnName\":\"description\",\"columnType\":\"text\",\"createBy\":\"admin\",\"createTime\":\"2025-07-27 21:59:42\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"description\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Price\",\"columnComment\":\"商品价格\",\"columnId\":52,\"columnName\":\"price\",\"columnType\":\"decimal(10,2)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-27 21:59:42\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isReq', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-27 22:03:32', 42);
INSERT INTO `sys_oper_log` VALUES (173, '代码生成', 2, 'com.ruoyi.gen.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/gen', '127.0.0.1', '', '{\"businessName\":\"ExampleCategories\",\"className\":\"ExampleCategories\",\"columns\":[{\"capJavaField\":\"ExampleId\",\"columnComment\":\"类别的唯一标识符\",\"columnId\":71,\"columnName\":\"example_id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-27 21:59:54\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"exampleId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":8,\"updateBy\":\"\",\"updateTime\":\"2025-07-27 22:02:58\",\"usableColumn\":false},{\"capJavaField\":\"CategoryName\",\"columnComment\":\"类别的名称\",\"columnId\":72,\"columnName\":\"category_name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-27 21:59:54\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"categoryName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":8,\"updateBy\":\"\",\"updateTime\":\"2025-07-27 22:02:58\",\"usableColumn\":false},{\"capJavaField\":\"Description\",\"columnComment\":\"类别的描述信息\",\"columnId\":73,\"columnName\":\"description\",\"columnType\":\"text\",\"createBy\":\"admin\",\"createTime\":\"2025-07-27 21:59:54\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"description\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":8,\"updateBy\":\"\",\"updateTime\":\"2025-07-27 22:02:58\",\"usableColumn\":false},{\"capJavaField\":\"ExampleParentId\",\"columnComment\":\"父类别的ID，NULL表示顶级类别\",\"columnId\":74,\"columnName\":\"example_parent_id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-27 21:59:54\",\"dictType\":\"\",\"edit\":t', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-27 22:03:47', 20);
INSERT INTO `sys_oper_log` VALUES (174, '代码生成', 2, 'com.ruoyi.gen.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/gen', '127.0.0.1', '', '{\"businessName\":\"ExampleUsers\",\"className\":\"ExampleUsers\",\"columns\":[{\"capJavaField\":\"ExampleId\",\"columnComment\":\"用户的唯一标识符\",\"columnId\":60,\"columnName\":\"example_id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-27 21:59:42\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"exampleId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Username\",\"columnComment\":\"用户名\",\"columnId\":61,\"columnName\":\"username\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-27 21:59:42\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"username\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Email\",\"columnComment\":\"用户邮箱地址\",\"columnId\":62,\"columnName\":\"email\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-27 21:59:42\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"email\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"PasswordHash\",\"columnComment\":\"用户密码哈希值\",\"columnId\":63,\"columnName\":\"password_hash\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-27 21:59:42\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"i', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-27 22:04:32', 43);
INSERT INTO `sys_oper_log` VALUES (175, '代码生成', 2, 'com.ruoyi.gen.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/gen', '127.0.0.1', '', '{\"businessName\":\"ExampleOrderItems\",\"className\":\"ExampleOrderItems\",\"columns\":[{\"capJavaField\":\"ExampleId\",\"columnComment\":\"订单项的唯一标识符\",\"columnId\":19,\"columnName\":\"example_id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-27 21:59:25\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"exampleId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ExampleOrderId\",\"columnComment\":\"关联订单的ID\",\"columnId\":20,\"columnName\":\"example_order_id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-27 21:59:25\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"exampleOrderId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ExampleProductId\",\"columnComment\":\"商品的ID\",\"columnId\":21,\"columnName\":\"example_product_id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-27 21:59:25\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"exampleProductId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Quantity\",\"columnComment\":\"商品数量\",\"columnId\":22,\"columnName\":\"quantity\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-27 21:59:25\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"is', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-27 22:05:35', 37);
INSERT INTO `sys_oper_log` VALUES (176, '代码生成', 2, 'com.ruoyi.gen.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/gen', '127.0.0.1', '', '{\"businessName\":\"ExampleOrders\",\"className\":\"ExampleOrders\",\"columns\":[{\"capJavaField\":\"ExampleId\",\"columnComment\":\"订单的唯一标识符\",\"columnId\":28,\"columnName\":\"example_id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-27 21:59:25\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"exampleId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ExampleUserId\",\"columnComment\":\"下单用户的ID\",\"columnId\":29,\"columnName\":\"example_user_id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-27 21:59:25\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"exampleUserId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"OrderDate\",\"columnComment\":\"下单日期\",\"columnId\":30,\"columnName\":\"order_date\",\"columnType\":\"timestamp\",\"createBy\":\"admin\",\"createTime\":\"2025-07-27 21:59:25\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"datetime\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"orderDate\",\"javaType\":\"Date\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"TotalAmount\",\"columnComment\":\"订单总金额\",\"columnId\":31,\"columnName\":\"total_amount\",\"columnType\":\"decimal(12,2)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-27 21:59:25\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-27 22:06:19', 50);
INSERT INTO `sys_oper_log` VALUES (177, '代码生成', 3, 'com.ruoyi.gen.controller.GenController.remove()', 'DELETE', 1, 'admin', NULL, '/gen/2', '127.0.0.1', '', '[2]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-27 22:06:26', 16);
INSERT INTO `sys_oper_log` VALUES (178, '代码生成', 2, 'com.ruoyi.gen.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/gen', '127.0.0.1', '', '{\"businessName\":\"ExamplePayments\",\"className\":\"ExamplePayments\",\"columns\":[{\"capJavaField\":\"ExampleId\",\"columnComment\":\"支付记录的唯一标识符\",\"columnId\":40,\"columnName\":\"example_id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-27 21:59:25\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"exampleId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":5,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ExampleOrderId\",\"columnComment\":\"关联订单的ID\",\"columnId\":41,\"columnName\":\"example_order_id\",\"columnType\":\"int(11)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-27 21:59:25\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"exampleOrderId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":5,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"PaymentMethod\",\"columnComment\":\"支付方式\",\"columnId\":42,\"columnName\":\"payment_method\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-27 21:59:25\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"paymentMethod\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":5,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Amount\",\"columnComment\":\"支付金额\",\"columnId\":43,\"columnName\":\"amount\",\"columnType\":\"decimal(12,2)\",\"createBy\":\"admin\",\"createTime\":\"2025-07-27 21:59:25\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-27 22:07:01', 38);
INSERT INTO `sys_oper_log` VALUES (179, '代码生成', 8, 'com.ruoyi.gen.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/gen/batchGenCode', '127.0.0.1', '', '{\"tables\":\"example_categories,example_products,example_users,example_order_items,example_orders,example_payments\"}', NULL, 0, NULL, '2025-07-27 22:07:39', 1008);
INSERT INTO `sys_oper_log` VALUES (180, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"example/ExampleCategories/index\",\"createTime\":\"2025-07-27 22:10:14\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2030,\"menuName\":\"存储商品类别的信息\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2029,\"path\":\"ExampleCategories\",\"perms\":\"example:ExampleCategories:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-27 22:12:14', 14);
INSERT INTO `sys_oper_log` VALUES (181, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"example/ExampleProducts/index\",\"createTime\":\"2025-07-27 22:11:07\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2054,\"menuName\":\"存储商品的信息\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2029,\"path\":\"ExampleProducts\",\"perms\":\"example:ExampleProducts:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-27 22:12:23', 12);
INSERT INTO `sys_oper_log` VALUES (182, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"example/ExampleOrders/index\",\"createTime\":\"2025-07-27 22:10:44\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2042,\"menuName\":\"存储订单的信息\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":2029,\"path\":\"ExampleOrders\",\"perms\":\"example:ExampleOrders:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-27 22:12:37', 15);
INSERT INTO `sys_oper_log` VALUES (183, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"example/ExampleOrderItems/index\",\"createTime\":\"2025-07-27 22:10:30\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2036,\"menuName\":\"存储订单中每种商品的详细信息\",\"menuType\":\"C\",\"orderNum\":5,\"params\":{},\"parentId\":2029,\"path\":\"ExampleOrderItems\",\"perms\":\"example:ExampleOrderItems:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-27 22:12:46', 10);
INSERT INTO `sys_oper_log` VALUES (184, '菜单管理', 2, 'com.ruoyi.system.controller.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/menu', '127.0.0.1', '', '{\"children\":[],\"component\":\"example/ExamplePayments/index\",\"createTime\":\"2025-07-27 22:10:57\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2048,\"menuName\":\"存储支付信息\",\"menuType\":\"C\",\"orderNum\":6,\"params\":{},\"parentId\":2029,\"path\":\"ExamplePayments\",\"perms\":\"example:ExamplePayments:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-07-27 22:12:54', 13);

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '岗位名称',
  `post_sort` int(4) NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '岗位信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_post` VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_post` VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2025-07-15 22:53:55', '', NULL, '');
INSERT INTO `sys_post` VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2025-07-15 22:53:55', '', NULL, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '角色权限字符串',
  `role_sort` int(4) NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '角色信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2025-07-15 22:53:55', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2025-07-15 22:53:55', '', NULL, '普通角色');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `dept_id` bigint(20) NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '角色和部门关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (2, 100);
INSERT INTO `sys_role_dept` VALUES (2, 101);
INSERT INTO `sys_role_dept` VALUES (2, 105);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '角色和菜单关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 2);
INSERT INTO `sys_role_menu` VALUES (2, 3);
INSERT INTO `sys_role_menu` VALUES (2, 4);
INSERT INTO `sys_role_menu` VALUES (2, 100);
INSERT INTO `sys_role_menu` VALUES (2, 101);
INSERT INTO `sys_role_menu` VALUES (2, 102);
INSERT INTO `sys_role_menu` VALUES (2, 103);
INSERT INTO `sys_role_menu` VALUES (2, 104);
INSERT INTO `sys_role_menu` VALUES (2, 105);
INSERT INTO `sys_role_menu` VALUES (2, 106);
INSERT INTO `sys_role_menu` VALUES (2, 107);
INSERT INTO `sys_role_menu` VALUES (2, 108);
INSERT INTO `sys_role_menu` VALUES (2, 109);
INSERT INTO `sys_role_menu` VALUES (2, 110);
INSERT INTO `sys_role_menu` VALUES (2, 111);
INSERT INTO `sys_role_menu` VALUES (2, 112);
INSERT INTO `sys_role_menu` VALUES (2, 113);
INSERT INTO `sys_role_menu` VALUES (2, 114);
INSERT INTO `sys_role_menu` VALUES (2, 115);
INSERT INTO `sys_role_menu` VALUES (2, 116);
INSERT INTO `sys_role_menu` VALUES (2, 500);
INSERT INTO `sys_role_menu` VALUES (2, 501);
INSERT INTO `sys_role_menu` VALUES (2, 1000);
INSERT INTO `sys_role_menu` VALUES (2, 1001);
INSERT INTO `sys_role_menu` VALUES (2, 1002);
INSERT INTO `sys_role_menu` VALUES (2, 1003);
INSERT INTO `sys_role_menu` VALUES (2, 1004);
INSERT INTO `sys_role_menu` VALUES (2, 1005);
INSERT INTO `sys_role_menu` VALUES (2, 1006);
INSERT INTO `sys_role_menu` VALUES (2, 1007);
INSERT INTO `sys_role_menu` VALUES (2, 1008);
INSERT INTO `sys_role_menu` VALUES (2, 1009);
INSERT INTO `sys_role_menu` VALUES (2, 1010);
INSERT INTO `sys_role_menu` VALUES (2, 1011);
INSERT INTO `sys_role_menu` VALUES (2, 1012);
INSERT INTO `sys_role_menu` VALUES (2, 1013);
INSERT INTO `sys_role_menu` VALUES (2, 1014);
INSERT INTO `sys_role_menu` VALUES (2, 1015);
INSERT INTO `sys_role_menu` VALUES (2, 1016);
INSERT INTO `sys_role_menu` VALUES (2, 1017);
INSERT INTO `sys_role_menu` VALUES (2, 1018);
INSERT INTO `sys_role_menu` VALUES (2, 1019);
INSERT INTO `sys_role_menu` VALUES (2, 1020);
INSERT INTO `sys_role_menu` VALUES (2, 1021);
INSERT INTO `sys_role_menu` VALUES (2, 1022);
INSERT INTO `sys_role_menu` VALUES (2, 1023);
INSERT INTO `sys_role_menu` VALUES (2, 1024);
INSERT INTO `sys_role_menu` VALUES (2, 1025);
INSERT INTO `sys_role_menu` VALUES (2, 1026);
INSERT INTO `sys_role_menu` VALUES (2, 1027);
INSERT INTO `sys_role_menu` VALUES (2, 1028);
INSERT INTO `sys_role_menu` VALUES (2, 1029);
INSERT INTO `sys_role_menu` VALUES (2, 1030);
INSERT INTO `sys_role_menu` VALUES (2, 1031);
INSERT INTO `sys_role_menu` VALUES (2, 1032);
INSERT INTO `sys_role_menu` VALUES (2, 1033);
INSERT INTO `sys_role_menu` VALUES (2, 1034);
INSERT INTO `sys_role_menu` VALUES (2, 1035);
INSERT INTO `sys_role_menu` VALUES (2, 1036);
INSERT INTO `sys_role_menu` VALUES (2, 1037);
INSERT INTO `sys_role_menu` VALUES (2, 1038);
INSERT INTO `sys_role_menu` VALUES (2, 1039);
INSERT INTO `sys_role_menu` VALUES (2, 1040);
INSERT INTO `sys_role_menu` VALUES (2, 1041);
INSERT INTO `sys_role_menu` VALUES (2, 1042);
INSERT INTO `sys_role_menu` VALUES (2, 1043);
INSERT INTO `sys_role_menu` VALUES (2, 1044);
INSERT INTO `sys_role_menu` VALUES (2, 1045);
INSERT INTO `sys_role_menu` VALUES (2, 1046);
INSERT INTO `sys_role_menu` VALUES (2, 1047);
INSERT INTO `sys_role_menu` VALUES (2, 1048);
INSERT INTO `sys_role_menu` VALUES (2, 1049);
INSERT INTO `sys_role_menu` VALUES (2, 1050);
INSERT INTO `sys_role_menu` VALUES (2, 1051);
INSERT INTO `sys_role_menu` VALUES (2, 1052);
INSERT INTO `sys_role_menu` VALUES (2, 1053);
INSERT INTO `sys_role_menu` VALUES (2, 1054);
INSERT INTO `sys_role_menu` VALUES (2, 1055);
INSERT INTO `sys_role_menu` VALUES (2, 1056);
INSERT INTO `sys_role_menu` VALUES (2, 1057);
INSERT INTO `sys_role_menu` VALUES (2, 1058);
INSERT INTO `sys_role_menu` VALUES (2, 1059);
INSERT INTO `sys_role_menu` VALUES (2, 1060);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint(20) NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '账号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `pwd_update_date` datetime NULL DEFAULT NULL COMMENT '密码最后更新时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '用户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', '若依', '00', 'ry@163.com', '15888888888', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2025-07-27 21:57:57', '2025-07-15 22:53:55', 'admin', '2025-07-15 22:53:55', '', '2025-07-27 21:57:57', '管理员');
INSERT INTO `sys_user` VALUES (2, 105, 'ry', '若依', '00', 'ry@qq.com', '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2025-07-15 22:53:55', '2025-07-15 22:53:55', 'admin', '2025-07-15 22:53:55', '', NULL, '测试员');

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `post_id` bigint(20) NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '用户与岗位关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);
INSERT INTO `sys_user_post` VALUES (2, 2);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '用户和角色关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);

SET FOREIGN_KEY_CHECKS = 1;
