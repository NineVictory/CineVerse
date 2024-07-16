package kr.spring.movie.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.spring.movie.vo.MovieRankAPIVO;

@Mapper
public interface MovieRankMapper {
	// 영화 랭크 삽입하기
	void insertMovieRank(MovieRankAPIVO movieRankAPI);
	// 영화 랭크 리스트 가져오기
	List<MovieRankAPIVO> getMovieRank();
}
