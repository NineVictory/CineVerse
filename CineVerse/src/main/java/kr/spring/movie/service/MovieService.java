package kr.spring.movie.service;

import java.util.List;
import java.util.Map;

import kr.spring.board.vo.BoardFavVO;
import kr.spring.movie.vo.MovieBookMarkVO;
import kr.spring.movie.vo.MovieVO;

public interface MovieService {
	//영화목록리스트
		public List<MovieVO> selectMovieList(Map<String,Object>map);
		public Integer selectMovieRowCount(Map<String,Object> map);
		public void insertMovie(MovieVO movie);
		public MovieVO selectMovie(Long m_code);
		public void updateMovie(MovieVO movie);
		public void deleteMovie(Long m_code);
		
		//영화 북마크
		public MovieBookMarkVO selectBookMark(MovieBookMarkVO bookMark);
		public Integer selectBookMarkCount(Long m_code);
		public void insertBookMark(MovieBookMarkVO bookMark);
		public void deleteBookMark(BoardFavVO bookMark);
		
}
