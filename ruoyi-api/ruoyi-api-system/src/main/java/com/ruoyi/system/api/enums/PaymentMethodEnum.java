package com.ruoyi.system.api.enums;

import lombok.Getter;

/**
 * 支付方式枚举
 * 用于表示支付记录中的支付方式
 */
@Getter
public enum PaymentMethodEnum {

    /**
     * 微信支付
     */
    WECHAT(1, "微信支付"),

    /**
     * 支付宝支付
     */
    ALIPAY(2, "支付宝支付"),

    /**
     * 银联支付
     */
    UNION_PAY(3, "银联支付"),

    /**
     * 银行卡支付
     */
    BANK_CARD(4, "银行卡支付"),

    /**
     * 现金支付
     */
    CASH(5, "现金支付"),

    /**
     * 其他支付方式
     */
    OTHER(99, "其他");

    /**
     * 支付方式编码
     */
    private final Integer code;

    /**
     * 支付方式描述
     */
    private final String description;

    PaymentMethodEnum(Integer code, String description) {
        this.code = code;
        this.description = description;
    }

    /**
     * 根据编码获取支付方式枚举
     *
     * @param code 支付方式编码
     * @return 支付方式枚举，如果未找到返回 null
     */
    public static PaymentMethodEnum getByCode(Integer code) {
        for (PaymentMethodEnum method : values()) {
            if (method.getCode().equals(code)) {
                return method;
            }
        }
        return null;
    }

    /**
     * 根据编码获取支付方式描述
     *
     * @param code 支付方式编码
     * @return 支付方式描述，如果未找到返回空字符串
     */
    public static String getDescriptionByCode(Integer code) {
        PaymentMethodEnum method = getByCode(code);
        return method != null ? method.getDescription() : "";
    }
}