package kr.spring.admin.vo;

import java.sql.Clob;
import java.sql.Date;
import java.time.LocalDate;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AdminVO {
	//회원관리 
	private long mem_num;
	private long mem_auth;
	private String mem_id;
	private long mem_rank;
	private String mem_name;
	private String mem_phone;
	private String mem_email;
	private Date mem_reg_date;
    private LocalDate suspensionDate;
	//맴버십관리
	private long mem_membership;
	private long ph_point; //포인트 돌려주기
	private long ph_type;
	private Date ph_date; //포인트 날짜
	private long mu_num;
	private long mu_type;
	private Date mu_date;
	//결제취소
	private long ph_num; //위에 ph_point랑 ph_date잇

}
