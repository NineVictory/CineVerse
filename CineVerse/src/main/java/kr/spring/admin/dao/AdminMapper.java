package kr.spring.admin.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.admin.vo.AdminVO;
import kr.spring.admin.vo.EventVO;
import kr.spring.admin.vo.NoticeVO;
import kr.spring.assignment.vo.AssignVO;
import kr.spring.board.vo.BoardVO;
import kr.spring.cinema.vo.CinemaVO;
import kr.spring.cinema.vo.TheaterVO;
import kr.spring.member.vo.PointVO;
import kr.spring.movie.vo.MovieVO;

@Mapper
public interface AdminMapper {
	//메인페이지 통계
	@Select("SELECT COUNT(*) FROM member WHERE mem_auth = 2 OR mem_auth = 3")
	public Integer totalMember();
	@Select("SELECT COUNT(*) FROM community_board")
	public Integer totalCommunity();
	@Select("SELECT COUNT(*) FROM assignment_board")
	public Integer totalAssignment();
	@Select("SELECT COUNT(*) FROM product WHERE p_status = 2")
	public Integer totalProduct();
	@Select("SELECT COUNT(*) FROM movie WHERE m_status = 2 AND m_delete = 1")
	public Integer totalMovie();
	@Select("SELECT COUNT(*) FROM cinema")
	public Integer totalCinema();
	// 회원 관리

	public List<AdminVO> selectMemberList(Map<String,Object> map);
	public Integer selectMemberRowCount(Map<String,Object> map);
	@Update("UPDATE member SET mem_auth = 1 WHERE mem_num=#{mem_num}")
    public void updateMemberAuth(long mem_num);
    @Update("UPDATE member SET mem_auth = 2 WHERE mem_num=#{mem_num}")
    public void deleteMemberAuth(long mem_num);
    // 구독 맴버십
	public List<AdminVO> selectMembershipList(Map<String,Object> map);
	public Integer selectMembershipRowCount(Map<String,Object> map);
    // 공지사항
	public List<NoticeVO> selectNoticeList(Map<String,Object> map);
	public Integer selectNoticeRowCount(Map<String,Object> map);
    public void insertNotice(NoticeVO noticeVO);
    @Delete("DELETE FROM notice_board WHERE nb_num = #{nb_num}")
    public void deleteNotice(long nb_num);

    // 이벤트
	public List<EventVO> selectEventList(Map<String,Object> map);
	public Integer selectEventRowCount(Map<String,Object> map);
    public void insertEvent(EventVO eventVO);
    @Delete("DELETE FROM event WHERE event_num = #{event_num}")
	public void deleteEvent(long event_num);
	

	
    // 결제
    // 게시판
    @Select("SELECT cb_num, mem_num, cb_title, cb_type, cb_report, cb_hit, cb_reg_date"
    		+ "	FROM community_board"
    		+ " ORDER BY cb_reg_date DESC")
    public List<BoardVO> getAllCommutnity();
    
    @Select("SELECT ab_num, mem_num, ab_title, ab_type, ab_report, ab_hit, ab_reg_date"
    		+ "	FROM assignment_board"
    		+ "	ORDER BY ab_reg_date DESC")
    public List<AssignVO> getAllAssignment();
    
    // 영화
	public List<MovieVO> selectMovie(Map<String,Object> map);
	public Integer selectMovieRowCount(Map<String,Object> map);
	@Update("UPDATE movie SET m_delete = 2 WHERE m_code = #{m_code}")
	public void deleteMovie(long m_code);	
	
	// 영화관 등록
	@Select("SELECT cinema_num.nextval FROM dual")
	public Long selectC_num();
	public void insertCinema(CinemaVO cinemaVO);
	// 상영관 등록
	public void insertTheater(TheaterVO theaterVO);
	//결제
	public List<PointVO> selectPoint(Map<String,Object> map);
	public Integer selectPointRowCount(Map<String,Object> map);
	
	//영화,상영관 검색
	public List<TheaterVO> selectTheater(int c_num);
	
}
