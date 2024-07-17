package kr.spring.movie.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.spring.movie.service.MovieRankService;
import kr.spring.movie.vo.MovieRankAPIVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
public class MovieAPIController {
    @Autowired
    private MovieRankService movieRankService;

    // 매일 새벽 2시마다 자동 업데이트 되도록 설정해놨는데 업데이트가 안 되었다면 링크로 들어가면 업데이트 가능함
    @GetMapping("/movie/updateMovieRank")
    public String updateMovieRank() {
        log.debug("<< 영화 랭크 업데이트 >>");
        movieRankService.updateMovieRank();
        return "영화 랭크가 업데이트되었습니다.";
    }

	/*
	 * @GetMapping("/movie/movieRanks") public String getMovieRanks(MovieRankAPIVO
	 * movieRankAPIVO, Model model) { SimpleDateFormat DATE_FMT = new
	 * SimpleDateFormat("yyyyMMdd"); Calendar cal = Calendar.getInstance();
	 * cal.setTime(new Date()); cal.add(Calendar.DATE, -1);
	 * 
	 * String showrange =
	 * DATE_FMT.format(cal.getTime())+"~"+DATE_FMT.format(cal.getTime());
	 * 
	 * Integer count = movieRankService.getMovieRankCnt(showrange);
	 * List<MovieRankAPIVO> movieRankList =
	 * movieRankService.getMovieRank(showrange);
	 * 
	 * model.addAttribute("count", count); model.addAttribute("movieRankList",
	 * movieRankList);
	 * 
	 * return "main"; }
	 */
}
