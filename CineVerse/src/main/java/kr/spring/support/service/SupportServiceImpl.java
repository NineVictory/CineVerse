package kr.spring.support.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.shop.vo.OrdersVO;
import kr.spring.support.dao.SupportMapper;
import kr.spring.support.vo.ConsultVO;
import kr.spring.support.vo.UserNoticeVO;

@Service
@Transactional
public class SupportServiceImpl implements SupportService{

	@Autowired
	SupportMapper supportMapper;

	@Override
	public List<ConsultVO> selectConsultList(Map<String, Object> map) {
		return supportMapper.selectConsultList(map);
	}

	@Override
	public Integer selectConsultRowCount(Map<String, Object> map) {
		return supportMapper.selectConsultRowCount(map);
	}
	
	@Override
	public void insertConsult(ConsultVO consult) {
		supportMapper.insertConsult(consult);
	}

	@Override
	public List<OrdersVO> selectOdNumbersByMemNum(long mem_num) {
		return supportMapper.selectOdNumbersByMemNum(mem_num);
	}

	@Override
	public ConsultVO selectConsult(long consult_num) {
		return supportMapper.selectConsult(consult_num);
	}

	@Override
	public List<UserNoticeVO> selectNoticeList(Map<String, Object> map) {
		return supportMapper.selectNoticeList(map);
	}

	@Override
	public Integer selectNoticeRowCount(Map<String, Object> map) {
		return supportMapper.selectNoticeRowCount(map);
	}

	@Override
	public UserNoticeVO selectNotice(Long nb_num) {
		return supportMapper.selectNotice(nb_num);
	}

	@Override
	public void updateHit(Long nb_num) {
		supportMapper.updateHit(nb_num);
	}

	
	
	

}
