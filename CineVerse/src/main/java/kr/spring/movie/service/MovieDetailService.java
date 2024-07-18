package kr.spring.movie.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.spring.movie.vo.EMovieVO;
import kr.spring.movie.vo.MovieDetailKFAPIVO;

public interface MovieDetailService {
	public void insertMovieDetail(MovieDetailKFAPIVO movieDetail);
	public List<EMovieVO> selectRankMovie(@Param("showrange") String showrange);
}
