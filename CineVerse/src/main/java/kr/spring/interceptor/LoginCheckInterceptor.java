package kr.spring.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class LoginCheckInterceptor implements HandlerInterceptor{
	@Override
	public boolean preHandle(HttpServletRequest request,
			                 HttpServletResponse response,
			                 Object handler) 
	                                throws Exception{
		log.debug("<<LoginCheckInterceptor 진입>>");
		
		HttpSession session = request.getSession();
		//로그인 여부 검사
		if(session.getAttribute("user")==null) {
			log.debug("<<LoginCheckInterceptor 로그아웃 상태>>");
			//로그인이 되지 않은 상태
			response.sendRedirect(
				request.getContextPath()+"/member/login");
			return false; //요청한 URL를 호출하지 않을 경우 false
		}
		log.debug("<<LoginCheckInterceptor 로그인 상태>>");
		return true;//요청한 URL를 호출할 경우 true
	}
}









