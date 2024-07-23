package kr.spring.admin.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.admin.service.AdminService;
import kr.spring.admin.vo.AdminVO;
import kr.spring.admin.vo.EventVO;
import kr.spring.admin.vo.NoticeVO;
import kr.spring.admin.vo.ReplyVO;
import kr.spring.assignment.vo.AssignVO;
import kr.spring.board.vo.BoardCommentVO;
import kr.spring.board.vo.BoardVO;
import kr.spring.cinema.vo.CinemaVO;
import kr.spring.cinema.vo.TheaterVO;
import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.member.vo.PointVO;
import kr.spring.movie.vo.MovieVO;
import kr.spring.seat.vo.SeatVO;
import kr.spring.support.vo.ConsultVO;
import kr.spring.util.FileUtil;
import kr.spring.util.PagingUtil;
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
	//자바빈(VO) 초기화
	@ModelAttribute
	public NoticeVO initCommand3() {
		return new NoticeVO();
	}
	@ModelAttribute
	public CinemaVO initComman4() {
		return new CinemaVO();
	}
	//자바빈(VO) 초기화
	@ModelAttribute
	public TheaterVO initCommand4() {
		return new TheaterVO();
	}
	@ModelAttribute
	public SeatVO initCommand5() {
		return new SeatVO();
	}
	@ModelAttribute
	public ReplyVO initCommand6() {
		return new ReplyVO();
	}
	@ModelAttribute
	public ConsultVO initCommand7() {
		return new ConsultVO();
	}
	/*==============================
	 * 관리자메인
	 *==============================*/	
	@GetMapping("/admin/adminMain")
	public String process(HttpSession session,Model model) {
		try {
			// 모든 회원 수
			int memTotal = adminService.totalMember();
			// 모든 게시글
			int commuTotal = adminService.totalCommunity();
			int assignTotal = adminService.totalAssignment();

			int boardTotal = commuTotal + assignTotal;

			// 모든 판매 상품 수
			int productTotal = adminService.totalProduct();

			// 모든 상영 영화 수
			int movieTotal = adminService.totalMovie();

			// 모든 자체영화관 수
			int cinemaTotal = adminService.totalCinema();

			// 조회된 회원 정보를 모델에 추가하여 View로 전달
			model.addAttribute("memTotal", memTotal);
			model.addAttribute("boardTotal", boardTotal);
			model.addAttribute("productTotal", productTotal);
			model.addAttribute("movieTotal", movieTotal);
			model.addAttribute("cinemaTotal", cinemaTotal);

			return "adminMain"; // 회원 정보를 보여줄 View 이름
		} catch (Exception e) {
			log.error("회원 정보 조회 중 오류 발생", e);
			model.addAttribute("errorMessage", "회원 정보 조회 중 오류가 발생하였습니다.");
			log.debug("<<회원 정보 조회 오류>>");
			return "errorPage"; // 에러 페이지로 이동

		}
	}
	/*==============================
	 * 회원관리
	 *==============================*/	

	// 회원 정보 조회 및 페이지로 전달
	@GetMapping("/admin/adminMember")
	public String getMemberList(
			@RequestParam(defaultValue="1") int pageNum,
			String keyfield,String keyword,Model model) {

		Map<String,Object> map = 
				new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);

		//전체,검색 레코드수
		int count = adminService.selectMemberRowCount(map);

		//페이지 처리
		PagingUtil page = 
				new PagingUtil(keyfield,keyword,pageNum,
						count,10,10,"adminMember");
		List<AdminVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());

			list = adminService.selectMemberList(map);
		}

		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("page", page.getPage());

		return "adminMember";
	}

	// 회원 정지 처리
	@PostMapping("/stopMember")
	@ResponseBody
	public String stopMember(@RequestParam("mem_num") int mem_num) {
		// auth 값을 0으로 업데이트하는 예시입니다.
		adminService.updateMemberAuth(mem_num);
		log.debug("<<회원정지 완료>>");
		return "success";

	}

	// 회원 정지 처리
	@PostMapping("/deleteMember")
	@ResponseBody
	public String deleteMember(@RequestParam("mem_num") int mem_num) {
		// auth 값을 1으로 업데이트하는 예시입니다.
		adminService.deleteMemberAuth(mem_num);
		log.debug("<<회원탈퇴 완료>>");
		return "success";

	}
	/*==============================
	 * 구독 관리
	 *==============================*/	
	// 구독 정보 조회 및 페이지로 전달
	@GetMapping("/admin/adminMembership")
	public String getMembershipList(
			@RequestParam(defaultValue="1") int pageNum,
			String keyfield,String keyword,Model model) {

		Map<String,Object> map = 
				new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);

		//전체,검색 레코드수
		int count = adminService.selectMemberRowCount(map);

		//페이지 처리
		PagingUtil page = 
				new PagingUtil(keyfield,keyword,pageNum,
						count,20,10,"adminMembership");
		List<AdminVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());

			list = adminService.selectMembershipList(map);
		}

		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("page", page.getPage());

		return "adminMembership";
	}

	// 회원 정지 처리
	@PostMapping("/refundMembership")
	@ResponseBody
	public String refundMembership(@RequestParam("mem_num") long mem_num, @Param("point_payment") String point_payment) {
		// auth 값을 1으로 업데이트하는 예시입니다.
		adminService.refundMembership(mem_num, point_payment);
		log.debug("<<맴버쉽 업데이트 완료>>");
		return "success";

	}
	/*==============================
	 * 공지사항 관리
	 *==============================*/	
	//공지사항 조회
	@GetMapping("/admin/adminNotice")
	public String getNoticeList(
			@RequestParam(defaultValue="1") int pageNum,
			String keyfield,String keyword,Model model) {

		Map<String,Object> map = 
				new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);

		//전체,검색 레코드수
		int count = adminService.selectNoticeRowCount(map);

		//페이지 처리
		PagingUtil page = 
				new PagingUtil(keyfield,keyword,pageNum,
						count,20,10,"adminNotice");
		List<NoticeVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());

			list = adminService.selectNoticeList(map);
		}

		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("page", page.getPage());

		return "adminNotice";
	}
	// 공지사항 삭제 처리
	@PostMapping("/deleteNotice")
	@ResponseBody
	public String deleteNotice(@RequestParam("nb_num") int nb_num) {
		adminService.deleteNotice(nb_num);
		log.debug("<<공지사항 삭제완료>>");
		return "success";

	}

	//공지사항 등록폼 호출
	@GetMapping("/admin/adminNoticeForm")
	public String AdminNoticeForm(NoticeVO noticeVO){
		return "adminNoticeForm";
	}
	@PostMapping("admin/adminNoticeForm")
	public String insertNotice(@Valid NoticeVO noticeVO,
			BindingResult result,
			HttpServletRequest request,
			HttpSession session,
			Model model) throws IllegalStateException,IOException{
		log.debug("<<이벤트 글 저장>> : " + noticeVO);

		//업로드된 파일이 없는 경우
		//if(noticeVO.getNb_upload()==null || noticeVO.getNb_upload().isEmpty()) {
		//	result.rejectValue("nb_upload","fileNotFound");
		//}

		// 폼 데이터 유효성 검사
		if (result.hasErrors()) {
			log.debug("<<유효성검사이상있음>> : " + noticeVO);
			return "adminNoticeForm"; // 다시 폼을 보여줌
		}

		MemberVO vo = (MemberVO)session.getAttribute("user");
		//비로그인 상태 유효성 체크
		if(vo == null) {
			log.debug("<<비로그인 상태>> :" + vo);
			return "adminNoticeForm"; // 다시 폼을 보여줌
		}
		noticeVO.setMem_num(vo.getMem_num());
		noticeVO.setNb_filename(FileUtil.createFile(request, 
				noticeVO.getNb_upload()));

		log.debug("파일명: " + noticeVO.getNb_filename());
		adminService.insertNotice(noticeVO);
		//View 메시지 처리
		model.addAttribute("message", "성공적으로 글이 등록되었습니다.");
		model.addAttribute("url", 
				request.getContextPath()+"/admin/adminNotice");

		return "common/resultAlert";
	}
	/*==============================
	 * 이벤트 관리
	 *==============================*/	
	//이벤트 조회
	@GetMapping("/admin/adminEvent")
	public String getEventList(
			@RequestParam(defaultValue="1") int pageNum,
			String keyfield,String keyword,Model model) {

		Map<String,Object> map = 
				new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);

		//전체,검색 레코드수
		int count = adminService.selectEventRowCount(map);

		//페이지 처리
		PagingUtil page = 
				new PagingUtil(keyfield,keyword,pageNum,
						count,20,10,"adminEvent");
		List<EventVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());

			list = adminService.selectEventList(map);
		}

		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("page", page.getPage());

		return "adminEvent";
	}
	// 이벤트 삭제 처리
	@PostMapping("/deleteEvent")
	@ResponseBody
	public String deleteEvent(@RequestParam("event_num") int event_num) {
		adminService.deleteEvent(event_num);
		log.debug("<<이벤트 삭제 완료>>");
		return "success";

	}
	//이벤트 등록 폼 호출
	@GetMapping("/admin/adminEventForm")
	public String AdminEventForm(){
		return "adminEventForm";
	}
	//이벤트 등록
	@PostMapping("admin/adminEventForm")
	public String insertEvent(@Valid EventVO eventVO,
			BindingResult result,
			HttpServletRequest request,
			HttpSession session,
			Model model) throws IllegalStateException,IOException{
		log.debug("<<이벤트 글 저장>> : " + eventVO);

		//업로드된 파일이 없는 경우
		if(eventVO.getEvent_upload()==null || eventVO.getEvent_upload().isEmpty()) {
			result.rejectValue("event_upload","fileNotFound");
		}

		// 폼 데이터 유효성 검사
		if (result.hasErrors()) {
			log.debug("<<유효성검사이상있음>> : " + eventVO);
			return "adminEventForm"; // 다시 폼을 보여줌
		}

		eventVO.setEvent_filename(FileUtil.createFile(request, 
				eventVO.getEvent_upload()));

		log.debug("파일명: " + eventVO.getEvent_filename());
		adminService.insertEvent(eventVO);
		//View 메시지 처리
		model.addAttribute("message", "성공적으로 글이 등록되었습니다.");
		model.addAttribute("url", 
				request.getContextPath()+"/admin/adminEvent");

		return "common/resultAlert";
	}
	/*==============================
	 * 게시판관리
	 *==============================*/	
	// 게시판 통합 관리
	@GetMapping("/admin/adminCommunity")
	public String adminCommunity(
			@RequestParam(defaultValue = "1") int pageNum,
			@RequestParam(value = "keyword", required = false) String keyword,
			@RequestParam(value = "keyfield", required = false) String keyfield,
			Model model) {
		// keyfield가 없으면 기본값을 설정
		if (keyfield == null || keyfield.isEmpty()) {
			keyfield = "cb_title"; // 기본 검색 필드를 설정합니다.
		}

		// 파라미터를 맵에 추가
		Map<String, Object> map = new HashMap<>();
		map.put("keyword", keyword);
		map.put("keyfield", keyfield);

		// 전체, 검색 레코드 수
		int count = adminService.selectCommunityRowCount(map);

		// 페이지 처리
		PagingUtil page = new PagingUtil(keyfield, keyword, pageNum, count, 15, 10, "adminCommunity");

		List<BoardVO> list = null; 
		if (count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());

			list = adminService.selectCommunityList(map);
		}

		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("page", page.getPage());

		return "adminCommunity";

	}



	// 양도게시판 관리
	@GetMapping("/admin/adminAssign")
	public String adminAssign(
			@RequestParam(defaultValue = "1") int pageNum,
			@RequestParam(value = "keyword", required = false) String keyword,
			@RequestParam(value = "keyfield", required = false) String keyfield,
			Model model) {
		// keyfield가 없으면 기본값을 설정
		if (keyfield == null || keyfield.isEmpty()) {
			keyfield = "ab_title"; // 기본 검색 필드를 설정합니다.
		}

		// 파라미터를 맵에 추가
		Map<String, Object> map = new HashMap<>();
		map.put("keyword", keyword);
		map.put("keyfield", keyfield);

		// 전체, 검색 레코드 수
		int count = adminService.selectAssignRowCount(map);

		// 페이지 처리
		PagingUtil page = new PagingUtil(keyfield, keyword, pageNum, count, 15, 10, "adminAssign");

		List<AssignVO> list = null; 
		if (count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());

			list = adminService.selectAssginList(map);
		}

		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("page", page.getPage());

		return "adminAssign";

	}
	
	
	// 게시판 댓글 관리
	@GetMapping("/admin/adminReply")
	public String adminReply(
			@RequestParam(defaultValue = "1") int pageNum,
			@RequestParam(value = "keyword", required = false) String keyword,
			@RequestParam(value = "keyfield", required = false) String keyfield,
			Model model) {
		// keyfield가 없으면 기본값을 설정
		if (keyfield == null || keyfield.isEmpty()) {
			keyfield = "mem_num"; // 기본 검색 필드를 설정합니다.
		}

		// 파라미터를 맵에 추가
		Map<String, Object> map = new HashMap<>();
		map.put("keyword", keyword);
		map.put("keyfield", keyfield);

		// 전체, 검색 레코드 수
		int count = adminService.selectReplyRowCount(map);
		count += adminService.selectReCmtRowCount(map);
		// 페이지 처리
		PagingUtil page = new PagingUtil(keyfield, keyword, pageNum, count, 10, 5, "adminReply");
		
		List<ReplyVO> list = null; 
		if (count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());

			list = adminService.selectReplyList(map);
			list.addAll(adminService.selectReCmtList(map));
		}
		log.debug("<<댓글 확인>>" + list);
		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("page", page.getPage());

		return "adminReply";

	}
	// 댓글 삭제 처리
	@PostMapping("/deleteReply")
	@ResponseBody
	public String deleteReply(@RequestParam("cc_num") long cc_num) {
		adminService.deleteReply(cc_num);
		log.debug("<<댓글 삭제 완료>>");
		return "success";

	}
	// 대댓글 삭제 처리
	@PostMapping("/deleteCmt")
	@ResponseBody
	public String deleteCmt(@RequestParam("te_num") long te_num) {
		adminService.deleteCmt(te_num);
		log.debug("<<댓글 삭제 완료>>");
		return "success";

	}
	// 영화
	@GetMapping("/admin/adminMovie")
	public String adminMovie(
			@RequestParam(defaultValue = "1") int pageNum,
			@RequestParam(value = "keyword", required = false) String keyword,
			@RequestParam(value = "keyfield", required = false) String keyfield,
			Model model) {
		// keyfield가 없으면 기본값을 설정
		if (keyfield == null || keyfield.isEmpty()) {
			keyfield = "m_name"; // 기본 검색 필드를 설정합니다.
		}

		// 파라미터를 맵에 추가
		Map<String, Object> map = new HashMap<>();
		map.put("keyword", keyword);
		map.put("keyfield", keyfield);

		// 전체, 검색 레코드 수
		int count = adminService.selectMovieRowCount(map);

		// 페이지 처리
		PagingUtil page = new PagingUtil(keyfield, keyword, pageNum, count, 10, 10, "adminMovie");

		List<MovieVO> list = null; 
		if (count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());

			list = adminService.selectMovie(map); 
		}

		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("page", page.getPage());

		return "adminMovie";

	}
	// 영화 삭제 처리
	@PostMapping("/deleteMovie")
	@ResponseBody
	public String deleteMovie(@RequestParam("m_code") long m_code) {
		adminService.deleteMovie(m_code);
		log.debug("<<영화 삭제 완료>>");
		return "success";

	}
	// 영화
	@GetMapping("/admin/adminMovieTime")
	public String adminMovieTime(){
		return "adminMovieTime";
	}
	// 영화관등록 폼 호출
	@GetMapping("/admin/adminCinemaForm")
	public String showCinemaForm(Model model) {
		model.addAttribute("cinemaVO", new CinemaVO());
		model.addAttribute("theaterList", new ArrayList<>());

		return "adminCinemaForm";
	}
    @ModelAttribute("theaterVOList")
    public List<TheaterVO> initializeTheaterList() {
        return new ArrayList<>();
    }
	//영화관 등록
    @PostMapping("/admin/adminCinemaForm")
    @Transactional
    public String insertCinema(@ModelAttribute("cinemaVO") @Valid CinemaVO cinemaVO,@Valid TheaterVO theaterVO,
                               BindingResult result,
                               Model model) {
    	log.debug("<<영화관 등록>> : " + cinemaVO);
    	if (result.hasErrors()) {
            return "adminCinemaForm"; // 유효성 검사 오류 시 폼을 다시 보여줌
        }		
		  // 영화관 정보 저장 
			
			 adminService.insertCinema(cinemaVO);
			 
        // View 메시지 처리
        model.addAttribute("message", "영화관 및 상영관이 성공적으로 등록되었습니다.");
        model.addAttribute("url", "/admin/adminCinemaForm");
        return "common/resultAlert";
    }

	//영화관 목록
	@GetMapping("/admin/adminCinema")
	public String getCinemaList(
			@RequestParam(defaultValue="1") int pageNum,
			String keyfield,String keyword,Model model) {

		Map<String,Object> map = 
				new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);

		//전체,검색 레코드수
		int count = adminService.selectCinemaRowCount(map);

		//페이지 처리
		PagingUtil page = 
				new PagingUtil(keyfield,keyword,pageNum,
						count,20,10,"adminCinema");
		List<CinemaVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());

			list = adminService.selectCinema(map);
		}

		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("page", page.getPage());

		return "adminCinema";
	}
	// 영화관 삭제 처리
	@PostMapping("/deleteCinema")
	@ResponseBody
	public String deleteCinema(@RequestParam("c_num") long c_num) {
		adminService.deleteCinema(c_num);
		log.debug("<<영화관 삭제완료>>");
		return "success";

	}
	
	// 포인트조회
	@GetMapping("/admin/adminPayment")
	public String adminPayment(
			@RequestParam(defaultValue = "1") int pageNum,
			@RequestParam(value = "keyword", required = false) String keyword,
			@RequestParam(value = "keyfield", required = false) String keyfield,
			Model model) {
		// keyfield가 없으면 기본값을 설정
		if (keyfield == null || keyfield.isEmpty()) {
			keyfield = "mem_num"; // 기본 검색 필드를 설정합니다.
		}

		// 파라미터를 맵에 추가
		Map<String, Object> map = new HashMap<>();
		map.put("keyword", keyword);
		map.put("keyfield", keyfield);

		// 전체, 검색 레코드 수
		int count = adminService.selectPointRowCount(map);
		

		// 페이지 처리
		PagingUtil page = new PagingUtil(keyfield, keyword, pageNum, count, 10, 10, "adminPayment");

		List<PointVO> list = null; 
		if (count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());

			list = adminService.selectPoint(map); 
		}

		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("page", page.getPage());

		return "adminPayment";

	}
	
	// 결제 환불 처리
	@PostMapping("/refundPoint")
	@ResponseBody
	public String refundPoint(@RequestParam("mem_num") long mem_num,@Param("ph_num") long ph_num, @Param("ph_point") long ph_point, @Param("ph_payment") String ph_payment) {
		adminService.refundPoint(ph_num, mem_num, ph_point, ph_payment);
		log.debug("<<포인트 환불완료>>");
		return "success";
	}

	//문의
	@GetMapping("/admin/adminConsult")
	public String adminConsult(
			@RequestParam(defaultValue = "1") int pageNum,
			@RequestParam(value = "keyword", required = false) String keyword,
			@RequestParam(value = "keyfield", required = false) String keyfield,
			Model model) {
		// keyfield가 없으면 기본값을 설정
		if (keyfield == null || keyfield.isEmpty()) {
			keyfield = "mem_num"; // 기본 검색 필드를 설정합니다.
		}
		
		// 파라미터를 맵에 추가
		Map<String, Object> map = new HashMap<>();
		map.put("keyword", keyword);
		
		map.put("keyfield", keyfield);
		
		// 전체, 검색 레코드 수
		int count = adminService.selectConsultRowCount(map);

		// 페이지 처리
		PagingUtil page = new PagingUtil(keyfield, keyword, pageNum, count, 10, 10, "adminConsult");
		List<ConsultVO> list = null; 
		if (count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());

			list = adminService.selectConsultList(map);
		}

		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("page", page.getPage());
 
		return "adminConsult";

	}
	// 문의 답변 폼 호출
	@GetMapping("/admin/adminAnswer")
	public String updateAnswerForm(ConsultVO consultVO){
		return "adminAnswer";
	}
	// 문의 답변 처리
	@PostMapping("/adminAnswer")
	@ResponseBody
	public String updateAnswer(@Param("consult_num") long conslut_num) {
		adminService.updateAnswer(conslut_num);
		log.debug("<<답변 완료>>");
		return "success";
	}
	
}


