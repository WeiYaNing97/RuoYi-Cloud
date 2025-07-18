package com.ruoyi.rabbitmq.pubsub;

import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class PUBSUBProducer {

    @Autowired
    private RabbitTemplate rabbitTemplate;

    /**
     * 发送消息到RabbitMQ的"boot_pubsub"交换机中，并广播到所有与该交换机绑定的队列中。
     *
     * @param msg 要发送的消息内容
     */
    public void sendMessage(String msg) {
        // 使用rabbitTemplate的convertAndSend方法发送消息
        // 第一个参数是交换机的名称，即"boot_pubsub"
        // 第二个参数是路由键，这里为空字符串，表示使用默认的路由键
        // 第三个参数是要发送的消息内容
        rabbitTemplate.convertAndSend("boot_pubsub","",msg);
    }
}

