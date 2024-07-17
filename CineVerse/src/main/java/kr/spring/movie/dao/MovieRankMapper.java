package kr.spring.movie.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.movie.vo.MovieRankAPIVO;

@Mapper
public interface MovieRankMapper {
	// 영화 랭크 삽입하기
	public void insertMovieRank(MovieRankAPIVO movieRankAPI);
	// 영화 랭크 리스트 가져오기
	@Select("SELECT * FROM movie_rank_api WHERE showrange=#{showrange}")
	public List<MovieRankAPIVO> getMovieRank(String showrange);
	// 영화 랭크 개수 가져오기
	@Select("SELECT COUNT(*) FROM movie_rank_api WHERE showrange=#{showrange}")
	public Integer getMovieRankCnt(String showrange);
	
}
