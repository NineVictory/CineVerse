package kr.spring.member.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.member.email.Email;
import kr.spring.member.email.EmailSender;
import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.FileUtil;
import kr.spring.util.StringUtil;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
public class MemberAjaxController {
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private EmailSender	emailSender;
	
	@Autowired
	private Email email;

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
				// 패턴이 일치하면서 아이디 미중복
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
	public Map<String, String> chargePoint(@RequestParam Long mem_num, @RequestParam Long ph_point, @RequestParam String ph_payment) {
		log.debug("<<포인트 충전>> ");

		Map<String, String> mapAjax = new HashMap<String,String>();

		try {
			memberService.chargePoint(ph_point, mem_num,ph_payment);

			memberService.totalPoint(mem_num);

			mapAjax.put("result", "success");

		} catch (Exception e) {
			log.error("포인트 충전 에러", e);
			mapAjax.put("result", "error");
		}

		return mapAjax;
	}

	@PostMapping("/member/kakaoRegister")
	@ResponseBody
	public Map<String, String> kakaoRegister(@RequestParam String mem_email, @RequestParam String mem_nickname,
	                                         @RequestParam String social_kakao, @RequestParam String profile_image,
	                                         HttpServletRequest request, HttpSession session) {
	    Map<String, String> mapAjax = new HashMap<>();

	    try {
	        // 이미 가입된 회원인지 확인
	        MemberVO member = memberService.selectCheckEMember(mem_email);
	        if (member != null) {
	            // 이미 회원이면 로그인 처리하기
	            session.setAttribute("user", member);
	            session.setAttribute("email", member.getMem_email());
	            session.setAttribute("name", member.getMem_name());
	            session.setAttribute("phone", member.getMem_phone());

	            mapAjax.put("result", "success");
	        } else {

	            // 필요한 회원 정보 설정
	            member = new MemberVO();
	            member.setMem_email(mem_email);
	            member.setMem_nickname(mem_nickname);

	            mapAjax.put("result", "registerkakao");
	        }
	    } catch (Exception e) {
	        mapAjax.put("result", "error");
	        e.printStackTrace();
	    }
	    return mapAjax;
	}
	
