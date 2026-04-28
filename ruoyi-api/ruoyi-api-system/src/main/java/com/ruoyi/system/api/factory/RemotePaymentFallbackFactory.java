package com.ruoyi.system.api.factory;

import com.ruoyi.common.core.domain.R;
import com.ruoyi.system.api.RemotePaymentService;
import com.ruoyi.system.api.domain.PaymentRecord;
import com.ruoyi.system.api.enums.PaymentMethodEnum;
import com.ruoyi.system.api.enums.PaymentStatusEnum;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cloud.openfeign.FallbackFactory;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;

@Component
public class RemotePaymentFallbackFactory  implements FallbackFactory<RemotePaymentService> {
    private static final Logger log = LoggerFactory.getLogger(RemotePaymentFallbackFactory.class);

    @Override
    public RemotePaymentService create(Throwable throwable) {
        log.error("支付服务调用失败:{}", throwable.getMessage());
        return new RemotePaymentService() {
            @Override
            public PaymentRecord payment(Long id) {
                PaymentRecord payment = PaymentRecord.builder()
                        .id(id)
                        .bizOrderId("RemotePaymentFallbackFactory")
                        .paymentMethod(PaymentMethodEnum.WECHAT.getCode())
                        .paymentTime(LocalDateTime.now())
                        .status(PaymentStatusEnum.FAILURE.getCode())
                        .build();
                return payment;
            }
        };
    }
}
