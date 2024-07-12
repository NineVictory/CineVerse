package kr.spring.myPage.vo;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
public class AddressVO {
	private long mem_num;
	private long a_num;
	@NotBlank
	private String a_name;
	@NotBlank
	private String a_zipcode;
	@NotBlank
	private String a_address1;
	@NotBlank
	private String a_address2;
	private int a_default;
	@NotBlank
	@Pattern(regexp = "^010\\d{8}$")
	private String a_phone;
}
