package com.ruoyi.rabbitmq.work;

import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class WorkProducer {
    @Autowired
    private RabbitTemplate rabbitTemplate;

    /**
     * 发送消息到RabbitMQ的"springbootrabbitMQwork"队列中。
     *
     * @param msg 要发送的消息内容
     */
    public void sendMessage(String msg) {
        // 调用rabbitTemplate的convertAndSend方法发送消息
        // 第一个参数为路由键，这里为空字符串，表示不使用路由键
        // 第二个参数为目标队列名，"springbootrabbitMQwork"
        // 第三个参数为要发送的消息内容，即msg
        rabbitTemplate.convertAndSend("","springbootrabbitMQwork",msg);
    }
}
