package kr.spring.support.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Select;

import kr.spring.support.vo.ConsultVO;

public interface SupportService {
	/*
	 * public List<ConsultVO> selectConsultList(Map<String,Object> map); public
	 * Integer selectRowCount(Map<String,Object> map);
	 */
	public void insertConsult(ConsultVO consult);
	
	/*
	 * public ConsultVO selectConsult(Long consult_num); public void
	 * deleteConsult(Long consult_num);
	 */
}
