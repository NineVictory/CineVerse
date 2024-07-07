package kr.spring.member.controller;

import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.AuthCheckException;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MemberController {

	@Autowired
	public MemberService memberService;

	@ModelAttribute
	public MemberVO initCommand() {
		return new MemberVO();
	}

	@GetMapping("/member/register")
	public String memberRegisterForm() {
		return "memberRegister";
	}

	@PostMapping("/member/register")
	public String memberRegister(@Valid MemberVO memberVO, BindingResult result, Model model,
			HttpServletRequest request) {
		log.debug("<<회원 가입>> : " + memberVO);

		if (result.hasErrors()) {
			return memberRegisterForm();
		}

		memberService.insertMember(memberVO);

		// UI 문구 처리
		model.addAttribute("message", "회원 가입이 완료되었습니다");
		model.addAttribute("url", request.getContextPath() + "/main/main");
		return "common/resultAlert";
	}

	@GetMapping("/member/login")
	public String memberLoginForm() {
		return "memberLogin";
	}

	// 회원 로그인 처리하기
	@PostMapping("/member/login")
	public String memberLogin(@Valid MemberVO memberVO, BindingResult result, HttpSession session,
			HttpServletResponse response) {

		log.debug("<< 로그인 >> : " + memberVO);

		// 유효성 체크 결과 오류가 있다면 form 호출
		if (result.hasFieldErrors("id") || result.hasFieldErrors("passwd")) {
			return memberLoginForm();
		}

		// 아이디 비밀번호 일치 여부 체크하기
		MemberVO member = null;

		try {
			member = memberService.selectCheckMember(memberVO.getMem_id());

			boolean check = false;

			if (member != null) { // 아이디 존재함
				// 비밀번호 일치 여부 체크
				check = member.ischeckedPassword(memberVO.getMem_passwd());
			}
			// true 라면 if(check) 내부로 진입함
			if (check) { // 인증 성공
				// 자동 로그인 체크 시작

				// 자동 로그인 체크 종료

				// 멤버 확인하여 로그인 처리
				// session에다가 자바빈을 통채로 집어넣기
				session.setAttribute("user", member);
				session.setAttribute("email", member.getMem_email());
				session.setAttribute("name", member.getMem_name());
				session.setAttribute("phone", member.getMem_phone());

				log.debug("<< 인증 성공! >>");
				log.debug("<< ID >> : " + member.getMem_id());
				log.debug("<< Au_ID >> : " + member.getAu_id());
				log.debug("<< Auth >> : " + member.getMem_auth());

				if (member.getMem_auth() == 9) {
					// 관리자라면
					return "redirect:/main/admin";
				} else {
					return "redirect:/main/main";
				}
			}
			// 인증 실패
			throw new AuthCheckException();
		} catch (AuthCheckException e) {
			// 인증 실패 로그인 폼 호출하기

			if (member != null && member.getMem_auth() == 1) {
				// 정지회원 메세지 표시하기
				result.reject("noAuthority");
			} else if (member != null && member.getMem_auth() == 2) {
				// 탈퇴회원 메세지 표시하기
				result.reject("deleteMem");
			} else {
				result.reject("invalidIdOrPassword");
			}
			log.debug("<< 인증에 실패하였습니다. >>");
		}
		return memberLoginForm();
	}

	// 로그아웃 처리하기
	@GetMapping("/member/logout")
	public String processLogout(HttpSession session) {

		// 로그아웃 처리
		session.invalidate();

		log.debug("<< 로그아웃이 완료되었습니다! >>");
		return "redirect:/main/main";
	}

	// 아이디찾기
	@GetMapping("/member/findId")
	public String findIdForm() {

		return "memberFindId";
	}
	
	@PostMapping("/member/findId")
	public String findId(@Valid MemberVO memberVO, BindingResult result,Model model,
			HttpServletRequest request) {
		
		log.debug("<< 아이디 찾기 >> " + memberVO);
		
		if (result.hasFieldErrors("mem_name") || result.hasFieldErrors("mem_phone")) {
			return findIdForm();
		}
		
		MemberVO member = memberService.findId(memberVO);

		if(member == null) {
			model.addAttribute("message", "정보에 맞는 회원이 없습니다. 재시도해주세요.");
			model.addAttribute("url", request.getContextPath() + "/member/findId");
			return "common/resultAlert";
		}

		// UI 문구 처리
		model.addAttribute("id", member.getMem_id());
		model.addAttribute("url", request.getContextPath() + "/main/main");
		return "common/resultFindId";
	}

	// 비밀번호찾기
	@GetMapping("/member/findPasswd")
	public String findPasswdForm() {

		return "memberFindPasswd";
	}
	
	@PostMapping("/member/findPasswd")
	public String findPasswd(@Valid MemberVO memberVO, BindingResult result, String mem_passwd,
							 Model model,HttpServletRequest request) {
		log.debug("<< 비밀번호 찾기 >> " + memberVO);
		
		if(result.hasFieldErrors("mem_id") || 
				result.hasFieldErrors("mem_phone") || 
					result.hasFieldErrors("mem_email")) {
			return findPasswdForm();
		}
		
	MemberVO member = memberService.updateRandomPasswd(memberVO);
	
	if(member == null) {
		model.addAttribute("message", "정보에 맞는 회원이 없습니다. 재시도해주세요.");
		model.addAttribute("url", request.getContextPath() + "/member/findPasswd");
		return "common/resultAlert";
	}
		String temp_pw = "";
		UUID uuid = UUID.randomUUID();
		
		log.debug("<< 임시 비밀번호 >> : " + uuid);
		
		temp_pw = uuid.toString().substring(0, 6);
		
		memberService.updatePassword(temp_pw, memberVO.getMem_id());
		
		model.addAttribute("accessTitle","임시 비밀번호 생성");
		model.addAttribute("accessMsg","임시 비밀번호가 발급되었습니다.");
		model.addAttribute("new_passwd",temp_pw);
		model.addAttribute("accessBtn","로그인");
		model.addAttribute("accessUrl", request.getContextPath()+"/member/login");
		
		return "common/resultFindPasswd";
	}
	
	@GetMapping("/member/pointCharge")
	public String pointChargeForm() {
		return "memberPointCharge";
	}
	
	@GetMapping("/member/extraInfo")
	public String kakaoLoginForm() {
		return "extraInfo";
	}
	
	

}
