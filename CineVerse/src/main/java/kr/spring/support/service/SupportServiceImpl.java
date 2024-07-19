package kr.spring.support.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.shop.vo.OrdersVO;
import kr.spring.support.dao.SupportMapper;
import kr.spring.support.vo.ConsultVO;

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

	
	
	

}
