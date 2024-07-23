package kr.spring.cinema.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.spring.cinema.vo.cMovieVO;
import kr.spring.movie.vo.MovieVO;

public interface CinemaService2 {
	public List<cMovieVO> movieTimeForCinema(@Param(value="c_num") Long c_num, @Param(value="mt_date") String mt_date);
}
