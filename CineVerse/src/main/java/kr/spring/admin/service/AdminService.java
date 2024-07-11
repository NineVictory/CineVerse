package kr.spring.admin.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.spring.admin.vo.AdminVO;
import kr.spring.admin.vo.EventVO;

public interface AdminService {

	public List<AdminVO> getAllMembers();
	public void updateAuth(long mem_num, long mem_auth);
	public List<AdminVO> getAllMembership();
	public List<EventVO> getAllEvent();
	public void insertEvent(EventVO eventVO);
}
