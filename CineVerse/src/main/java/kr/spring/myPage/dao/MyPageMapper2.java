package kr.spring.myPage.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.myPage.vo.AddressVO;

@Mapper
public interface MyPageMapper2 {
	@Insert("INSERT INTO address(a_num, a_name, a_zipcode, a_address1, a_address2, a_default, a_phone, mem_num) VALUES (address_seq.nextval, #{a_name}, #{a_zipcode}, #{a_address1}, #{a_address2},#{a_default}, #{a_phone}, #{mem_num})")
	public void addAddress(AddressVO address);
	
	@Select("SELECT COUNT(*) FROM address WHERE mem_num=#{mem_num} AND a_status=1")
	public Integer countAddress(Long mem_num);
	
	@Select("SELECT * FROM address WHERE mem_num=#{mem_num} AND a_status=1")
	public List<AddressVO> addressList(Long mem_num); 
	
	@Delete("DELETE FROM address WHERE a_num=#{a_num}")
	public void deleteAddress(Long a_num);
	
	@Select("SELECT * FROM orders WHERE a_num=#{a_num}")
	public AddressVO selectOrder(Long mem_num);
	@Update("UPDATE address SET a_status=2 WHERE a_num=#{a_num}")
	public void updateAddressStatus(Long a_num);
	
}
