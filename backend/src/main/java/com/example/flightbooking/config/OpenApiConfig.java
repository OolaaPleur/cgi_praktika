package com.example.flightbooking.config;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.info.Contact;
import io.swagger.v3.oas.models.servers.Server;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.List;

@Configuration
public class OpenApiConfig {

    @Bean
    public OpenAPI myOpenAPI() {
        Server devServer = new Server()
                .url("http://localhost:8080")
                .description("Development server");

        Contact contact = new Contact()
                .name("Artem Suvorov");

        Info info = new Info()
                .title("Flight Booking API")
                .version("1.0")
                .contact(contact)
                .description("This API exposes endpoints to manage flight bookings.");

        return new OpenAPI()
                .info(info)
                .servers(List.of(devServer));
    }
} 