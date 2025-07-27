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

 Date: 27/07/2025 21:35:09
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '存储商品的信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of example_products
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
