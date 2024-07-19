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
	public void insertConsult(ConsultVO consult) {
		supportMapper.insertConsult(consult);
	}
	
	

}
