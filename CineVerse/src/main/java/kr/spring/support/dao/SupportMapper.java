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
import kr.spring.support.vo.UserFaqVO;
import kr.spring.support.vo.UserNoticeVO;


@Mapper
public interface SupportMapper {
	
	public List<ConsultVO> selectConsultList(Map<String,Object> map); 
	public Integer selectConsultRowCount(Map<String,Object> map);
	
	public void insertConsult(ConsultVO consult);
	
	@Select("SELECT * FROM orders WHERE mem_num=#{mem_num}")
	public List<OrdersVO> selectOdNumbersByMemNum(long mem_num);
	
	public ConsultVO selectConsult(long consult_num);
	
	/*	@Select("SELECT * FROM consult JOIN member USING(mem_num) LEFT OUTER JOIN member_detail USING(mem_num) WHERE consult_num=#{consult_num}")
	public ConsultVO selectConsult(Long consult_num);
	
	
	@Delete("DELETE FROM consult WHERE consult_num=#{consult_num}")
	public void deleteConsult(Long consult_num);*/
	
	
	
	public List<UserNoticeVO> selectNoticeList(Map<String,Object> map);
	public Integer selectNoticeRowCount(Map<String,Object> map);
	@Select("SELECT * FROM notice_board WHERE nb_num=#{nb_num}")
	public UserNoticeVO selectNotice(Long nb_num);
	@Update("UPDATE notice_board SET nb_hit=nb_hit+1 WHERE nb_num=#{nb_num}")
	public void updateHit(Long nb_num);
	
	public List<UserFaqVO> selectFaqList(Map<String,Object> map);
	public Integer selectFaqRowCount(Map<String,Object> map);
	@Select("SELECT * FROM faq WHERE f_num=#{f_num}")
	public UserFaqVO selectFaq(Long f_num);
	@Update("UPDATE faq SET f_hit=f_hit+1 WHERE f_num=#{f_num}")
	public void updateFaqHit(Long nb_num);
	
	// 메인에서 띄울 가장 최신 글
	@Select("SELECT * FROM notice_board WHERE  nb_reg_date = (SELECT MAX(nb_reg_date) FROM notice_board)")
	public UserNoticeVO getNotice();
	
}