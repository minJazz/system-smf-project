package kr.co.smf.system.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import kr.co.smf.system.access.AuthCheckInterceptor;

@Configuration
public class MvcConfiguration implements WebMvcConfigurer {
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
//		registry.addInterceptor(new AuthCheckInterceptor())
//		.excludePathPatterns("/WEB-INF/jsp/access/login.jsp");
	}
}
