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

 Date: 27/07/2025 21:34:28
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '存储订单中每种商品的详细信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of example_order_items
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
