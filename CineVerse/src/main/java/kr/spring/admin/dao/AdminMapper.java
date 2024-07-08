package kr.spring.admin.dao;

import org.apache.ibatis.annotations.Mapper;

import kr.spring.admin.vo.AdminVO;

@Mapper
public interface AdminMapper {
	//회원관리
	public void modifyAuth(AdminVO admin);
	//구독맴버십
	//공지사항
	
	//이벤트
	
	//결제
}
