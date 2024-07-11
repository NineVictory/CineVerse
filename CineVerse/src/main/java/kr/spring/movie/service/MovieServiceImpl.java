package kr.spring.movie.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.board.vo.BoardFavVO;
import kr.spring.movie.dao.MovieMapper;
import kr.spring.movie.vo.MovieBookMarkVO;
import kr.spring.movie.vo.MovieVO;

@Service
@Transactional
public class MovieServiceImpl implements MovieService {
	
	@Autowired
	MovieMapper movieMapper;
	
	@Override
	public List<MovieVO> selectMovieList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Integer selectMovieRowCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insertMovie(MovieVO movie) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public MovieVO selectMovie(Long m_code) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateMovie(MovieVO movie) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteMovie(Long m_code) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public MovieBookMarkVO selectBookMark(MovieBookMarkVO bookMark) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Integer selectBookMarkCount(Long m_code) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insertBookMark(MovieBookMarkVO bookMark) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteBookMark(BoardFavVO bookMark) {
		// TODO Auto-generated method stub
		
	}

}
