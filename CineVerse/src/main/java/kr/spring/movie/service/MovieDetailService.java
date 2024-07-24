package kr.spring.movie.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.spring.movie.vo.MovieDetailKFAPIVO;
import kr.spring.movie.vo.MovieVO;

public interface MovieDetailService {
	public void insertMovieDetail(MovieDetailKFAPIVO movieDetail);
	public List<MovieVO> selectRankMovie(@Param("showrange") String showrange);
}
