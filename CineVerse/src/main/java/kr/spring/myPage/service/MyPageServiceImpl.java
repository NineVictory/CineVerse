package kr.spring.myPage.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.myPage.dao.MyPageMapper;
import kr.spring.myPage.vo.MyPageVO;

@Service
@Transactional
public class MyPageServiceImpl implements MyPageService{

	@Autowired
	MyPageMapper myPageMapper;
	@Override
	public MyPageVO selectMember(long mem_num) {
		return myPageMapper.selectMember(mem_num);
		
	}
	@Override
	public Integer selectMemberPoint(long mem_num) {
		Integer point = myPageMapper.selectMemberPoint(mem_num);
        return point != null ? point : 0;
	}
	
	
}
