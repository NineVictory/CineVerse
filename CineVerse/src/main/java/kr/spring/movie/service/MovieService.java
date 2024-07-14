package kr.spring.movie.service;

import java.util.List;
import java.util.Map;

import kr.spring.board.vo.BoardFavVO;
import kr.spring.movie.vo.MovieActorVO;
import kr.spring.movie.vo.MovieBookMarkVO;
import kr.spring.movie.vo.MovieDirectorVO;
import kr.spring.movie.vo.MovieGenreVO;
import kr.spring.movie.vo.MovieReviewVO;
import kr.spring.movie.vo.MovieTimeVO;
import kr.spring.movie.vo.MovieVO;

public interface MovieService {
	//영화목록리스트
		public List<MovieVO> selectMovieList(Map<String,Object>map);
		public Integer selectMovieRowCount(Map<String,Object> map);
		public void insertMovie(MovieVO movie);
		
		public MovieVO selectMovie(long m_code);
		public void updateMovie(MovieVO movie);
		public void deleteMovie(Long m_code);
		//영화 북마크
		public MovieBookMarkVO selectBookMark(MovieBookMarkVO bookMark);
		public Integer selectBookMarkCount(Long m_code);
		public void insertBookMark(MovieBookMarkVO bookMark);
		public void deleteBookMark(BoardFavVO bookMark);
		
		//영화 예매
		//영화예매
		public List<MovieVO> selectMovieTimeList(Map<String,Object>map);
		public void insertMovieTime(MovieTimeVO movietime);
		
		//영화 리뷰
		public List<MovieReviewVO> selectMovieListReview(Map<String,Object> map);
		public Integer selectMovieRowCountReview(Map<String,Object>map); //mybatis는 객체형태로 처리하기 때문에 int보다 Integer로 명시한다. int를 써도 자동으로 바뀌긴함. 그냥 명시를 맞게 해주는게 좋아서 
		public MovieReviewVO selectReview(Long mr_num);
		public void insertReview(MovieReviewVO movieReview);
		public void updateReview(MovieReviewVO movieReview);
		public void deleteReview(Long mr_num);
		
	    boolean hasBookedMovie(Long mem_num, Long m_code);
	    void addMovieReview(MovieReviewVO review);
	    List<MovieReviewVO> getMovieReviews(int page, Long m_code);
	    Long getBookingDetailNum(Long mem_num, Long m_code); // 메서드 추가

}
