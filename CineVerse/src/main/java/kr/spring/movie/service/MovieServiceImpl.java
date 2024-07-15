package kr.spring.movie.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.board.dao.BoardMapper;
import kr.spring.board.vo.BoardFavVO;
import kr.spring.movie.controller.MovieAjaxController;
import kr.spring.movie.dao.MovieMapper;
import kr.spring.movie.vo.MovieActorVO;
import kr.spring.movie.vo.MovieBookMarkVO;
import kr.spring.movie.vo.MovieBookingVO;
import kr.spring.movie.vo.MovieDirectorVO;
import kr.spring.movie.vo.MovieGenreVO;
import kr.spring.movie.vo.MovieReviewVO;
import kr.spring.movie.vo.MovieTimeVO;
import kr.spring.movie.vo.MovieVO;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Service
@Transactional
public class MovieServiceImpl implements MovieService {
	
	@Autowired
	MovieMapper movieMapper;
	
	@Override
	public List<MovieVO> selectMovieList(Map<String, Object> map) {

		return movieMapper.selectMovieList(map);
	}

	@Override
	public Integer selectMovieRowCount(Map<String, Object> map) {

		return movieMapper.selectMovieRowCount(map);
	}

	@Override
	public void insertMovie(MovieVO movie) {
		
		movie.setM_code(movieMapper.selectM_code()); 
		movieMapper.insertMovie(movie);
		// movie_actor 테이블에 데이터 삽입
	    MovieActorVO actor = new MovieActorVO();
	    actor.setM_code(movie.getM_code());
	    actor.setActor(movie.getActor());
	    movieMapper.insertMovieActor(actor);
	    
	    // movie_director 테이블에 데이터 삽입
	    MovieDirectorVO director = new MovieDirectorVO();
	    director.setM_code(movie.getM_code());
	    director.setDirector(movie.getDirector());
	    movieMapper.insertMovieDirector(director);
	    
	    // movie_genre 테이블에 데이터 삽입
	    MovieGenreVO genre = new MovieGenreVO();
	    genre.setM_code(movie.getM_code());
	    genre.setGenre(movie.getGenre());
	    movieMapper.insertMovieGenre(genre);
		
	}

	

	@Override
	public MovieVO selectMovie(long m_code) {
		
		return movieMapper.selectMovie(m_code);
	}

	@Override
	public void updateMovie(MovieVO movie) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteMovie(Long m_code) {

	
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

	@Override
	public List<MovieReviewVO> selectMovieListReview(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Integer selectMovieRowCountReview(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public MovieReviewVO selectReview(Long mr_num) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insertReview(MovieReviewVO movieReview) {
		movieMapper.insertReview(movieReview);
		
	}

	@Override
	public void updateReview(MovieReviewVO movieReview) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteReview(Long mr_num) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<MovieVO> selectMovieTimeList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insertMovieTime(MovieTimeVO movietime) {
		// TODO Auto-generated method stub
		
	}



    
    @Override
    @Transactional
    public void addMovieTime(MovieTimeVO movieTimeVO) {
        movieMapper.addMovieTime(movieTimeVO);
    }

	@Override
	public boolean canWriteReview(long mem_num, long m_code) {
		return movieMapper.hasBookedMovie(mem_num, m_code) > 0;
	}

	@Override
	public MovieBookingVO getBookingInfo(long mem_num, long m_code) {
		return movieMapper.getBookingInfo(mem_num, m_code);
	}
















	

	


	

	

}
