package com.anifinders.safebox;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class SafeBoxApplication {

	public static void main(String[] args) {
		try {
			SpringApplication.run(SafeBoxApplication.class, args);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
