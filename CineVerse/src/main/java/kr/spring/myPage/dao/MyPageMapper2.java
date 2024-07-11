package kr.spring.myPage.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.myPage.vo.AddressVO;

@Mapper
public interface MyPageMapper2 {
	@Insert("INSERT INTO address(a_num, a_name, a_zipcode, a_address1, a_address2, a_default, a_phone, mem_num) VALUES (address_seq.nextval, #{a_name}, #{a_zipcode}, #{a_address1}, #{a_address2},#{a_default}, #{a_phone}, #{mem_num})")
	public void addAddress(AddressVO address);
	
	@Select("SELECT COUNT(*) FROM address WHERE mem_num=#{mem_num}")
	public Integer countAddress(Long mem_num);
	
	@Select("SELECT * FROM address WHERE mem_num=#{mem_num}")
	public List<AddressVO> addressList(Long mem_num); 
}
