package kr.spring.admin.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.admin.dao.AdminMapper;
import kr.spring.admin.vo.AdminVO;
import kr.spring.admin.vo.EventVO;
import kr.spring.admin.vo.NoticeVO;
import kr.spring.assignment.vo.AssignVO;
import kr.spring.board.vo.BoardVO;
import kr.spring.movie.vo.MovieVO;
@Service
@Transactional
public class AdminServiceImpl implements AdminService{
	@Autowired
	AdminMapper adminMapper;

	@Override
	public void updateMemberAuth(long mem_num) {
		adminMapper.updateMemberAuth(mem_num);
	}
	@Override
	public List<AdminVO> getAllMembers() {
		return adminMapper.getAllMembers();
	}
	@Override
	public List<AdminVO> getAllMembership() {
		return adminMapper.getAllMembership();
	}
	@Override
	public List<EventVO> getAllEvent() {
		return adminMapper.getAllEvent();
	} 
	@Override
	public void insertEvent(EventVO eventVO) {
		adminMapper.insertEvent(eventVO);
	}
	@Override
	public List<NoticeVO> getAllNotice() {
		return adminMapper.getAllNotice();
	}
	@Override
	public void insertNotice(NoticeVO noticeVO) {
		adminMapper.insertNotice(noticeVO);
	}
	@Override
	public List<BoardVO> getAllCommunity() {
		return adminMapper.getAllCommutnity();
	}
	@Override
	public List<AssignVO> getAllAssignment() {
		return adminMapper.getAllAssignment();
	}
	@Override
	public void deleteMemberAuth(long mem_num) {
		adminMapper.deleteMemberAuth(mem_num);
	}
	@Override
	public void deleteEvent(long event_num) {
		adminMapper.deleteEvent(event_num);
	}
	@Override
	public void deleteNotice(long nb_num) {
		adminMapper.deleteNotice(nb_num);
	}
	@Override
	public List<MovieVO> selectMovie(Map<String, Object> map) {
		return adminMapper.selectMovie(map);
	}
	@Override
	public Integer selectRowCount(Map<String, Object> map) {
		return adminMapper.selectRowCount(map);
	}
	@Override
	@Transactional
	public void deleteMovie(long m_code) {
		adminMapper.deleteMovieActor(m_code);
		adminMapper.deleteMovieBooking(m_code);
		adminMapper.deleteMovieBookmark(m_code);
		adminMapper.deleteMovieReview(m_code);
		adminMapper.deleteMovietime(m_code);
		adminMapper.deleteMovieDirector(m_code);
		adminMapper.deleteMovieGenre(m_code);
		adminMapper.deleteMovie(m_code);
	}


}
