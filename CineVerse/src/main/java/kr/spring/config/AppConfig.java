package kr.spring.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesView;
import org.springframework.web.servlet.view.tiles3.TilesViewResolver;

import kr.spring.interceptor.AutoLoginCheckInterceptor;
import kr.spring.interceptor.LoginCheckInterceptor;

//자바코드 기반 설정 클래스
@Configuration
public class AppConfig implements WebMvcConfigurer{
	private LoginCheckInterceptor loginCheck;
	private AutoLoginCheckInterceptor autoLoginCheck;
	
	@Bean
	public AutoLoginCheckInterceptor interceptor() {
		autoLoginCheck = new AutoLoginCheckInterceptor();
		
		return autoLoginCheck;
	}
	
	
	@Bean
	public LoginCheckInterceptor interceptor2() {
		loginCheck = new LoginCheckInterceptor();
		return loginCheck;
	}
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		// auto Login Check
		registry.addInterceptor(autoLoginCheck).addPathPatterns("/**")
		   									   .excludePathPatterns("/images/**")
		   									   .excludePathPatterns("/image_upload/**")
		   									   .excludePathPatterns("/upload/**")
		   									   .excludePathPatterns("/css/**")
		   									   .excludePathPatterns("/js/**")
		   									   .excludePathPatterns("/member/login")
		   									   .excludePathPatterns("/member/logout");	
		
		//LoginCheckInterceptor 설정
		registry.addInterceptor(loginCheck)
		        .addPathPatterns("/member/myPage")
		        .addPathPatterns("/member/update")
		        .addPathPatterns("/member/changePassword")
		        .addPathPatterns("/member/delete")
		        .addPathPatterns("/board/write")
		        .addPathPatterns("/board/update")
		        .addPathPatterns("/board/delete")
		        .addPathPatterns("/myPage/myPageMain")
				.addPathPatterns("/myPage/reservation")
				.addPathPatterns("/myPage/coupon")
				.addPathPatterns("/myPage/expectingMovie")
				.addPathPatterns("/myPage/watchedMovie")
				.addPathPatterns("/myPage/review")
				.addPathPatterns("/myPage/bookMark")
				.addPathPatterns("/myPage/boardWrite")
				.addPathPatterns("/myPage/boardReply")
				.addPathPatterns("/myPage/aBoardBookMark")
				.addPathPatterns("/myPage/aBoardWrite")
				.addPathPatterns("/myPage/aBoardReply")
				.addPathPatterns("/myPage/myEvent")
				.addPathPatterns("/myPage/pointList")
				.addPathPatterns("/myPage/addressList")
				.addPathPatterns("/myPage/addAddress")
				.addPathPatterns("/myPage/bought")
				.addPathPatterns("/myPage/boughtDetail")
				.addPathPatterns("/myPage/chatList")
				.addPathPatterns("/myPage/passwdChange")
				.addPathPatterns("/myPage/modifyUser")
				.addPathPatterns("/myPage/deleteMember")
				.addPathPatterns("/myPage/memberShipSub")
				.addPathPatterns("/myPage/consult")
				.addPathPatterns("/movie/write")
				.addPathPatterns("/movie/update")
				.addPathPatterns("/movie/delete")
				.addPathPatterns("/shop/shopBasket")
				.addPathPatterns("/shop/addToCart")
				.addPathPatterns("/shop/buyNow")
				.addPathPatterns("/shop/shopFav")
				.addPathPatterns("/support/consult");
		
				
	}
	
	@Bean
	public TilesConfigurer tilesConfigurer() {
		final TilesConfigurer configurer = 
				                  new TilesConfigurer();
		//XML 설정 파일 경로 지정
		configurer.setDefinitions(new String[] {
				"/WEB-INF/tiles-def/main.xml",
				"/WEB-INF/tiles-def/cje.xml",
				"/WEB-INF/tiles-def/hjt.xml",
				"/WEB-INF/tiles-def/jmj.xml",
				"/WEB-INF/tiles-def/kbm.xml",
				"/WEB-INF/tiles-def/ksh.xml",
				"/WEB-INF/tiles-def/pgh.xml",
				"/WEB-INF/tiles-def/pmj.xml"
		});
		configurer.setCheckRefresh(true);
		return configurer;
	}
	@Bean
	public TilesViewResolver tilesViewResolver() {
		final TilesViewResolver tilesViewResolver = 
				                  new TilesViewResolver();
		tilesViewResolver.setViewClass(TilesView.class);
		return tilesViewResolver;
	}
}







