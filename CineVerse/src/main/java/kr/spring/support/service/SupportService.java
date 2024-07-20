package kr.spring.support.service;

import java.util.List;
import java.util.Map;

import kr.spring.shop.vo.OrdersVO;
import kr.spring.support.vo.ConsultVO;

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
}
