package kr.spring.admin.service;

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
	public void modifyAuth(AdminVO admin) {
		// TODO Auto-generated method stub
		
	}

}
