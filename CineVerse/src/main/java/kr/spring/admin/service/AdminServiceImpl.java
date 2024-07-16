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
import kr.spring.cinema.vo.CinemaVO;
import kr.spring.cinema.vo.TheaterVO;
import kr.spring.member.vo.PointVO;
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
	public void insertEvent(EventVO eventVO) {
		adminMapper.insertEvent(eventVO);
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
	public Integer selectMovieRowCount(Map<String, Object> map) {
		return adminMapper.selectMovieRowCount(map);
	}
	@Override
	public void deleteMovie(long m_code) {
		adminMapper.deleteMovie(m_code);
	}
	@Override
	public Integer totalMember() {
		return adminMapper.totalMember();
	}
	@Override
	public Integer totalCommunity() {
		return adminMapper.totalCommunity();
	}
	@Override
	public Integer totalAssignment() {
		return adminMapper.totalAssignment();
	}
	@Override
	public Integer totalProduct() {
		return adminMapper.totalProduct();
	}
	@Override
	public Integer totalMovie() {
		return adminMapper.totalMovie();
	}
	@Override
	public Integer totalCinema() {
		return adminMapper.totalCinema();
	}
	@Override
	public List<AdminVO> selectMemberList(Map<String, Object> map) {
		return adminMapper.selectMemberList(map);
	}
	@Override
	public Integer selectMemberRowCount(Map<String, Object> map) {
		return adminMapper.selectMemberRowCount(map);
	}
	@Override
	public List<AdminVO> selectMembershipList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return adminMapper.selectMembershipList(map);
	}
	@Override
	public Integer selectMembershipRowCount(Map<String, Object> map) {
		return adminMapper.selectMemberRowCount(map);
	}
	@Override
	public List<EventVO> selectEventList(Map<String, Object> map) {
		return adminMapper.selectEventList(map);
	}
	@Override
	public Integer selectEventRowCount(Map<String, Object> map) {
		return adminMapper.selectEventRowCount(map);
	}
	@Override
	public List<NoticeVO> selectNoticeList(Map<String, Object> map) {
		return adminMapper.selectNoticeList(map);
	}
	@Override
	public Integer selectNoticeRowCount(Map<String, Object> map) {
		return adminMapper.selectNoticeRowCount(map);
	}
	@Override
	public List<PointVO> selectPoint(Map<String, Object> map) {
		return adminMapper.selectPoint(map);
	}
	@Override
	public Integer selectPointRowCount(Map<String, Object> map) {
		return adminMapper.selectPointRowCount(map);
	}
	@Override
    @Transactional
    public void insertCinema(CinemaVO cinemaVO) {
        adminMapper.insertCinema(cinemaVO);
    }
	@Override
	public void insertTheater(TheaterVO theaterVO) {
		adminMapper.insertTheater(theaterVO);
	}

	
}
