package kr.spring.movie.controller;

import java.util.HashMap;
import java.util.List;
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

    @PostMapping("/movie/movieDetail/addReview")
    @ResponseBody
    public Map<String, String> addReview(MovieReviewVO movieReviewVO,
                                          HttpSession session,
                                          HttpServletRequest request) {
        log.debug("<<리뷰 등록>> :" + movieReviewVO);

        Map<String, String> mapJson = new HashMap<String, String>();

        MemberVO user = (MemberVO) session.getAttribute("user");
        if (user == null) {
            mapJson.put("result", "logout");
        } else {
            movieReviewVO.setMem_num(user.getMem_num());

            boolean hasBooked = movieService.hasBookedMovie(user.getMem_num(), movieReviewVO.getM_code());
            if (!hasBooked) {
                mapJson.put("result", "notBooked");
            } else {
                movieService.addMovieReview(movieReviewVO);
                mapJson.put("result", "success");
            }
        }

        return mapJson;
    }

    @PostMapping("/movie/movieDetail/getReviews")
    @ResponseBody
    public Map<String, Object> getReviews(int page, Long m_code) {
        log.debug("<<리뷰 목록>> : page = " + page + ", m_code = " + m_code);

        Map<String, Object> mapJson = new HashMap<String, Object>();

        List<MovieReviewVO> reviews = movieService.getMovieReviews(page, m_code);
        mapJson.put("result", "success");
        mapJson.put("reviews", reviews);

        return mapJson;
    }
}
