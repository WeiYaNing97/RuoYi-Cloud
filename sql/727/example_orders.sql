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

 Date: 27/07/2025 21:34:40
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '存储订单的信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of example_orders
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
