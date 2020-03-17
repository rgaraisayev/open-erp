package com.openerp.config;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@Configuration
@EnableScheduling
@ComponentScan(basePackages = "com.openerp")
@EntityScan("com.openerp.entity")
//@EnableFeignClients
public class OpenERPApplication {
	public static void main(String[] args) {
		SpringApplication.run(OpenERPApplication.class, args);
	}
}
