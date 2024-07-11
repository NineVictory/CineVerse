package kr.spring.myPage.service;

import java.util.List;
import java.util.Map;

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
	@Override
	public Integer selectMemberCoupon(long mem_num) {
		Integer coupon = myPageMapper.selectMemberCoupon(mem_num);
		return coupon != null ? coupon : 0;
	}
	@Override
	public List<MyPageVO> selectMemCouponList(Map<String, Object> map) {
		return myPageMapper.selectMemCouponList(map);
	}
	
	
}
