package kr.spring.cinema.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import kr.spring.cinema.service.CinemaService;
import kr.spring.cinema.service.CinemaService2;
import kr.spring.cinema.vo.cMovieVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


@Slf4j
@Controller
public class CinemaAjaxController {
	@Autowired
	private CinemaService2 cinemaService2;
	
	@GetMapping("/cinema/getMovieList")
	@ResponseBody
	public Map<String, Object> getMethodName(@RequestParam String mt_date, @RequestParam Long c_num) {
		log.debug("<<자체 영화관 - mt_date>> ::: " + mt_date);
		log.debug("<<자체 영화관 - c_num>> ::: " + c_num);
		Map<String, Object> mapJson = new HashMap<String, Object>();
		
		List<cMovieVO> movieTimeList = cinemaService2.movieTimeForCinema(c_num, mt_date);
		mapJson.put("moviewTimeList", movieTimeList);
		return mapJson;
	}
	
}
