package kr.spring.config;

import java.util.Properties;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesView;
import org.springframework.web.servlet.view.tiles3.TilesViewResolver;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

import kr.spring.interceptor.AutoLoginCheckInterceptor;
import kr.spring.interceptor.LoginCheckInterceptor;
import kr.spring.websocket.SocketHandler;

//자바코드 기반 설정 클래스
@Configuration
public class AppConfig implements WebMvcConfigurer, WebSocketConfigurer{
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
				.addPathPatterns("/assignboard/write")
				.addPathPatterns("/support/consultForm");
		
				
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
	
	// 웹소켓 세팅하기
		@Override
		public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
			registry.addHandler(new SocketHandler(), "message-ws").setAllowedOrigins("*");
		}
	
	@Bean
    public JavaMailSenderImpl javaMailSenderImpl() {
    	Properties prop = new Properties();
    	prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");
    	prop.put("mail.smtp.starttls.enable", "true");
    	prop.put("mail.transport.protocol", "smtp");
    	prop.put("mail.smtp.auth", "true");
    	prop.put("mail.debug", "true");
    	
    	JavaMailSenderImpl javaMail = new JavaMailSenderImpl();
    	javaMail.setHost("smtp.gmail.com");
    	javaMail.setPort(587);
    	javaMail.setDefaultEncoding("utf-8");
    	javaMail.setUsername("movie.cineverse@gmail.com");
    	javaMail.setPassword("aqmjslsdwaxrliaf");
    	javaMail.setJavaMailProperties(prop);
    	return javaMail;
    }
}







