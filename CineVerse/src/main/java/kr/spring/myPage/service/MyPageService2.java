package kr.spring.myPage.service;

import java.util.List;
import java.util.Map;

import kr.spring.board.vo.BoardVO;
import kr.spring.myPage.vo.AddressVO;
import kr.spring.myPage.vo.MyPageVO;

public interface MyPageService2 {
	public void addAddress(AddressVO address);
	public Integer countAddress(Long mem_num);
	public List<AddressVO> addressList(long mem_num);
	public void deleteAddress(Long a_num);
	public AddressVO selectOrder(long mem_num);
	public void updateAddressStatus(Long a_num);
}
