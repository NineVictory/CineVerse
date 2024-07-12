package kr.spring.movie.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.board.vo.BoardFavVO;
import kr.spring.movie.vo.MovieActorVO;
import kr.spring.movie.vo.MovieBookMarkVO;
import kr.spring.movie.vo.MovieDirectorVO;
import kr.spring.movie.vo.MovieGenreVO;
import kr.spring.movie.vo.MovieReviewVO;
import kr.spring.movie.vo.MovieTimeVO;
import kr.spring.movie.vo.MovieVO;

@Mapper
public interface MovieMapper {
	//영화
	//영화목록리스트
	
	public List<MovieVO> selectMovieList(Map<String,Object>map);
	public Integer selectMovieRowCount(Map<String,Object> map);
	@Select("SELECT movie_seq.nextval FROM dual")
	public Long selectM_code();
	public void insertMovie(MovieVO movie);
	public void insertMovieActor(MovieActorVO actor);
	public void insertMovieDirector(MovieDirectorVO director);
	public void insertMovieGenre(MovieGenreVO genre);
	
	@Select("SELECT * FROM movie JOIN movie_actor USING (m_code) JOIN movie_director USING (m_code) JOIN movie_genre USING (m_code) WHERE m_code=#{m_code}")
	public MovieVO selectMovie(Long m_code);
	public void updateMovie(MovieVO movie);
	public void deleteMovie(long m_code);
	/* public void deleteMovieFile(Long m_code); */ //영화 사진을 굳이 삭제 안할듯
	
	//영화 북마크
	public MovieBookMarkVO selectBookMark(MovieBookMarkVO bookMark);
	public Integer selectBookMarkCount(Long m_code);
	public void insertBookMark(MovieBookMarkVO bookMark);
	public void deleteBookMark(BoardFavVO bookMark);
	public void deleteBookMarkByMovieNum(Long m_code);
	
	//영화예매
	@Select("SELECT cinema_num.nextval FROM dual")
	public Long selectC_num();
	public List<MovieVO> selectMovieTimeList(Map<String,Object>map);
	public void insertMovieTime(MovieTimeVO movietime);
	//영화 리뷰
	public List<MovieReviewVO> selectMovieListReview(Map<String,Object> map);
	public Integer selectMovieRowCountReview(Map<String,Object>map); //mybatis는 객체형태로 처리하기 때문에 int보다 Integer로 명시한다. int를 써도 자동으로 바뀌긴함. 그냥 명시를 맞게 해주는게 좋아서 
	public MovieReviewVO selectReview(Long mr_num);
	public void insertReview(MovieReviewVO movieReview);
	public void updateReview(MovieReviewVO movieReview);
	public void deleteReview(Long mr_num);
	//부모글 삭제시 댓글이 존재하면 부모글 삭제전 리뷰 삭제
	public void deleteReplyByMovieNum(Long m_code);
}
