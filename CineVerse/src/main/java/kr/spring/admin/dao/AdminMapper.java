package kr.spring.admin.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.springframework.web.bind.annotation.GetMapping;

import kr.spring.admin.vo.AdminVO;

@Mapper
public interface AdminMapper {
    // 회원 관리
    @Select("SELECT m.mem_num, m.mem_id, m.mem_auth, m.mem_rank, m.mem_membership, "
            + "md.mem_name, md.mem_phone, md.mem_email, md.mem_reg_date "
            + "FROM member m "
            + "JOIN member_detail md ON m.mem_num = md.mem_num")
    public List<AdminVO> getAllMembers();

    public void updateAuth(long mem_num, long mem_auth);
    
    // 구독 맴버십

    // 공지사항

    // 이벤트

    // 결제

}
