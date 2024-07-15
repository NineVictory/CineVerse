package kr.spring.myPage.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.myPage.dao.MyPageMapper;
import kr.spring.myPage.dao.MyPageMapper2;
import kr.spring.myPage.vo.AddressVO;

@Service
@Transactional
public class MyPageServiceImpl2 implements MyPageService2{
	@Autowired
	MyPageMapper2 myPageMapper;

	@Override
	public void addAddress(AddressVO address) {
		myPageMapper.addAddress(address);
	}

	@Override
	public Integer countAddress(Long mem_num) {
		return myPageMapper.countAddress(mem_num);
	}

	@Override
	public List<AddressVO> addressList(long mem_num) {
		return myPageMapper.addressList(mem_num);
	}

	@Override
	public void deleteAddress(Long a_num) {
		myPageMapper.deleteAddress(a_num);
	}

	@Override
	public AddressVO selectOrder(long mem_num) {
		return myPageMapper.selectOrder(mem_num);
	}

	@Override
	public void updateAddressStatus(Long a_num) {
		myPageMapper.updateAddressStatus(a_num);
	}

}
