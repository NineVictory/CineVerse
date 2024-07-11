package kr.spring.movie.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.spring.board.vo.BoardFavVO;
import kr.spring.movie.vo.MovieBookMarkVO;
import kr.spring.movie.vo.MovieVO;

@Mapper
public interface MovieMapper {
	//영화
	//영화목록리스트
	public List<MovieVO> selectMovieList(Map<String,Object>map);
	public Integer selectMovieRowCount(Map<String,Object> map);
	public void insertMovie(MovieVO movie);
	public MovieVO selectMovie(Long m_code);
	public void updateMovie(MovieVO movie);
	public void deleteMovie(Long m_code);
	/* public void deleteMovieFile(Long m_code); */ //영화 사진을 굳이 삭제 안할듯
	
	//영화 북마크
	public MovieBookMarkVO selectBookMark(MovieBookMarkVO bookMark);
	public Integer selectBookMarkCount(Long m_code);
	public void insertBookMark(MovieBookMarkVO bookMark);
	public void deleteBookMark(BoardFavVO bookMark);
	public void deleteBookMarkByMovieNum(Long m_code);
	//영화관
	
	//영화예매
	
	//영화 리뷰
	
	//좌석 리뷰
}
