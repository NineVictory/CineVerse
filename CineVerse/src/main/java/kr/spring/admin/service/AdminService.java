package kr.spring.admin.service;

import java.util.List;

import kr.spring.admin.vo.AdminVO;

public interface AdminService {
	public List<AdminVO> getAllMembers();
	public void updateAuth(long mem_num, long mem_auth);

}
