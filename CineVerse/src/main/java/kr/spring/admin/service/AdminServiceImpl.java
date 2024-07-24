package kr.spring.admin.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.admin.dao.AdminMapper;
import kr.spring.admin.vo.AdminVO;
import kr.spring.admin.vo.EventVO;
import kr.spring.admin.vo.FaqVO;
import kr.spring.admin.vo.NoticeVO;
import kr.spring.admin.vo.ReplyVO;
import kr.spring.assignment.vo.AssignVO;
import kr.spring.board.vo.BoardCommentVO;
import kr.spring.board.vo.BoardVO;
import kr.spring.cinema.vo.CinemaVO;
import kr.spring.cinema.vo.TheaterVO;
import kr.spring.member.dao.MemberMapper;
import kr.spring.member.vo.PointVO;
import kr.spring.movie.vo.MovieVO;
import kr.spring.support.vo.ConsultVO;
import lombok.extern.slf4j.Slf4j;
@Service
@Transactional
@Slf4j
public class AdminServiceImpl implements AdminService{
	@Autowired
	AdminMapper adminMapper;
	@Autowired
	MemberMapper memberMapper;
 
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
	public void insertCinema(CinemaVO cinemaVO) {
		// 상영관 정보 저장
		cinemaVO.setC_num(adminMapper.selectC_num());
		adminMapper.insertCinema(cinemaVO);
		// 상영관 정보 저장
		List<TheaterVO> theaterList = cinemaVO.getTheaterList();
		if (theaterList != null && !theaterList.isEmpty()) {
			for (TheaterVO theater : theaterList) {
				theater.setC_num(cinemaVO.getC_num());
				adminMapper.insertTheater(theater); // theater 객체를 사용하여 상영관 정보 저장
			}
		}    
	}
	@Override
	public List<TheaterVO> selectTheater(int c_num) {
		return adminMapper.selectTheater(c_num);
	}
	@Override
	public List<CinemaVO> selectCinema(Map<String, Object> map) {
		return adminMapper.selectCinema(map);
	}
	@Override
	public Integer selectCinemaRowCount(Map<String, Object> map) {
		return adminMapper.selectCinemaRowCount(map);
	}
	@Override
	public void deleteCinema(long c_num) {
		adminMapper.deleteCinema(c_num);
	}
	@Override
	@Transactional
	public void refundPoint(long ph_num, long mem_num, long ph_point, String ph_payment) {
		adminMapper.refundPoint(ph_num, mem_num,ph_point,ph_payment);
		adminMapper.updatePoint(ph_num);
		memberMapper.totalPoint(mem_num);
	}
	@Override
	public List<BoardVO> selectCommunityList(Map<String, Object> map) {
		return adminMapper.selectCommunityList(map);
	}
	@Override
	public Integer selectCommunityRowCount(Map<String, Object> map) {
		return adminMapper.selectCommunityRowCount(map);
	}
	@Override
	public List<AssignVO> selectAssginList(Map<String, Object> map) {
		return adminMapper.selectAssignList(map);
	}
	@Override
	public Integer selectAssignRowCount(Map<String, Object> map) {
		return adminMapper.selectAssignRowCount(map);
	}
	@Override 
	public List<ReplyVO> selectReplyList(Map<String, Object> map) {
		return adminMapper.selectReplyList(map); 
	}
	@Override
	public Integer selectReplyRowCount(Map<String, Object> map) {
		return adminMapper.selectReplyRowCount(map);
	}
	@Override
	@Transactional
	public void refundMembership(long mem_num, String point_payment) {
		adminMapper.refundMembership(mem_num, point_payment);
		adminMapper.deleteMembership(mem_num);
		adminMapper.updateMembership(mem_num);
		adminMapper.deleteCoupon(mem_num);
		memberMapper.totalPoint(mem_num);
	}
	@Override
	public List<ReplyVO> selectReCmtList(Map<String, Object> map) {
		return adminMapper.selectReCmtList(map);
	}
	@Override
	public Integer selectReCmtRowCount(Map<String, Object> map) {
		return adminMapper.selectReCmtRowCount(map);
	}
	@Override
	public void deleteReply(long cc_num) {
		adminMapper.deleteReply(cc_num);
	}
	@Override
	public void deleteCmt(long cc_num) {
		adminMapper.deleteCmt(cc_num);
	}
	@Override
	public List<ConsultVO> selectConsultList(Map<String, Object> map) {
		return adminMapper.selectConsultList(map);
	}
	@Override
	public Integer selectConsultRowCount(Map<String, Object> map) {
		return adminMapper.selectConsultRowCount(map);
	}
	@Override
	public void updateAnswer(ConsultVO consultVO) {
		adminMapper.updateAnswer(consultVO);
	}

	@Override
	public void insertFaq(FaqVO FaqVO) {
		adminMapper.insertFaq(FaqVO);
	}
	@Override
	public List<FaqVO> selectFaqList(Map<String, Object> map) {
		return adminMapper.selectFaqList(map);
	}
	@Override
	public Integer selectFaqRowCount(Map<String, Object> map) {
		return adminMapper.selectFaqRowCount(map);
	}
	@Override
	public void deleteFaq(long f_num) {
		adminMapper.deleteFaq(f_num);
	}
	@Override
	public ConsultVO selectConsult(long consult_num) {
		return adminMapper.selectConsult(consult_num);
	}

}
