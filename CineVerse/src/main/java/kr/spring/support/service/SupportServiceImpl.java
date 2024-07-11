package kr.spring.support.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.support.dao.SupportMapper;
import kr.spring.support.vo.ConsultVO;

@Service
@Transactional
public class SupportServiceImpl implements SupportService{

	@Autowired
	SupportMapper supportMapper;
	
	@Override
	public List<ConsultVO> selectConsultList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Integer selectRowCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insertConsult(ConsultVO consult) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public ConsultVO selectConsult(Long consult_num) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deleteConsult(Long consult_num) {
		// TODO Auto-generated method stub
		
	}

}
