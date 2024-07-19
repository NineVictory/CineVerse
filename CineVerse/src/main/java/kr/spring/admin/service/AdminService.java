package kr.spring.admin.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import kr.spring.admin.vo.AdminVO;
import kr.spring.admin.vo.EventVO;
import kr.spring.admin.vo.NoticeVO;
import kr.spring.admin.vo.ReplyVO;
import kr.spring.assignment.vo.AssignVO;
import kr.spring.board.vo.BoardVO;
import kr.spring.cinema.vo.CinemaVO;
import kr.spring.cinema.vo.TheaterVO;
import kr.spring.member.vo.PointVO;
import kr.spring.movie.vo.MovieVO;

public interface AdminService {
	public List<AdminVO> selectMemberList(Map<String,Object> map);
	public Integer selectMemberRowCount(Map<String,Object> map);
	public Integer totalMember();
	public void updateMemberAuth(long mem_num);
	public void deleteMemberAuth(long mem_num);
	public List<AdminVO> selectMembershipList(Map<String,Object> map);
	public Integer selectMembershipRowCount(Map<String,Object> map);
	public List<EventVO> selectEventList(Map<String,Object> map);
	public Integer selectEventRowCount(Map<String,Object> map);
	public void insertEvent(EventVO eventVO);
	public void deleteEvent(long event_num);
	public List<NoticeVO> selectNoticeList(Map<String,Object> map);
	public Integer selectNoticeRowCount(Map<String,Object> map);
	public void insertNotice(NoticeVO noticeVO);
	public void deleteNotice(long nb_num);
	public List<BoardVO> selectCommunityList(Map<String,Object> map);
	public Integer selectCommunityRowCount(Map<String,Object> map);
	public List<AssignVO> selectAssginList(Map<String,Object> map);
	public Integer selectAssignRowCount(Map<String,Object> map);
	public List<ReplyVO> selectReplyList(Map<String,Object> map);
	public Integer selectReplyRowCount(Map<String,Object> map);
	public List<MovieVO> selectMovie(Map<String,Object> map);
	public Integer selectMovieRowCount(Map<String,Object> map);
	public List<PointVO> selectPoint(Map<String,Object> map);
	public Integer selectPointRowCount(Map<String,Object> map);
	public void deleteMovie(long m_code);
	public Integer totalCommunity();
	public Integer totalAssignment();
	public Integer totalProduct();
	public Integer totalMovie();
	public Integer totalCinema();
	public void insertCinema(CinemaVO cinemaVO);
	public List<TheaterVO> selectTheater(int c_num);
	public List<CinemaVO> selectCinema(Map<String,Object> map);
	public Integer selectCinemaRowCount(Map<String,Object> map);
	public void deleteCinema(long c_num);
	public void refundPoint(long ph_num);
}	
