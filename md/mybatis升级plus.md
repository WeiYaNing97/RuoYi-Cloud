Ruo-Cloud若依微服务版本集成mp(mybatis-plus)详细步骤

   第一次使用RuoYi-Cloud脚手架 ,业务表每要添加一个字段,就得去改xml里面的sql,就想着集成mybatis-plus来完成,经历了一系列的搜索,终于完成了,特此记录

第一步 父工程引入pom依赖,一定要记住是父工程,最外层的那个

![img](https://i-blog.csdnimg.cn/direct/fdfbeafdaf6a4b1f9ab5a32625b10a87.png)



![img](https://i-blog.csdnimg.cn/direct/71abe81c0c9c4588a9a8d74611bd2b6d.png)



这里提一嘴,别不小心引入错误了，是这个boot-starter 如果只是mp的话 是没有分页插件这些的

 版本不喜欢的话 自己找一个版本 要找有的版本  Maven Central: com.baomidou:mybatis-plus-boot-starter

           <!-- mp -->
            <dependency>
                <groupId>com.baomidou</groupId>
                <artifactId>mybatis-plus-boot-starter</artifactId>
                <version>${mybatis-plus-version}</version>
            </dependency>

引入之后这里要提一嘴  ruoyi-cloud有用到版本管理 也就是说用dependencyManagement标签,

有这个你直接点刷新,是不会去下载依赖的,除非你本地已经之前下过这个依赖,这里要用mvn clean install  来安装依赖  不知道怎么执行命令的 简单一点点击idea右边的maven  选住这两点击运行就可以



![img](https://i-blog.csdnimg.cn/direct/9ee60c397ab841cd898fe9054f04fb0b.png)



这一步完成之后  要在ruoyi-common-core中引入 不用指定版本了就



![img](https://i-blog.csdnimg.cn/direct/cbc6c6ec2b064b4a9d2cd321dfa946a0.png)



       <dependency>
            <groupId>com.baomidou</groupId>
            <artifactId>mybatis-plus-boot-starter</artifactId>
        </dependency>

引入之后 这里刷新一下就好了 

接下来 就是配置类的编写 自己根据自己的需求来定

我的话是配置了分页和乐观锁 以及全局操作表时锁表

    
    package com.ruoyi.common.core.config;
    
    
    import com.baomidou.mybatisplus.annotation.DbType;
    import com.baomidou.mybatisplus.extension.plugins.inner.BlockAttackInnerInterceptor;
    import com.baomidou.mybatisplus.extension.plugins.inner.OptimisticLockerInnerInterceptor;
    import com.baomidou.mybatisplus.extension.plugins.inner.PaginationInnerInterceptor;
    import org.springframework.context.annotation.Bean;
    import org.springframework.context.annotation.Configuration;
    
    @Configuration
    public class MyBatisPlusConfig {
        /**
         * 分页插件
         */
        @Bean
        public PaginationInnerInterceptor paginationInterceptor() {
            PaginationInnerInterceptor paginationInterceptor = new PaginationInnerInterceptor();
            // 设置请求的页面大于最大页后是否进行回滚, true回滚, false继续
            paginationInterceptor.setOverflow(false);
            // 设置最大单页限制数量, 默认 500 条, -1 不受限制
            paginationInterceptor.setDbType(DbType.MYSQL);
            paginationInterceptor.setMaxLimit(-1L);
            return paginationInterceptor;
        }
    
        /**
         * 乐观锁插件
         */
        @Bean
        public OptimisticLockerInnerInterceptor optimisticLockerInterceptor() {
            return new OptimisticLockerInnerInterceptor();
        }
    
        /**
         * 如果是对全表的删除或更新操作，就会终止该操作 https://baomidou.com/guide/interceptor-block-attack.html
         */
        public BlockAttackInnerInterceptor blockAttackInnerInterceptor() {
            return new BlockAttackInnerInterceptor();
        }
    }




这一步完成之后 要在resource目录下找到.imports文件 写入配置类路径

```
com.ruoyi.common.core.utils.SpringUtils
com.ruoyi.common.core.config.MyBatisPlusConfig
```



![img](https://i-blog.csdnimg.cn/direct/b643bdf1f998481b8da0b5f1df22effc.png)




这一步完成之后 就可以启动项目了  启动顺序为 Auth -> Getaway >System->后续你自己的服务

出现这个图标 就代表你启动成功了 



![img](https://i-blog.csdnimg.cn/direct/2c840a2e4bd34548821a47e3163f26a4.png)



但是也先别急 还有最后的步骤 就是在nacos配置中心里面 覆盖原来mybatis的配置



```
# mybatis配置
# mybatis:
    # 搜索指定包别名
   # typeAliasesPackage: com.ruoyi.system
    #  配置mapper的扫描，找到所有的mapper.xml映射文件
    # mapperLocations: classpath:mapper/**/*.xml
# mp配置    
mybatis-plus:
  mapper-locations: classpath*:mapper/**/*Mapper.xml  
  type-aliases-package: com.ruoyi.**.domain            
  global-config:
    db-config:
      id-type: ASSIGN_ID                                    
      logic-delete-value: 1                           
      logic-not-delete-value: 0                        
  configuration:
    map-underscore-to-camel-case: true                
    log-impl: org.apache.ibatis.logging.stdout.StdOutImpl
```

只需要覆盖原本有mybatis配置的yml 像File Auth这样的模块本身就没有这块的配置 就不用更改了

自己新建的服务也别忘记 最后就可以用mp来完成crud及其分页了 原生的mybtis也不会受到任何影响 

写到这里 希望有帮助



# 修改配置

将system中 mapper.xml中的实体类路径补全。
因为mybatis升级mybatis-plus后 扫描不到实体类。





原文链接：https://blog.csdn.net/weixin_61550453/article/details/143177953