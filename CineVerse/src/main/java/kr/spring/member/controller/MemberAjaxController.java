package kr.spring.member.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MemberAjaxController {
	@Autowired
	private MemberService memberService;
	
	@GetMapping("/member/confirmId")
	@ResponseBody
	public Map<String, String> confirmId(@RequestParam String mem_id){
		log.debug("<<아이디 중복 체크>> : " + mem_id);
		
		Map<String, String> mapAjax = new HashMap<String, String>();
		
		MemberVO member = memberService.selectCheckMember(mem_id);
		
		if(member != null) {
			// 아이디 중복
			mapAjax.put("result", "idDuplicated");
		} else {
			if(!Pattern.matches("^[a-zA-Z0-9]{4,12}$",mem_id)) {
				mapAjax.put("result", "notMatchPattern");
			} else {
//				패턴이 일치하면서 아이디 미중복
				mapAjax.put("result", "idNotFound");
			}
		}
		return mapAjax;
	}
	
	@GetMapping("/member/confirmPhone")
	@ResponseBody
	public Map<String, String> confirmPhone(@RequestParam String mem_phone){
		log.debug("<< 전화번호 중복 체크>> : " + mem_phone);
		
		Map<String, String> mapAjax = new HashMap<String, String>();
		
		MemberVO member = memberService.selectCheckPMember(mem_phone);
		
		if(member != null) {
			mapAjax.put("result", "phoneDuplicated");
		} else {
			mapAjax.put("result", "phoneNotFound");
		}
		return mapAjax;
	}
	
	@GetMapping("/member/confirmEmail")
	@ResponseBody
	public Map<String, String> confirmEmail(@RequestParam String mem_email){
		log.debug("<< 이메일 중복 체크>> : " + mem_email);
		
		Map<String, String> mapAjax = new HashMap<String, String>();
		
		MemberVO member = memberService.selectCheckEMember(mem_email);
		
		if(member != null) {
			mapAjax.put("result", "emailDuplicated");
		} else {
			mapAjax.put("result", "emailNotFound");
		}
		return mapAjax;
	}
	
	 	@PostMapping("/member/pointCharge")
	   @ResponseBody
	    public Map<String, String> chargePoint(@RequestParam Long mem_num, @RequestParam Long ph_point) {
	        log.debug("<<포인트 충전>> ");
	        
	        Map<String, String> mapAjax = new HashMap<String,String>();
	        
	        try {
	            memberService.chargePoint(ph_point, mem_num);
	            mapAjax.put("result", "success");
	        } catch (Exception e) {
	            log.error("포인트 충전 에러", e);
	            mapAjax.put("result", "error");
	        }
	        
	        return mapAjax;
	    }
	
	
	
	
}
