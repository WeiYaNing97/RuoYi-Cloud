package com.ruoyi.rabbitmq.routing;

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
public class RoutingConsumerTWO {


    /**
     * 使用RabbitMQ的监听器注解，监听特定队列的消息。
     *
     * @RabbitListener注解配置了消息监听器，用于监听来自特定队列的消息。
     * bindings属性通过@QueueBinding注解将队列与交换机进行绑定，并指定了路由键。
     *
     * durable = "true"表示队列或交换机会被设置为持久化的，这意味着如果RabbitMQ服务器重启，
     * 队列和交换机将会被重新声明并且消息不会丢失（前提是消息本身也被标记为持久化）。
     * 相反，durable = "false"表示非持久化。对于队列，默认值取决于具体的客户端库或配置，但在很多情况下，默认是非持久化的。
     * 持久化主要指的是队列、交换机以及消息本身的持久性，确保它们能在服务器重启后依然存在或者恢复。
     * 对于消息来说，还需要配合使用deliveryMode=2来保证消息本身也是持久化的。
     * @param message 接收到的消息对象。
     */
    @RabbitListener(
            // 使用@QueueBinding注解绑定队列和交换机
            bindings = @QueueBinding(
                    // 定义队列，队列名为"bootrountingqueue"
                    // 队列 起名规则（服务名+业务名+成功+队列），durable持久化
                    //value = @Queue(name = "store.addFavorite.success.queue", durable = "true"),
                    value = @Queue(name = "bootrountingqueueTWO"), //队列名
                    // 定义交换机，交换机名为"bootrountingexchange"，类型为direct
                    exchange = @Exchange(name = "bootrountingexchangeTWO",type = "direct"), //交换机名 交换机类型为direct
                    // 定义路由键，只处理路由键为"error"、"info"或"zidingyi"的消息
                    key = {"error","info","zidingyi"} //定向参数
            ))
    public void handleMessage(Object message, @Header(AmqpHeaders.DELIVERY_TAG) long deliveryTag, Channel channel) {
        if (channel.isOpen()) {
            // 打印接收到的消息
            System.out.println("RoutingConsumer message2: " + message);
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
