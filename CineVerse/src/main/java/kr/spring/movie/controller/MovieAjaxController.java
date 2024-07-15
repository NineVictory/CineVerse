package kr.spring.movie.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.member.vo.MemberVO;
import kr.spring.movie.service.MovieService;
import kr.spring.movie.vo.MovieBookingVO;
import kr.spring.movie.vo.MovieReviewVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MovieAjaxController {

    @Autowired
    private MovieService movieService;

    @PostMapping("/movie/writeReview")
    @ResponseBody
    public String writeReview(@ModelAttribute MovieReviewVO review, HttpSession session) {
        MemberVO user = (MemberVO) session.getAttribute("user");
        long userMemNum = user != null ? user.getMem_num() : -1L;
        
		/*
		 * // mb_num이 없는 경우에 대한 기본값 설정 if (review.getMb_num() == 0) { return "fail"; //
		 * 적절한 처리로 변경 가능 }
		 */
        
        boolean canWriteReview = movieService.canWriteReview(userMemNum, review.getM_code());
        
        if (canWriteReview) {
            review.setMem_num(userMemNum);
         // mb_num 값 설정
            MovieBookingVO bookingInfo = movieService.getBookingInfo(userMemNum, review.getM_code());
            if (bookingInfo != null) {
                review.setMb_num(bookingInfo.getMb_num());
            }
            log.debug("리뷰 등록: " + review);
            movieService.insertReview(review);
            return "success";
        } else {
            return "fail";
        }
    }
}
