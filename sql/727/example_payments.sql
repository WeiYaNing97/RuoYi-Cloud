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

 Date: 27/07/2025 21:34:53
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '存储支付信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of example_payments
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
