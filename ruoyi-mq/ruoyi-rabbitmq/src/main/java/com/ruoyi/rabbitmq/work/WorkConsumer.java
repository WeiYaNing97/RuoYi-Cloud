package com.ruoyi.rabbitmq.work;

import com.rabbitmq.client.Channel;
import org.springframework.amqp.rabbit.annotation.Queue;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.amqp.support.AmqpHeaders;
import org.springframework.messaging.handler.annotation.Header;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Component
public class WorkConsumer {
    @RabbitListener(queuesToDeclare = @Queue("springbootrabbitMQwork"))
    public void receiveMsg(String msg, @Header(AmqpHeaders.DELIVERY_TAG) long deliveryTag, Channel channel) throws IOException {
        try {
            if (channel.isOpen()) {
                System.out.println("消费者1 收到消息:" + msg);
                // 增加额外的业务处理逻辑
                // 确保消息处理成功后才进行确认
                channel.basicAck(deliveryTag, false); // 或者根据需要改成批量确认
            } else {
                System.out.println("Channel is closed, cannot ack/nack");
            }
        } catch (Exception e) {
            // 处理异常情况，例如记录日志、重新排队等
            System.err.println("Error processing message: " + e.getMessage());
            // 根据实际情况决定是否拒绝消息
            channel.basicNack(deliveryTag, false, true);
        }
    }

    @RabbitListener(queuesToDeclare = @Queue("springbootrabbitMQwork"))
    public void receiveMsgTWO(String msg, @Header(AmqpHeaders.DELIVERY_TAG) long deliveryTag, Channel channel) throws IOException {
        try {
            if (channel.isOpen()) {
                System.err.println("消费者2 收到消息:" + msg);
                // 同样增加业务处理逻辑
                channel.basicAck(deliveryTag, false); // 或者根据需要改成批量确认
            } else {
                System.out.println("Channel is closed, cannot ack/nack");
            }
        } catch (Exception e) {
            System.err.println("Error processing message: " + e.getMessage());
            channel.basicNack(deliveryTag, false, true);
        }
    }
}
