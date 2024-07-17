package kr.spring.movie.dao;

import org.apache.ibatis.annotations.Mapper;

import kr.spring.movie.vo.MovieDetailKFAPIVO;

@Mapper
public interface MovieDetailMapper {
	public void insertMovieDetail(MovieDetailKFAPIVO movieDetail);
}
