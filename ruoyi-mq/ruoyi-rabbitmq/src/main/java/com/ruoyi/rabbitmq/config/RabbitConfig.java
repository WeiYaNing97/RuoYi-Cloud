package com.ruoyi.rabbitmq.config;

import org.springframework.amqp.rabbit.connection.ConnectionFactory;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class RabbitConfig {


    /**
     * 创建一个RabbitTemplate的Bean，用于与RabbitMQ进行交互。
     *
     * @param connectionFactory 连接RabbitMQ所需的连接工厂
     * @return 配置好的RabbitTemplate实例
     */
    @Bean
    public RabbitTemplate rabbitTemplate(ConnectionFactory connectionFactory) {
        // 创建一个RabbitTemplate对象，并将connectionFactory作为参数传递给它的构造函数
        RabbitTemplate rabbitTemplate = new RabbitTemplate(connectionFactory);

        // 设置RabbitTemplate的确认回调，以便处理消息的确认和拒绝
        // rabbitTemplate.setConfirmCallback(...);

        // 设置RabbitTemplate的返回回调，以便处理消息的返回
        // rabbitTemplate.setReturnCallback(...);

        // 还可以设置其他属性，如消息转换器、重试机制等

        // 返回配置好的RabbitTemplate实例
        return rabbitTemplate;
    }

}
