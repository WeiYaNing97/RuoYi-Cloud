package com.ruoyi.rabbitmq.pubsub;

import com.rabbitmq.client.Channel;
import org.springframework.amqp.rabbit.annotation.Exchange;
import org.springframework.amqp.rabbit.annotation.Queue;
import org.springframework.amqp.rabbit.annotation.QueueBinding;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.amqp.support.AmqpHeaders;
import org.springframework.messaging.handler.annotation.Header;
import org.springframework.stereotype.Component;

import java.io.IOException;

/**
 * fanout 类型的交换机介绍
 *个人理解：与交换机名称 和 fanout类型有关， 与队列名无关。只要是绑定了fanout类型的交换机，那么无论队列名称是什么，都会收到消息。
 *
 *
 * 1. fanout 交换机的基本概念
 * fanout 类型的交换机是消息队列（如 RabbitMQ）中的一种交换机类型。
 * 它的主要特点是会将接收到的消息广播给所有绑定的队列，而不管这些队列是如何定义的。 因此，无论队列的名称或属性如何，所有绑定到该交换机的队列都会收到相同的消息。
 * 这种广播机制使得 fanout 交换机非常适合于需要将消息发送给多个消费者的场景。
 *
 * 2. fanout 交换机的工作原理
 * 消息发布：当生产者向 fanout 交换机发送一条消息时，交换机不会进行任何路由判断。
 * 消息广播：交换机会将接收到的消息广播给所有已经绑定到该交换机的队列。
 * 消费者接收：每个绑定到该交换机的队列都会收到相同的消息副本，由各自绑定的消费者进行处理。
 *
 * 3. fanout 交换机的应用场景
 * 日志收集：在分布式系统中，可以将日志消息发送到 fanout 交换机，所有绑定的队列（代表不同的日志收集服务）都会收到这些日志消息。
 * 通知系统：在需要向多个用户或系统发送通知的场景中，可以使用 fanout 交换机将通知消息广播给所有订阅者。
 * 事件驱动架构：在事件驱动的应用程序中，事件可以被广播给所有感兴趣的事件处理者，而不需要关心具体有多少个处理者。
 *
 * 4. 示例说明
 * 在您提供的背景知识中，有一个示例代码片段，展示了如何将队列绑定到一个名为 "boot_pubsub" 的 fanout 类型的交换机。
 * 这意味着任何发送到 "boot_pubsub" 交换机的消息都将被广播给所有绑定到该交换机的队列。
 *
 * // 将队列绑定到一个名为 "boot_pubsub" 的 fanout 类型的交换机
 * 这个操作通常是在消息队列系统的配置或初始化阶段完成的。一旦绑定完成，生产者就可以向 "boot_pubsub" 交换机发送消息，而所有绑定的队列都会接收到这些消息。
 *
 */
@Component
public class PUBSUBConsumer {


    /**
     * RabbitMQ消息监听器。
     * 个人理解：与交换机名称 和 fanout类型有关， 与队列名无关。只要是绑定了fanout类型的交换机，那么无论队列名称是什么，都会收到消息。
     * 使用@RabbitListener注解，绑定一个队列到名为"boot_pubsub"的fanout类型交换机。
     * 当队列接收到消息时，会调用此方法处理消息。
     * @param message 接收到的消息对象
     */
    @RabbitListener(
            // 绑定队列到交换机
            bindings = @QueueBinding(
                    // 定义一个队列
                    value = @Queue(name = "QueueName01",durable = "true"),
                    // 将队列绑定到一个名为 "boot_pubsub" 的 fanout 类型的交换机
                    exchange = @Exchange(name = "boot_pubsub",type = "fanout")))
    public void handleMessage(Object message, @Header(AmqpHeaders.DELIVERY_TAG) long deliveryTag, Channel channel) {

        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }
        // 确保消息处理成功后才进行确认
        try {
            channel.basicAck(deliveryTag, false); // 或者根据需要改成批量确认
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        // 输出接收到的消息
        System.err.println("handleMessageReceived message: " + message);
    }



    @RabbitListener(
            bindings = @QueueBinding(
                    value = @Queue(name = "QueueName02",durable = "true"),
                    exchange = @Exchange(name = "boot_pubsub",type = "fanout")))
    public void handleMessagetTwo(Object message, @Header(AmqpHeaders.DELIVERY_TAG) long deliveryTag, Channel channel) {
        try {
            Thread.sleep(3000);
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }
        // 确保消息处理成功后才进行确认
        try {
            channel.basicAck(deliveryTag, false); // 或者根据需要改成批量确认
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        System.out.println("handleMessagetTwo Received message: " + message);
    }
}
