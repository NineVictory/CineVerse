package kr.spring.movie.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import kr.spring.board.vo.BoardReFavVO;
import kr.spring.movie.vo.MbDetailVO;
import kr.spring.movie.vo.MovieActorVO;
import kr.spring.movie.vo.MovieBookMarkVO;
import kr.spring.movie.vo.MovieBookingVO;
import kr.spring.movie.vo.MovieDirectorVO;
import kr.spring.movie.vo.MovieGenreVO;
import kr.spring.movie.vo.MovieReviewVO;
import kr.spring.movie.vo.MovieReviewfavVO;
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
	
	@Select("SELECT * FROM movie JOIN movie_actor USING (m_code) JOIN movie_director USING (m_code) WHERE m_code=#{m_code}")
	public MovieVO selectMovie(Long m_code);
	public void updateMovie(MovieVO movie);
	public void deleteMovie(long m_code);
	/* public void deleteMovieFile(Long m_code); */ //영화 사진을 굳이 삭제 안할듯
	/*
	 * @Select("SELECT * FROM movie WHERE m_code LIKE '%' || #{query} || '%' OR m_name LIKE '%' || #{query} || '%'"
	 * ) public List<MovieVO> searchMovies(String query);
	 */
	//영화 북마크
	@Select("SELECT * FROM movie_bookmark WHERE m_code=#{m_code} AND mem_num=#{mem_num}")
	public MovieBookMarkVO selectBookMark(MovieBookMarkVO bookMark);
	@Select("SELECT COUNT(*) FROM movie_bookmark WHERE m_code=#{m_code}")
	public Integer selectBookMarkCount(Long m_code);
	@Insert("INSERT INTO movie_bookmark (m_code,mem_num) VALUES (#{m_code},#{mem_num})")
	public void insertBookMark(MovieBookMarkVO bookMark);
	@Delete("DELETE FROM movie_bookmark WHERE m_code=#{m_code} AND mem_num=#{mem_num}")
	public void deleteBookMark(MovieBookMarkVO bookMark);
	@Delete("DELETE FROM movie_bookmark WHERE m_code=#{m_code}")
	public void deleteBookMarkByMovieNum(Long m_code);
	
	//영화 시간 등록
	@Select("SELECT cinema_num.nextval FROM dual")
	public Long selectC_num();
	public List<MovieVO> selectMovieTimeList(Map<String,Object>map);
	public void insertMovieTime(MovieTimeVO movietime);
	
	public MovieTimeVO selectMovieTime(Long mt_num);
	//영화 리뷰
	public List<MovieReviewVO> selectMovieListReview(Map<String,Object> map);
	@Select("SELECT COUNT(*) FROM movie_review WHERE m_code =#{m_code}")
	public Integer selectMovieRowCountReview(Map<String,Object>map); //mybatis는 객체형태로 처리하기 때문에 int보다 Integer로 명시한다. int를 써도 자동으로 바뀌긴함. 그냥 명시를 맞게 해주는게 좋아서 
	//리뷰 수정,삭제시 작성자 회원번호를 구하기 위해 사용
		@Select("SELECT * FROM movie_review WHERE mr_num=#{mr_num}")
	public MovieReviewVO selectReview(Long mr_num);
	public void insertReview(MovieReviewVO movieReview);
	public void updateReview(MovieReviewVO movieReview);
	@Delete("DELETE FROM movie_review WHERE mr_num=#{mr_num}")
	public void deleteReview(Long mr_num);
	//부모글 삭제시 댓글이 존재하면 부모글 삭제전 댓글 삭제
	@Delete("DELETE FROM movie_review WHERE m_code=#{m_code}")
	public void deleteReviewByM_code(Long m_code);
	
	//리뷰 좋아요
	@Select("SELECT * FROM mr_fav WHERE mr_num=#{mr_num} AND mem_num=#{mem_num}")
	public MovieReviewfavVO selecReFav(MovieReviewfavVO fav);
	@Select("SELECT COUNT(*) FROM mr_fav WHERE mr_num=#{mr_num}")
	public Integer selectReFavCount(Long mr_num);
	@Insert("INSERT INTO mr_fav (mr_num,mem_num) VALUES (#{mr_num},#{mem_num})")
	public void insertReFav(MovieReviewfavVO fav);
	@Delete("DELETE FROM mr_fav WHERE mr_num=#{mr_num} AND mem_num=#{mem_num}")
	public void deleteReFav(MovieReviewfavVO fav);
	@Delete("DELETE FROM mr_fav WHERE mr_num = #{mr_num}")
	public void deleteReFavByMrnum(Long mr_num);
	@Delete("DELETE FROM mr_fav WHERE mr_num IN (SELECT mr_num FROM spboard_reply WHERE m_code=#{m_code})")
	public void deleteReFavByM_code(Long m_code); 		
		
		
		
		
		

    //영화 시간표 등록
    void addMovieTime(MovieTimeVO movieTimeVO);
    
    // 영화 예매 여부 확인
    @Select("SELECT COUNT(*) FROM movie_booking WHERE mem_num = #{mem_num} AND m_code = #{m_code}")
    int hasBookedMovie(@Param("mem_num") long mem_num, @Param("m_code") long m_code);
    MovieBookingVO getBookingInfo(@Param("mem_num") long mem_num, @Param("m_code") long m_code);
    
    //영화 예매
    @Insert("INSERT INTO movie_booking (mb_num, mb_date, mb_price, mem_num, mt_num, m_code) VALUES (movie_booking_seq.nextval, SYSDATE, #{mb_price}, #{mem_num}, #{mt_num},#{m_code})")
    void insertBooking(MovieBookingVO movieBooking);

    @Insert("INSERT INTO mb_detail (md_num, md_type, mb_num, seat_num) VALUES (mb_detail_seq.nextval, #{md_type}, #{mb_num}, #{seat_num})")
    void insertBookingDetail(MbDetailVO mbDetail);
}
