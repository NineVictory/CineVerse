package kr.spring.admin.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.ibatis.annotations.Param;
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
import kr.spring.admin.vo.EventVO;
import kr.spring.board.vo.BoardVO;
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
	//자바빈(VO) 초기화
	@ModelAttribute
	public EventVO initCommand1() {
		return new EventVO();
	}
	/*==============================
	 * 관리자메인
	 *==============================*/	
	@GetMapping("/admin/adminMain")
	public String process(HttpSession session,Model model) {

		return "adminMain";
	}
	/*==============================
	 * 회원관리
	 *==============================*/	

	// 회원 정보 조회 및 페이지로 전달
	@GetMapping("/admin/adminMember")
	public String selectMember(Model model) {
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
	/*==============================
	 * 구독 관리
	 *==============================*/	
	// 구독 정보 조회 및 페이지로 전달
	@GetMapping("/admin/adminMembership")
	public String selectMembership(Model model) {
		try {
			// 모든 회원 정보 조회
			List<AdminVO> adminList = adminService.getAllMembership();

			// 조회된 회원 정보를 모델에 추가하여 View로 전달
			model.addAttribute("adminList", adminList);

			return "adminMembership"; // 회원 정보를 보여줄 View 이름
		} catch (Exception e) {
			log.error("구독 회원 정보 조회 중 오류 발생", e);
			model.addAttribute("errorMessage", "회원 정보 조회 중 오류가 발생하였습니다.");
			log.debug("<<구독 회원 정보 조회 오류>>");
			return "errorPage"; // 에러 페이지로 이동

		}
	}

	@PostMapping("/admin/adminMembership")
	public String updateMembership(){
		return "adminMembership";
	}
	/*==============================
	 * 공지사항 관리
	 *==============================*/	
	@GetMapping("/admin/adminNotice")
	public String adminNotice(){
		return "adminNotice";
	}
	/*==============================
	 * 공지사항 관리
	 *==============================*/	
	@GetMapping("/admin/adminNoticeForm")
	public String adminNoticeForm(){
		return "adminNoticeForm";
	}
	@PostMapping("/admin/adminNoticeForm")
	public String insertAdminNoticeForm(){
		return "adminNoticeForm";
	}
	/*==============================
	 * 이벤트 관리
	 *==============================*/	
	//이벤트 조회
	@GetMapping("/admin/adminEvent")
	public String SelectadminEvent(Model model){
		try {
			// 모든 회원 정보 조회
			List<EventVO> adminList = adminService.getAllEvent();

			// 조회된 회원 정보를 모델에 추가하여 View로 전달
			model.addAttribute("adminList", adminList);

			
			return "adminEvent"; // 회원 정보를 보여줄 View 이름
		} catch (Exception e) {
			log.error("회원 정보 조회 중 오류 발생", e);
			model.addAttribute("errorMessage", "회원 정보 조회 중 오류가 발생하였습니다.");
			log.debug("<<회원 정보 조회 오류>>");
			return "errorPage"; // 에러 페이지로 이동

		}
	}
	//이벤트 수정폼 호출
	@GetMapping("/admin/adminEventForm")
	public String AdminEventForm(){
		return "adminEventForm";
	}
	@PostMapping("admin/adminEventForm")
	public String insertEvent(@Valid EventVO eventVO,
			BindingResult result,
			HttpServletRequest request,
			HttpSession session,
			Model model) throws IllegalStateException,
    						IOException{
		log.debug("<<이벤트 글 저장>> : " + eventVO);
		
		// 폼 데이터 유효성 검사
		if (result.hasErrors()) {
			log.debug("<<유효성검사이상있음>> : " + eventVO);
			return "adminEventForm"; // 다시 폼을 보여줌
		}
		
		eventVO.setEvent_filename(FileUtil.createFile(request, 
				                      eventVO.getUpload()));
		
		log.debug("파일명: " + eventVO.getEvent_filename());
		adminService.insertEvent(eventVO);
		//View 메시지 처리
				model.addAttribute("message", "성공적으로 글이 등록되었습니다.");
				model.addAttribute("url", 
						 request.getContextPath()+"/admin/adminEvent");
				
				return "common/resultAlert";
	}
	// 포인트(결제) 관리
	@GetMapping("/admin/adminPayment")
	public String adminPayment(){
		return "adminPayment";
	}
	/*==============================
	 * 게시판관리
	 *==============================*/	
	// 자유게시판 관리
	@GetMapping("/admin/adminCommunity")
	public String adminComuunity(){
		return "adminCommunity";
	}
	// 양도/교환 관리
	@GetMapping("/admin/adminAssignment")
	public String adminAssignment(){
		return "adminAssignment";
	}
	/*==============================
	 * 벌스샵 관리
	 *==============================*/	
	// 상품 등록 폼
	@GetMapping("/admin/adminShop")
	public String adminShop(){
		return "adminShop";
	}

	@PostMapping("/admin/adminShop")
	public String adminInsertShop(){
		return "adminShop";
	}
	// 배송 상태 관리
	@GetMapping("/admin/adminDelivery")
	public String adminDelivery(){
		return "adminDelivery";
	}
	// 배송지
	@GetMapping("/admin/adminAddress")
	public String adminAddress(){
		return "adminAddress";
	}
	// 상품문의
	@GetMapping("/admin/adminShopQna")
	public String adminShopQna(){
		return "adminShopQna";
	}
	// 상품후기
	@GetMapping("/admin/adminShopReview")
	public String adminShopReview(){
		return "adminShopReview";
	}
	// 영화
	@GetMapping("/admin/adminMovie")
	public String adminShopMovie(){
		return "adminMovie";
	}
	// 영화등록
	@GetMapping("/admin/adminMovieForm") 
	public String adminMovieForm(){
		return "adminMovieForm";
	}
	// 영화
	@GetMapping("/admin/adminCinema")
	public String adminCinema(){
		return "adminCinema";
	}
	// 영화등록
	@GetMapping("/admin/adminCinemaForm") 
	public String adminCinemaForm(){
		return "adminCinemaForm";
	}
}


