package com.ruoyi.rabbitmq.controller;

import com.ruoyi.rabbitmq.pubsub.PUBSUBProducer;
import com.ruoyi.rabbitmq.routing.RoutingProducer;
import com.ruoyi.rabbitmq.topic.TopicProducer;
import com.ruoyi.rabbitmq.work.WorkProducer;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Api(tags = "RabbitMQ测试接口类")
@RestController
@RequestMapping("/RabbitMQController")
public class RabbitMQController {

    @Autowired
    private PUBSUBProducer pubsubProducer;
    @Autowired
    private WorkProducer workProducer;
    @Autowired
    private RoutingProducer routingProducer;
    @Autowired
    private TopicProducer topicProducer;

    @ApiOperation(value = "workMessage")
    @GetMapping("/work")
    public String workMessage() {/*String msg*/

        for (int i = 1; i <= 10; i++) {
            workProducer.sendMessage("work === "+i);
        }

        System.out.println("Message sent!");
        return "Message sent!";
    }

    @ApiOperation(value = "pubsubMessage")
    @GetMapping("/pubsub")
    public String pubsubMessage() {
        String msg = "pubsub";
        for (int i = 1; i <= 10; i++) {
            pubsubProducer.sendMessage(msg);
        }
        return "Message sent!";
    }

    @ApiOperation(value = "routingMessage")
    @GetMapping("/routing")
    public String routingMessage() {/*String key,String msg*/
        String key ="info";
        for (int i = 1; i <= 100; i++) {
            String msg = "msg =====  "+i;
            routingProducer.sendMessage(key,msg);
        }

        String keyTWO ="zidingyi";
        for (int i = 1; i <= 100; i++) {
            String msg = "msgTWO"+i;
            //routingProducer.sendMessageTWO(keyTWO,msg);
        }

        return "Message sent!";
    }

    @ApiOperation(value = "topicMessage")
    @GetMapping("/topic")
    public String topicMessage() {/*String key,String msg*/

        String key ="info.aaa";
        for (int i = 1; i <= 100; i++) {
            String msg = "msg"+i;
            topicProducer.sendMessage(key,msg);
        }
        return "Message sent!";
    }
}

