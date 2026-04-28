package com.ruoyi.system.api;

import com.ruoyi.common.core.web.domain.AjaxResult;
import com.ruoyi.system.api.domain.PaymentRecord;

public interface RemotePaymentService {

    public PaymentRecord payment(Long id);

}
