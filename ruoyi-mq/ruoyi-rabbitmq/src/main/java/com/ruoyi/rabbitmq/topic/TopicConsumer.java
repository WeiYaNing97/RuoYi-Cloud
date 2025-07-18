package com.ruoyi.rabbitmq.topic;

import com.rabbitmq.client.Channel;
import org.springframework.amqp.rabbit.annotation.Exchange;
import org.springframework.amqp.rabbit.annotation.Queue;
import org.springframework.amqp.rabbit.annotation.QueueBinding;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.amqp.support.AmqpHeaders;
import org.springframework.messaging.handler.annotation.Header;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Component
public class TopicConsumer {

    /**
     * 使用RabbitMQ的监听器注解，监听来自名为"boottopicexchange"的topic类型交换机发送的消息，
     * 并将这些消息路由到名为"boottopicqueue01"的队列中。
     *
     * @param message 接收到的消息对象
     *
     * 注意：该监听器绑定的队列仅接收路由键匹配"error.*"或"info.*"模式的消息。
     */
    @RabbitListener(bindings = @QueueBinding(
            // 队列绑定配置
            value = @Queue(name = "boottopicqueue"), // 队列名
            // 交换机绑定配置
            exchange = @Exchange(name = "boottopicexchange",type = "topic"), // 交换机名 交换机类型为topic
            // 路由键配置，匹配"error.*"或"info.*"模式的消息
            key = {"error.*","info.*"}
    ))
    public void handleMessage(Object message, @Header(AmqpHeaders.DELIVERY_TAG) long deliveryTag, Channel channel) {
        if (channel.isOpen()) {
            // 输出接收到的消息
            System.err.println("TopicConsumer message01: " + message);
            // 增加额外的业务处理逻辑
            // 确保消息处理成功后才进行确认
            try {
                channel.basicAck(deliveryTag, false); // 或者根据需要改成批量确认
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        } else {
            System.out.println("Channel is closed, cannot ack/nack");
        }
    }


    /**
     * 使用RabbitMQ的监听器注解，监听来自名为"boottopicexchange"的topic类型交换机发送的消息，
     * 并将这些消息路由到名为"boottopicqueue01"的队列中。
     *
     * @param message 接收到的消息对象
     *
     * 注意：该监听器绑定的队列仅接收路由键匹配"error.*"或"info.*"模式的消息。
     */
    @RabbitListener(bindings = @QueueBinding(
            // 队列绑定配置
            value = @Queue(name = "boottopicqueue"), // 队列名
            // 交换机绑定配置
            exchange = @Exchange(name = "boottopicexchange",type = "topic"), // 交换机名 交换机类型为topic
            // 路由键配置，匹配"error.*"或"info.*"模式的消息
            key = {"error.*","info.*"}
    ))
    public void handleMessage02(Object message, @Header(AmqpHeaders.DELIVERY_TAG) long deliveryTag, Channel channel) {
        if (channel.isOpen()) {
            // 输出接收到的消息
            System.err.println("TopicConsumer message02: " + message);
            // 增加额外的业务处理逻辑
            // 确保消息处理成功后才进行确认
            try {
                channel.basicAck(deliveryTag, false); // 或者根据需要改成批量确认
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        } else {
            System.out.println("Channel is closed, cannot ack/nack");
        }
    }
}
