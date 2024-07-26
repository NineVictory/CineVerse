package kr.spring.movie.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.cinema.service.CinemaService;
import kr.spring.cinema.vo.CinemaVO;
import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.movie.service.MovieService;
import kr.spring.movie.service.MovieService2;
import kr.spring.movie.vo.MbDetailVO;
import kr.spring.movie.vo.MovieBookingVO;
import kr.spring.movie.vo.MovieTimeVO;
import kr.spring.movie.vo.MovieVO;
import kr.spring.myPage.service.MyPageService;
import kr.spring.myPage.vo.MyPageVO;
import kr.spring.seat.vo.SeatVO;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MovieController2 {

	@Autowired
	private MovieService movieService;

	@Autowired
	private CinemaService cinemaService;

	@Autowired
	private MyPageService mypageService;

	@Autowired
	private MemberService memberService;

	@Autowired
	private MovieService2 movieService2;

	private static final SimpleDateFormat TARGET_FORMAT = new SimpleDateFormat("yy/MM/dd");
	/*=======================
	 * 영화 상영시간표
	 *=======================*/
	@GetMapping("/movie/movieTimeBYmovie")
	public String movieTime(@RequestParam long m_code, HttpServletRequest request, Model model){

		List<MovieVO> movieList = cinemaService.showMovieList();
		
		MovieTimeVO movie = movieService2.selectData(m_code);
		
		if(movie==null) {
			model.addAttribute("message", "예매 가능한 시간표가 없습니다.");
			model.addAttribute("url", request.getContextPath() + "/movie/movieList");
			return "common/resultAlert";
		} else {
			model.addAttribute("mt_date", TARGET_FORMAT.format(movie.getMt_date()));
			model.addAttribute("c_location", movie.getC_location());
			model.addAttribute("m_code", m_code);
			model.addAttribute("movieList", movieList);
			return "movieTime2";

		}
	}



}