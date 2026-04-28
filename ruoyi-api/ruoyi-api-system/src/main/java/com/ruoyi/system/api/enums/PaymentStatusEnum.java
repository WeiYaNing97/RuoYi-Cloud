package com.ruoyi.system.api.enums;

import lombok.Getter;

/**
 * 支付状态枚举
 * 用于表示支付记录中的支付状态
 */
@Getter
public enum PaymentStatusEnum {

    /**
     * 处理中
     */
    PROCESSING(0, "处理中"),

    /**
     * 成功
     */
    SUCCESS(1, "成功"),

    /**
     * 失败
     */
    FAILURE(2, "失败"),

    /**
     * 已取消
     */
    CANCELLED(3, "已取消"),

    /**
     * 超时
     */
    TIMEOUT(4, "超时");

    /**
     * 支付状态编码
     */
    private final Integer code;

    /**
     * 支付状态描述
     */
    private final String description;

    PaymentStatusEnum(Integer code, String description) {
        this.code = code;
        this.description = description;
    }

    /**
     * 根据编码获取支付状态枚举
     *
     * @param code 支付状态编码
     * @return 支付状态枚举，如果未找到返回 null
     */
    public static PaymentStatusEnum getByCode(Integer code) {
        for (PaymentStatusEnum status : values()) {
            if (status.getCode().equals(code)) {
                return status;
            }
        }
        return null;
    }

    /**
     * 根据编码获取支付状态描述
     *
     * @param code 支付状态编码
     * @return 支付状态描述，如果未找到返回空字符串
     */
    public static String getDescriptionByCode(Integer code) {
        PaymentStatusEnum status = getByCode(code);
        return status != null ? status.getDescription() : "";
    }
}