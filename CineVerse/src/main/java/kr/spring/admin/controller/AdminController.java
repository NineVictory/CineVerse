package kr.spring.admin.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.spring.admin.service.AdminService;
import kr.spring.admin.vo.AdminVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.FileUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class AdminController {
	@Autowired
	private AdminService adminService;
	
	//자바빈(VO) 초기화
		@ModelAttribute
		public AdminVO initCommand() {
			return new AdminVO();
		}
	/*==============================
	 * 관리자메인
	 *==============================*/	
	@GetMapping("/admin/adminMain")
	public String process(HttpSession session,Model model) {

		return "adminMain";
	}
	
    // 회원 정보 조회 및 페이지로 전달
    @GetMapping("/admin/adminMember")
    public String formUpdateMember(Model model) {
        try {
            // 모든 회원 정보 조회
            List<AdminVO> adminList = adminService.getAllMembers();

            // 조회된 회원 정보를 모델에 추가하여 View로 전달
            model.addAttribute("adminList", adminList);
            
            return "adminMember"; // 회원 정보를 보여줄 View 이름
        } catch (Exception e) {
            log.error("회원 정보 조회 중 오류 발생", e);
            model.addAttribute("errorMessage", "회원 정보 조회 중 오류가 발생하였습니다.");
            log.debug("<<회원 정보 조회 오류>>");
            return "errorPage"; // 에러 페이지로 이동
            
        }
    }
	// 회원 정지 처리
	@PostMapping("/admin/adminMember")
	public String submitUpdateMember(@ModelAttribute("adminVO") @Valid AdminVO adminVO,
	                           BindingResult result,
	                           Model model,
	                           HttpServletRequest request) throws IllegalStateException, IOException {
	    
	    if (result.hasErrors()) {
	        // 유효성 검사 에러가 있을 경우 처리
		    return "redirect:/admin/adminMember";
	    }
	    // 회원 정지 처리 로직 추가
	    long mem_num = adminVO.getMem_num(); // AdminVO에서 회원 번호 가져오기
	    long mem_auth = adminVO.getMem_auth(); // AdminVO에서 회원 권한 가져오기
	    
	    // 회원 정지 처리 로직 추가
	    adminService.updateAuth(mem_num, mem_auth); // 예시로 adminService의 메소드를 호출하여 회원 상태를 업데이트하는 로직
	    
	    // 정지 처리 후 결과 페이지로 이동
	    return "redirect:/admin/adminMember";
	}
    // 구독 맴버십
    @GetMapping("/admin/adminMembership")
	public String updateMembership(){
		return "adminMembership";
	}
    // 공지사항
    @GetMapping("/admin/adminNotice")
	public void adminNotice(){
	}

    // 이벤트
    @GetMapping("/admin/adminEvent")
	public String adminEvent(){
		return "adminNotice";
	}
    // 결제
    @GetMapping("/admin/admin/adminPayment")
	public String adminPayment(){
		return "adminPayment";
	}
}


