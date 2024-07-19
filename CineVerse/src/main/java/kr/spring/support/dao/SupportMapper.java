package kr.spring.support.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.shop.vo.OrdersVO;
import kr.spring.support.vo.ConsultVO;


@Mapper
public interface SupportMapper {
	
	public List<ConsultVO> selectConsultList(Map<String,Object> map); 
	public Integer selectConsultRowCount(Map<String,Object> map);
	
	public void insertConsult(ConsultVO consult);
	@Select("SELECT * FROM orders WHERE mem_num=#{mem_num}")
	public List<OrdersVO> selectOdNumbersByMemNum(long mem_num);
/*	@Select("SELECT * FROM consult JOIN member USING(mem_num) LEFT OUTER JOIN member_detail USING(mem_num) WHERE consult_num=#{consult_num}")
	public ConsultVO selectConsult(Long consult_num);
	
	
	@Delete("DELETE FROM consult WHERE consult_num=#{consult_num}")
	public void deleteConsult(Long consult_num);*/
}
