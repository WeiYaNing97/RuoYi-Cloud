package com.ruoyi.rabbitmq.routing;

import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class RoutingProducer {

    @Autowired
    private RabbitTemplate rabbitTemplate;

    /**
     * 发送消息到指定的交换机和路由键
     *
     * @param key 路由键，可以是定向参数之一："error"、"info"、"warning"
     * @param msg 要发送的消息内容
     */
    public void sendMessage(String key,String msg) {
        // 发送消息到名为"bootrountingexchange"的交换机，使用指定的路由键key，并附加消息内容"rounting消息:"+msg
        /*路由器key可以设置定向参数：error、info、warning*/
        rabbitTemplate.convertAndSend("bootrountingexchange",key,"rounting消息:"+msg);
    }
    public void sendMessageTWO(String key,String msg) {
        // 发送消息到名为"bootrountingexchange"的交换机，使用指定的路由键key，并附加消息内容"rounting消息:"+msg
        /*路由器key可以设置定向参数：error、info、warning*/
        rabbitTemplate.convertAndSend("bootrountingexchangeTWO",key,"rounting消息:"+msg);
    }
}

