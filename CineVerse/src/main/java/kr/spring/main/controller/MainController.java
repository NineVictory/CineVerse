package kr.spring.main.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import kr.spring.cinema.service.CinemaService;
import kr.spring.movie.service.MovieDetailService;
import kr.spring.movie.service.MovieRankService;
import kr.spring.movie.vo.MovieRankAPIVO;
import kr.spring.movie.vo.MovieVO;
import kr.spring.support.service.SupportService;
import kr.spring.support.vo.UserNoticeVO;

@Controller
public class MainController {
	
	@Autowired
    private CinemaService cinemaService;
	
	@Autowired
    private SupportService supportService;

	@GetMapping("/")
	public String init() {
		return "redirect:/main/main";
	}
	
	@GetMapping("/main/main")
	public String main(Model model) {
		
		 getMovieRanks(model); 
		getNotice(model);
		
		return "main";//Tiles의 설정명
	}

	public void getMovieRanks(Model model) {
		/*
		 * SimpleDateFormat DATE_FMT = new SimpleDateFormat("yyyyMMdd"); Calendar cal =
		 * Calendar.getInstance(); cal.setTime(new Date()); cal.add(Calendar.DATE, -1);
		 * 
		 * String showrange = DATE_FMT.format(cal.getTime()) + "~" +
		 * DATE_FMT.format(cal.getTime());
		 * 
		 * Integer count = movieRankService.getMovieRankCnt(showrange);
		 * List<MovieRankAPIVO> movieRankList =
		 * movieRankService.getMovieRank(showrange);
		 */
		List<MovieVO> movieRank = cinemaService.getMovieRankMain();
		model.addAttribute("movieRank",movieRank);
	}
	
	public void getNotice(Model model) {
		
		UserNoticeVO notice = supportService.getNotice();
		
		model.addAttribute("notice",notice);
	}
}








