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

 Date: 27/07/2025 21:34:18
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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '存储商品类别的信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of example_categories
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
