package kr.spring.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.admin.dao.AdminMapper;
import kr.spring.admin.vo.AdminVO;
@Service
@Transactional
public class AdminServiceImpl implements AdminService{
	@Autowired
	AdminMapper adminMapper;



	@Override
	public void updateAuth(long mem_num, long mem_auth) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<AdminVO> getAllMembers() {
		// TODO Auto-generated method stub
		return adminMapper.getAllMembers();
	}


	

}
