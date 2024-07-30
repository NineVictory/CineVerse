package kr.spring.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

import kr.spring.member.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class AuthCheckInterceptor implements HandlerInterceptor {
	@Override
	public boolean preHandle(HttpServletRequest request,
			                 HttpServletResponse response,
			                 Object handler) 
	                                throws Exception{
		log.debug("<<AuthCheckInterceptor 진입>>");
		
		HttpSession session = request.getSession();
		MemberVO user = (MemberVO)session.getAttribute("user");
		// 로그인한 user의 mem_auth == 9 인지 확인
		if(user.getMem_auth()!=9) {
			log.debug("<<AuthCheckInterceptor 관리자 아님>>");
			response.sendRedirect(
				request.getContextPath()+"/main/main");
			return false; 
		}
		log.debug("<<AuthCheckInterceptor 관리자>>");
		return true;
	}
}
