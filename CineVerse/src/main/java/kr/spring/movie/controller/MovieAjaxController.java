package kr.spring.movie.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;



import kr.spring.member.vo.MemberVO;
import kr.spring.movie.service.MovieService;
import kr.spring.movie.vo.MovieReviewVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MovieAjaxController {
	
	@Autowired
	private MovieService movieService;
	/*===================
	리뷰 등록
===================*/
@PostMapping("/movie/movieDetail")
@ResponseBody
public Map<String,String> writeReply(MovieReviewVO movieReviewVO,
									 HttpSession session,
									 HttpServletRequest request){
	log.debug("<<리뷰 등록>> :"+movieReviewVO);
	
	Map<String,String> mapJson = new HashMap<String, String>();
	
	MemberVO user = (MemberVO)session.getAttribute("user");
	if(user == null) {
		//로그인 안된경우
		mapJson.put("result","logout");
	}else {
		//회원번호 저장
		movieReviewVO.setMem_num(user.getMem_num());

		//댓글 등록
		movieService.insertReview(movieReviewVO);
		mapJson.put("result","success");
	}
	
	
	return mapJson;
}
}
