package com.ruoyi.system.api.enums;

import lombok.Getter;

/**
 * 订单状态枚举
 * 用于表示订单的状态
 */
@Getter
public enum OrderStatusEnum {

    /**
     * 待支付
     */
    PENDING_PAYMENT(0, "待支付"),

    /**
     * 待发货
     */
    PENDING_SHIPMENT(1, "待发货"),

    /**
     * 已发货
     */
    SHIPPED(2, "已发货"),

    /**
     * 已完成
     */
    COMPLETED(3, "已完成"),

    /**
     * 已关闭
     */
    CLOSED(4, "已关闭");

    /**
     * 订单状态编码
     */
    private final Integer code;

    /**
     * 订单状态描述
     */
    private final String description;

    OrderStatusEnum(Integer code, String description) {
        this.code = code;
        this.description = description;
    }

    /**
     * 根据编码获取订单状态枚举
     *
     * @param code 订单状态编码
     * @return 订单状态枚举，如果未找到返回 null
     */
    public static OrderStatusEnum getByCode(Integer code) {
        for (OrderStatusEnum status : values()) {
            if (status.getCode().equals(code)) {
                return status;
            }
        }
        return null;
    }

    /**
     * 根据编码获取订单状态描述
     *
     * @param code 订单状态编码
     * @return 订单状态描述，如果未找到返回空字符串
     */
    public static String getDescriptionByCode(Integer code) {
        OrderStatusEnum status = getByCode(code);
        return status != null ? status.getDescription() : "";
    }
}