	@PostMapping("/member/getPasswordInfo")
	@ResponseBody
	public Map<String, String> sendEmailAction (MemberVO memberVO){
		
		log.debug("<< 비밀번호 찾기 >> : " + memberVO);
		
		Map<String,String> mapJson = new HashMap<String, String>();
		MemberVO member = memberService.selectCheckMember(memberVO.getMem_id());
		
		// 오류를 대비해서 원래 비번 저장하기
		if(member != null && member.getMem_auth() > 2 
				&& member.getMem_email().equals(memberVO.getMem_email()) 
				&& member.getMem_phone().equals(memberVO.getMem_phone())) {
			String origin_passwd = member.getMem_passwd();
			
			String passwd = StringUtil.randomPassword(10); // 10글자로 지정
			member.setMem_passwd(passwd);	// 임시비밀번호를 db에 저장
			memberService.updatePassword(member);
			
			String content = "<table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\" align=\"center\" bgcolor=\"#ffffff\" style=\"border-collapse:collapse\">" +
				    "<tbody>" +
				    "<tr>" +
				        "<td>" +
				            "<table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\" align=\"center\" bgcolor=\"#ffffff\" style=\"max-width:640px;margin:0 auto\">" +
				                "<tbody>" +
				                "<tr>" +
				                    "<td width=\"100%\" height=\"45\" colspan=\"3\" bgcolor=\"#DBE3FF\"></td>" +
				                "</tr>" +
				                "<tr>" +
				                    "<td width=\"6%\" height=\"25\" bgcolor=\"#DBE3FF\"></td>" +
				                    "<td width=\"88%\" height=\"25\" bgcolor=\"#DBE3FF\">" +
				                        "<img src=\"https://i.imgur.com/LCDmQ9H.png\" width=\"180\" alt=\"CINEVERSE\" border=\"0\" style=\"display:block\">" +
				                    "</td>" +
				                    "<td width=\"6%\" height=\"25\" bgcolor=\"#DBE3FF\"></td>" +
				                "</tr>" +
				                "<tr>" +
				                    "<td width=\"100%\" height=\"45\" colspan=\"3\" bgcolor=\"#DBE3FF\"></td>" +
				                "</tr>" +
				                "<tr>" +
				                    "<td width=\"100%\" height=\"35\" colspan=\"3\"></td>" +
				                "</tr>" +
				                "<tr>" +
				                    "<td width=\"6%\"></td>" +
				                    "<td width=\"88%\" style=\"font-size:18px;line-height:22px;font-family:Arial, sans-serif;letter-spacing:-1px;font-weight:bold;color:#1e1e1e\">" +
				                        "안녕하세요, " + member.getMem_id() + " 님" +
				                    "</td>" +
				                    "<td width=\"6%\"></td>" +
				                "</tr>" +
				                "<tr>" +
				                    "<td width=\"100%\" height=\"31\" colspan=\"3\"></td>" +
				                "</tr>" +
				                "<tr>" +
				                    "<td width=\"6%\"></td>" +
				                    "<td width=\"88%\">" +
				                        "<table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\" style=\"line-height:22px;font-family:Arial, sans-serif;letter-spacing:-1px;color:#1e1e1e\">" +
				                            "<tbody>" +
				                            "<tr>" +
				                                "<td width=\"100%\" height=\"1\" colspan=\"5\" bgcolor=\"#bebebe\"></td>" +
				                            "</tr>" +
				                            "<tr>" +
				                                "<td width=\"100%\" height=\"25\" colspan=\"5\"></td>" +
				                            "</tr>" +
				                            "<tr>" +
				                                "<td width=\"3%\"></td>" +
				                                "<th width=\"22%\" valign=\"top\" align=\"left\" style=\"font-size:14px;font-weight:normal\">임시 비밀번호</th>" +
				                                "<td width=\"2%\"></td>" +
				                                "<td width=\"70%\" valign=\"top\" style=\"font-size:14px;font-weight:bold;word-break:break-all\"><strong>" + passwd + "</strong></td>" +
				                                "<td width=\"3%\"></td>" +
				                            "</tr>" +
				                            "<tr>" +
				                                "<td width=\"100%\" height=\"8\" colspan=\"5\"></td>" +
				                            "</tr>" +
				                            "</tbody>" +
				                        "</table>" +
				                    "</td>" +
				                    "<td width=\"6%\"></td>" +
				                "</tr>" +
				                "<tr>" +
				                    "<td width=\"100%\" height=\"24\" colspan=\"3\"></td>" +
				                "</tr>" +
				                "<tr>" +
				                    "<td width=\"6%\"></td>" +
				                    "<td width=\"88%\" style=\"font-size:14px;line-height:22px;font-family:Arial, sans-serif;letter-spacing:-1px;color:#1e1e1e\">" +
				                        "발급된 임시 비밀번호로 로그인 후 비밀번호 변경을 꼭 해주시길 바랍니다.<br>감사합니다." +
				                    "</td>" +
				                    "<td width=\"6%\"></td>" +
				                "</tr>" +
				                "<tr>" +
				                    "<td width=\"100%\" height=\"28\" colspan=\"3\"></td>" +
				                "</tr>" +
				                "<tr>" +
				                    "<td width=\"100%\" height=\"1\" colspan=\"3\" bgcolor=\"#e6e6e6\"></td>" +
				                "</tr>" +
				                "<tr>" +
				                    "<td width=\"100%\" height=\"16\" colspan=\"3\"></td>" +
				                "</tr>" +
				                "<tr>" +
				                    "<td width=\"6%\"></td>" +
				                    "<td width=\"88%\" style=\"font-size:12px;line-height:18px;font-family:Arial, sans-serif;letter-spacing:-1px;color:#767676\">" +
				                        "본 메일은 발신전용입니다.<br>CINEVERSE 관련하여 궁금한 점이 있으시면 " +
				                        "<a href=\"#\" style=\"color:#3c64e6;text-decoration:underline\" target=\"_blank\">도움말</a>을 확인해 보세요.<br>" +
				                        "Copyright © CINEVERSE. All rights reserved." +
				                    "</td>" +
				                    "<td width=\"6%\"></td>" +
				                "</tr>" +
				                "<tr>" +
				                    "<td width=\"100%\" height=\"18\" colspan=\"3\"></td>" +
				                "</tr>" +
				                "</tbody>" +
				            "</table>" +
				        "</td>" +
				    "</tr>" +
				    "<tr>" +
				        "<td width=\"100%\" height=\"100\"></td>" +
				    "</tr>" +
				    "</tbody>" +
				"</table>";

			
			email.setContent(content);
			email.setReceiver(member.getMem_email());
			email.setSubject(member.getMem_id() + " 님 임시 비밀번호 메일입니다.");
			
			try {
				emailSender.sendEmail(email);
				mapJson.put("result", "success");
			} catch (Exception e) {
				log.error("<< 비밀 번호 찾기>>" + e.toString());
				
				// 오류 발생시 비밀번호 원상 복구
				member.setMem_passwd(origin_passwd);
				memberService.updatePassword(member);
				mapJson.put("result", "failure");
			}
			
		} else if (member != null && member.getMem_auth() == 2) {
			//  정지 회원의 경우
			mapJson.put("result", "noAuthority");
		} else {
			mapJson.put("result", "invalidInfo");
		}
		
		return mapJson;
	}
	
	

}
