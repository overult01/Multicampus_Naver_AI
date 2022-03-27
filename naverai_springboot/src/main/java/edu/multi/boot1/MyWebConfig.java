package edu.multi.boot1;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

//현재 파일이 웹 설정을 포함한 파일
@Configuration
public class MyWebConfig implements WebMvcConfigurer {

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {

		registry
		.addResourceHandler("/upload/**")
		.addResourceLocations("file:///Users/jungmin/Desktop/kdt-venture/workspace/AI/naverai_springboot/upload/");		
		registry
		.addResourceHandler("/naverimages/**")
		.addResourceLocations("file:///Users/jungmin/Desktop/kdt-venture/workspace/AI/naverai_springboot/ai_images/");		
	}

	
	
}
