package com.ruoyi.system.api;

import com.ruoyi.common.core.constant.ServiceNameConstants;
import com.ruoyi.common.core.domain.R;
import com.ruoyi.system.api.domain.PaymentRecord;
import com.ruoyi.system.api.factory.RemotePaymentFallbackFactory;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@FeignClient(contextId = "remotePaymentService", value = ServiceNameConstants.POINTS_SERVICE, fallbackFactory = RemotePaymentFallbackFactory.class)
public interface RemotePaymentService {

    @GetMapping("/PtsAccount/getPaymentRecord")
    public PaymentRecord payment(@RequestParam("id") Long id);

}
