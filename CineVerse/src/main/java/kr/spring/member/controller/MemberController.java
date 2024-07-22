package kr.spring.member.controller;

import java.util.List;
import java.util.UUID;

import javax.servlet.http.Cookie;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.spring.member.service.MemberService;
import kr.spring.member.vo.CouponVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.AuthCheckException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.RequestParam;


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
		
		// 초기 쿠폰 리스트 조회
        List<Long> initialCoupons = memberService.selectInitialCoupons();
        
        // 회원 쿠폰 테이블에 초기 쿠폰 삽입
        for (Long coupon_num : initialCoupons) {
        	CouponVO coupon = new CouponVO();
            coupon.setMem_num(memberVO.getMem_num());
            coupon.setCoupon_num(coupon_num);
            memberService.insertNewMemCoupon(coupon);
        }
		

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
			if (check) { 
				// 자동 로그인 체크 시작
				boolean autoLogin = memberVO.getAuto() != null && memberVO.getAuto().equals("on");
				if(autoLogin) {
					// 자동 로그인을 체크한 경우
					String au_id = member.getAu_id();
					
					if(au_id == null) {
						au_id = UUID.randomUUID().toString();
						log.debug(" << au_id >>  : " + au_id);
						member.setAu_id(au_id);
						memberService.updateAu_id(member.getAu_id(), member.getMem_num());
					}
					Cookie auto_cookie = new Cookie("au-log", au_id);
					auto_cookie.setMaxAge(60*60*24*7);
					auto_cookie.setPath("/");
					
					response.addCookie(auto_cookie);
				}
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
					return "redirect:/admin/adminMain";
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
	public String processLogout(HttpSession session, HttpServletResponse response) {

		// 로그아웃 처리
		session.invalidate();
		
		Cookie auto_cookie = new Cookie("au-log", "");
		auto_cookie.setMaxAge(0);	// 쿠키 삭제하기
		auto_cookie.setPath("/");
		
		response.addCookie(auto_cookie);

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
	
	@GetMapping("/member/pointCharge")
	public String pointChargeForm() {
		return "memberPointCharge";
	}
	
	// 카카오 회원가입 폼 띄우기
	@RequestMapping(value = "/member/kakaoRegisterForm", method = RequestMethod.GET)
	public String kakaoRegisterForm(@RequestParam String mem_email, @RequestParam String mem_nickname,
									@RequestParam String social_kakao, Model model) {
	    MemberVO member = new MemberVO();
	    member.setMem_email(mem_email);
	    member.setMem_nickname(mem_nickname);
	    member.setSocial_kakao(social_kakao);
	    model.addAttribute("memberVO", member);
	    return "member/kakaoRegisterForm";
	}
	
	
	@PostMapping("/member/kakaoRegisterForm")
	public String kakaoRegister(@Valid MemberVO memberVO, BindingResult result, Model model,
			HttpServletRequest request) {
		log.debug("<<카카오 회원 가입>> : " + memberVO);

		if (result.hasErrors()) {
			return "member/kakaoRegisterForm";
		}

		memberService.insertKakaoMemberDetail(memberVO);
		
		// 초기 쿠폰 리스트 조회
        List<Long> initialCoupons = memberService.selectInitialCoupons();
        
        // 회원 쿠폰 테이블에 초기 쿠폰 삽입
        for (Long coupon_num : initialCoupons) {
        	CouponVO coupon = new CouponVO();
            coupon.setMem_num(memberVO.getMem_num());
            coupon.setCoupon_num(coupon_num);
            memberService.insertNewMemCoupon(coupon);
        }
		

		// UI 문구 처리
		model.addAttribute("message", "회원 가입이 완료되었습니다");
		model.addAttribute("url", request.getContextPath() + "/main/main");
		return "common/resultAlert";
	}

	
	
	@GetMapping("/admin/admin")
	public String adminMain() {
		return "admin";
	}
	
	
	@GetMapping("/member/membershipInfo")
	public String membershipInfo(HttpSession session, Model model) {
	    
	    MemberVO user = (MemberVO) session.getAttribute("user");
	    
	    if (user != null) {
	        MemberVO member = memberService.selectMember(user.getMem_num());
	        int used_point = memberService.selectPointUse(user.getMem_num());
	        member.setUsed_point(used_point);
	        model.addAttribute("member", member);
	    } else {
	        // 로그인하지 않은 경우 기본값 설정
	        MemberVO member = new MemberVO();
	        member.setMem_num(0); // 기본값 예시
	        member.setUsed_point(0); // 기본값 예시
	        model.addAttribute("member", member);
	    }
	    
	    log.debug("<< 멤버쉽 info 진입 >>");
	    
	    return "membershipInfo";
	}

	
}
