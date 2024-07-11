package kr.spring.myPage.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
public class AddressVO {
	private long mem_num;
	private long a_num;
	private String a_name;
	private String a_zipcode;
	private String a_address1;
	private String a_address2;
	private int a_default;
	private String a_phone;
}
