package kr.spring.admin.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;

import kr.spring.admin.vo.AdminVO;
import kr.spring.admin.vo.EventVO;
import kr.spring.admin.vo.NoticeVO;
import kr.spring.assignment.vo.AssignVO;
import kr.spring.board.vo.BoardVO;
import kr.spring.movie.vo.MovieVO;

public interface AdminService {

	public List<AdminVO> getAllMembers();
	public void updateMemberAuth(long mem_num);
	public void deleteMemberAuth(long mem_num);
	public List<AdminVO> getAllMembership();
	public List<EventVO> getAllEvent();
	public void insertEvent(EventVO eventVO);
	public void deleteEvent(long event_num);
	public List<NoticeVO> getAllNotice();
	public void insertNotice(NoticeVO noticeVO);
	public void deleteNotice(long nb_num);
	public List<BoardVO> getAllCommunity();
	public List<AssignVO> getAllAssignment();
	public List<MovieVO> selectMovie(Map<String,Object> map);
	public Integer selectRowCount(Map<String,Object> map);
	public void deleteMovie(long m_code);
}	
