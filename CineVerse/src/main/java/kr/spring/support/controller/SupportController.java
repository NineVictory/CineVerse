package kr.spring.support.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.servlet.ModelAndView;

import kr.spring.board.vo.BoardVO;
import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.shop.vo.OrdersVO;
import kr.spring.support.service.SupportService;
import kr.spring.support.vo.ConsultVO;
import kr.spring.util.FileUtil;
import kr.spring.util.PagingUtil;
import kr.spring.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class SupportController {
	
	@Autowired
	private SupportService supportService;
	
	@Autowired
	private MemberService memberService;
	
	@ModelAttribute
	public ConsultVO initCommand() {
		return new ConsultVO();
	}
	
	//고객센터 메인
	@GetMapping("/support/main")
	public String main() {
		return "supportMain";
	}
	
	//자주묻는질문
	@GetMapping("/support/faq")
	public String faqList() {
		return "supportFaq";
	}
	
	//공지/뉴스
	@GetMapping("/support/notice")
	public String noticeList() {
		return "supportNotice";
	}
	
	//1:1문의 리스트
	@GetMapping("/support/consultList")
	public String consultMain(@RequestParam(defaultValue="1") int pageNum,
							  @RequestParam(defaultValue="") Long mem_num,
							  Model model, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		MemberVO member = memberService.selectCheckMember(user.getMem_id());
		
		log.debug("세션 회원번호***************" + user.getMem_id());
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("mem_num", mem_num);
		//전체, 검색 레코드수
		int count = supportService.selectConsultRowCount(map);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(null,null,pageNum,count,15,10,"consultList","&mem_num="+mem_num);
		List<ConsultVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = supportService.selectConsultList(map);
		}
		model.addAttribute("member", member);
		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("page", page.getPage());
		
		return "supportConsultList";
	}
	
	//문의 글상세
	@GetMapping("/support/consultDetail")
	public String process(@RequestParam("consult_num") long consult_num, Model model, HttpServletRequest request, HttpSession session) {
		log.debug("<<consult_num>>*************" + consult_num);
		
		ConsultVO consult = supportService.selectConsult(consult_num);
		log.debug("<<consult>>*************" + consult);
		MemberVO user = (MemberVO)session.getAttribute("user");
		MemberVO member = memberService.selectCheckMember(user.getMem_id());
		if(consult.getMem_num() != member.getMem_num()) {
			model.addAttribute("message", "타인의 문의글은 볼 수 없습니다.");
			model.addAttribute("url", request.getContextPath() + "/support/consultList");
			return "common/resultAlert";
		}
		
		//제목에 태그를 허용하지 않음
		consult.setConsult_title(StringUtil.useNoHTML(consult.getConsult_title()));
		model.addAttribute("user", member);
		model.addAttribute("consult", consult);
	    return "consultDetail";
	}
	
	
	//1:1문의폼
	@GetMapping("/support/consultForm")
	public ModelAndView consultForm(Model model, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		MemberVO db_member = memberService.selectCheckMember(user.getMem_id());
		
		db_member.setMem_phone(db_member.getMem_phone().replaceAll("(\\d{3})(\\d{4})(\\d{4})", "$1-****-$3"));

		List<OrdersVO> order_list = new ArrayList<>();
		order_list = supportService.selectOdNumbersByMemNum(user.getMem_num());
		/* log.debug("주문번호 리스트*******" + order_list); */
		
		ModelAndView modelAndView = new ModelAndView("supportConsultForm");
		model.addAttribute("user", db_member);
		model.addAttribute("orderList", order_list);
		return modelAndView;
	}
	
	@PostMapping("/support/consultForm")
	public String consultSubmit(@Valid ConsultVO consultVO, BindingResult result, Model model, HttpServletRequest request, HttpSession session) throws IllegalStateException, IOException {
		log.debug("<<문의>> : " + consultVO);
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		MemberVO db_member = memberService.selectCheckMember(user.getMem_id());
		db_member.setMem_phone(db_member.getMem_phone().replaceAll("(\\d{3})(\\d{4})(\\d{4})", "$1-****-$3"));
		List<OrdersVO> order_list = new ArrayList<>();
		order_list = supportService.selectOdNumbersByMemNum(user.getMem_num());
		model.addAttribute("user", db_member);
		model.addAttribute("orderList", order_list);
		
		
		if(result.hasErrors()) {
			return "supportConsultForm";
		}
		
		consultVO.setConsult_ip(request.getRemoteAddr());
		log.debug("****************" + consultVO.getOrder_num());
		/*
		 * if("select".equals(consultVO.getOrder_num())) { consultVO.setOrder_num(null);
		 * }
		 */
		consultVO.setConsult_file(FileUtil.createFile(request, 
                consultVO.getC_upload()));
		supportService.insertConsult(consultVO);
		
		model.addAttribute("message", "문의 등록 완료");
		model.addAttribute("url", request.getContextPath() + "/support/consultList");
		return "common/resultAlert";
	}
	
}