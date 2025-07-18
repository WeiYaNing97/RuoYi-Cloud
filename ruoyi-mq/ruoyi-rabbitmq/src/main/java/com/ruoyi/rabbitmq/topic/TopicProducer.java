package com.ruoyi.rabbitmq.topic;

import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class TopicProducer {

    @Autowired
    private RabbitTemplate rabbitTemplate;

    /**
     * 发送消息到RabbitMQ交换机中，并将消息路由到与指定key匹配的队列中。
     *
     * @param key 路由键，用于指定消息应该被路由到哪个队列
     * @param msg 要发送的消息内容
     */
    public void sendMessage(String key,String msg) {
        // 调用rabbitTemplate的convertAndSend方法发送消息
        // 第一个参数是交换机名称，这里为"boottopicexchange"
        // 第二个参数是路由键，即key
        // 第三个参数是要发送的消息内容，这里为"rounting消息:"+msg
        rabbitTemplate.convertAndSend("boottopicexchange",key,"rounting消息:"+msg);
    }
}

