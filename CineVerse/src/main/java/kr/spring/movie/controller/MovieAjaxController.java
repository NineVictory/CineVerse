package kr.spring.movie.controller;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.member.vo.MemberVO;
import kr.spring.movie.service.MovieService;
import kr.spring.movie.vo.MovieBookingVO;
import kr.spring.movie.vo.MovieReviewVO;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MovieAjaxController {

    @Autowired
    private MovieService movieService;
    /*=======================
	 * 리뷰 등록
	 *=======================*/
    @PostMapping("/movie/writeReview")
    @ResponseBody
    public Map<String,String> writeReview(@ModelAttribute MovieReviewVO review, HttpSession session) {
        MemberVO user = (MemberVO) session.getAttribute("user");
        long userMemNum = user != null ? user.getMem_num() : -1L;
        Map<String,String> mapJson = new HashMap<String, String>();
		/*
		 * // mb_num이 없는 경우에 대한 기본값 설정 if (review.getMb_num() == 0) { return "fail"; //
		 * 적절한 처리로 변경 가능 }
		 */
        
        boolean canWriteReview = movieService.canWriteReview(userMemNum, review.getM_code());
        if(user == null) {
			//로그인 안된경우
			mapJson.put("result","logout");
		}
        else if(canWriteReview) {
            review.setMem_num(userMemNum);
         // mb_num 값 설정
            MovieBookingVO bookingInfo = movieService.getBookingInfo(userMemNum, review.getM_code());
            if (bookingInfo != null) {
                review.setMb_num(bookingInfo.getMb_num());
            }
            log.debug("리뷰 등록: " + review);
            movieService.insertReview(review);
            mapJson.put("result","success");
        } 
        return mapJson;
    }
    /*===================
	리뷰 목록
===================*/
@GetMapping("/movie/listReview")
@ResponseBody
public Map<String,Object> getList(int m_code, int pageNum, 
									int rowCount, HttpSession session){
	log.debug("<<리뷰 목록 - m_code>> : "+m_code);
	log.debug("<<리뷰 목록 - page_num>> : "+pageNum);
	log.debug("<<리뷰 목록 - rowCount>> : "+rowCount);
	
	Map<String,Object> map = new HashMap<String, Object>();
	map.put("m_code",m_code);
	
	//총글의 개수
	int count = movieService.selectMovieRowCountReview(map);
	
	//페이지 처리
	PagingUtil page = new PagingUtil(pageNum, count, rowCount); //start row_num과 end row_num 번호를 알아서 연산해줌
	map.put("start",page.getStartRow());
	map.put("end",page.getEndRow());
	
	MemberVO user = (MemberVO)session.getAttribute("user");
	if(user!=null) {
		map.put("mem_num",user.getMem_num());
	}else {
		map.put("mem_num",0);
	}
	
	List<MovieReviewVO> list = null;
	
	if(count > 0) {
		list = movieService.selectMovieListReview(map);
	}else {
		list = Collections.emptyList(); //null보단 비어있는 리스트로 인식하게 한다.
	}
	
	Map<String,Object> mapJson = new HashMap<String, Object>();
	mapJson.put("count",count);
	mapJson.put("list",list);
	if(user!=null) {
		mapJson.put("user_num",user.getMem_num());
	}
	
	return mapJson;
}
}
