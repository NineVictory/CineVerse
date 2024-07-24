package kr.spring.support.service;

import java.util.List;
import java.util.Map;

import kr.spring.shop.vo.OrdersVO;
import kr.spring.support.vo.ConsultVO;
import kr.spring.support.vo.UserFaqVO;
import kr.spring.support.vo.UserNoticeVO;

public interface SupportService {

	public List<ConsultVO> selectConsultList(Map<String,Object> map); 
	public Integer selectConsultRowCount(Map<String,Object> map);

	public void insertConsult(ConsultVO consult);
	public List<OrdersVO> selectOdNumbersByMemNum(long mem_num);
	
	public ConsultVO selectConsult(long consult_num);
	/*
	 * public ConsultVO selectConsult(Long consult_num); public void
	 * deleteConsult(Long consult_num);
	 */
	
	
	public List<UserNoticeVO> selectNoticeList(Map<String,Object> map);
	public Integer selectNoticeRowCount(Map<String,Object> map);
	public UserNoticeVO selectNotice(Long nb_num);
	public void updateHit(Long nb_num);

	public List<UserFaqVO> selectFaqList(Map<String,Object> map);
	public Integer selectFaqRowCount(Map<String,Object> map);
	public UserFaqVO selectFaq(Long f_num);
	public void updateFaqHit(Long nb_num); 
}
