package kr.spring.movie.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.spring.movie.service.MovieDetailService;
import kr.spring.movie.service.MovieRankService;
import kr.spring.movie.vo.MovieDetailKFAPIVO;
import kr.spring.movie.vo.MovieRankAPIVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
public class MovieAPIController {
    @Autowired
    private MovieRankService movieRankService;
    
    @Autowired
    private MovieDetailService movieDetailService;

    // 매일 새벽 2시마다 자동 업데이트 되도록 설정해놨는데 업데이트가 안 되었다면 링크로 들어가면 업데이트 가능함
    @GetMapping("/movie/updateMovieRank")
    public String updateMovieRank() {
        log.debug("<< 영화 랭크 업데이트 >>");
        movieRankService.updateMovieRank();
        return "영화 랭크가 업데이트되었습니다.";
    }
    
    @GetMapping("/movie/insertMovieDetail")
    public String insertMovieDetail(MovieDetailKFAPIVO movieDetailKFAPIVO) {
        log.debug("<< 영화 세부 정보 업데이트 >>");
        movieDetailService.insertMovieDetail(movieDetailKFAPIVO);
        return "영화 세부 정보 업데이트되었습니다.";
    }

}
