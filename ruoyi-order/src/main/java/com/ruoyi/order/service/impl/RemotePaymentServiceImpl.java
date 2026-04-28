package com.ruoyi.order.service.impl;

import com.ruoyi.system.api.RemotePaymentService;
import com.ruoyi.system.api.domain.PaymentRecord;
import com.ruoyi.system.api.enums.PaymentMethodEnum;
import com.ruoyi.system.api.enums.PaymentStatusEnum;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
public class RemotePaymentServiceImpl implements RemotePaymentService {

    /**
     * 默认支付成功
     * @param id
     * @return
     */
    @Override
    public PaymentRecord payment(Long id) {
        // 支付成功
        PaymentRecord  paymentRecord = PaymentRecord.builder()
                .id(id)
                .paymentMethod(PaymentMethodEnum.WECHAT.getCode())
                .paymentTime(LocalDateTime.now())
                .status(PaymentStatusEnum.SUCCESS.getCode())
                .build();
        return paymentRecord;
    }
}
