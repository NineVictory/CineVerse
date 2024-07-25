package kr.spring.assignment.controller;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.assignment.service.AssignService;
import kr.spring.assignment.vo.AssignReportVO;
import kr.spring.assignment.vo.AssignVO;
import kr.spring.board.vo.BoardVO;
import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.FileUtil;
import kr.spring.util.FileUtil2;
import kr.spring.util.PagingUtil;
import kr.spring.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class AssignBoardController {

	@Autowired
	private AssignService assignService;
	
	@Autowired
	private MemberService memberService;
	
	//자바빈(VO) 초기화
	@ModelAttribute
	public AssignVO initCommand() {
		return new AssignVO();
	}
	
	//자바빈(VO) 초기화
	@ModelAttribute
	public AssignReportVO initCommand2() {
		return new AssignReportVO();
	}
	
	/*====================
	 *양도게시판 글작성
	 =====================*/
	@GetMapping("/assignboard/write")
	public String assignform() {
		return "assignWrite";
	}
		
	@PostMapping("/assignboard/write")
	public String submit(@Valid AssignVO assignVO, BindingResult result,
	                     HttpServletRequest request, HttpSession session, Model model,
	                     @RequestParam("ab_upload") MultipartFile ab_upload) throws IOException {
	    log.debug("<<양도글 등록>> : " + assignVO);

	    // 유효성 체크 결과 오류가 있으면 폼 호출
	    if (result.hasErrors()) {
	        return assignform();
	    }
	    if (ab_upload == null || ab_upload.isEmpty()) {
	        result.rejectValue("ab_upload", "error.ab_upload", "파일은 필수 선택입니다.");
	        return "assignWrite";
	    }

	    // 회원번호 셋팅
	    MemberVO vo = (MemberVO) session.getAttribute("user");
	    assignVO.setMem_num(vo.getMem_num());

	    // IP 셋팅
	    assignVO.setAb_ip(request.getRemoteAddr());

	    // 파일 업로드 처리
	    assignVO.setAb_filename(FileUtil.createFile(request,ab_upload));
	    
	    /*if (files != null && !files.isEmpty()) {
	        List<String> filenames = new ArrayList<>();
	        long totalSize = 0;

	        for (MultipartFile file : files) {
	            if (!file.isEmpty()) {
	                String filename = FileUtil2.createFile(request, file);
	                filenames.add(filename);
	                totalSize += file.getSize();
	                log.debug(filename+"**********");
	            }
	        }

	        String filenamesString = String.join(",", filenames);
	        assignVO.setAb_filenames(filenamesString); // 파일명을 저장할 필드에 설정
	        log.debug("파일 전체 크기: " + totalSize + " bytes");
	    } else {
	        // 파일을 업로드하지 않은 경우 처리
	        assignVO.setAb_filenames(null);
	        log.debug("파일을 업로드하지 않았습니다.");
	    }*/

	    //글쓰기
	    assignService.ab_insertBoard(assignVO);

	    // View 메시지 처리
	    model.addAttribute("message", "성공적으로 글이 등록되었습니다.");
	    model.addAttribute("url", request.getContextPath() + "/assignboard/list");
	    return "common/resultAlert";
	}

	
	/*====================
	 *양도게시판 목록
	 =====================*/
	@GetMapping("/assignboard/list")
	public String getList(@RequestParam(defaultValue="1") int pageNum,
						  @RequestParam(defaultValue="1") int order,
						  String keyfield, String keyword, Model model) {
		log.debug("<<게시판 목록 - order>> : " + order);
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		//전체, 검색 레코드수
		int count = assignService.ab_selectRowCount(map);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield,keyword,pageNum,count,10,10,"list");
		List<AssignVO> list = null;
		if(count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = assignService.ab_selectList(map);
		}
		
		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("page", page.getPage());
			
		return "assignList";
	}
	
	/*====================
	 *양도게시판 글상세
	 =====================*/
	@GetMapping("/assignboard/detail")
	public ModelAndView process(long ab_num, HttpSession session) {
		log.debug("<<양도게시판 글 상세 - ab_num>> : " + ab_num);
		
		//해당 글의 조회수 증가
		assignService.ab_updateHit(ab_num);
		
		AssignVO assign = assignService.ab_selectBoard(ab_num);
		
		ModelAndView modelAndView = new ModelAndView("assignView");
		
		MemberVO user = (MemberVO)session.getAttribute("user");

		modelAndView.addObject("user", user);
		
		
		log.debug("<<assign.getAb_filename()*****************>>: " + assign.getAb_filename());
		/*if(assign.getAb_filenames() != null) {
			String[] filenamesArray = assign.getAb_filenames().split(",");
			modelAndView.addObject("filenames", filenamesArray);
			log.debug("<<filenames*****************>>" + filenamesArray[0]);
		}*/
		//제목에 태그를 허용하지 않음
		assign.setAb_title(StringUtil.useNoHTML(assign.getAb_title()));
		//내용에 태그를 허용하지 않으면서 줄바꿈 처리
		//assign.setAb_content(StringUtil.useBrNoHTML(assign.getAb_content()));
		
		modelAndView.addObject("assign", assign);
		
		return modelAndView;
	}
	
	
	/*====================
	 *양도글 신고
	 =====================*/
	
	//양도글 신고폼
	@GetMapping("/assignboard/reportForm")
	public String reportForm() {
		
		return "assignReportForm";
	}
	
	//신고폼 데이터 처리
	@PostMapping("/assignboard/submitAssignReport")
	public String submitReport(AssignReportVO assignReport, BindingResult result, Model model) {
		if(result.hasErrors()) {
			return "assignReportForm";
		}
		
		assignService.processReport(assignReport);
		model.addAttribute("message","신고가 접수되었습니다.");
		return "/common/resultAlert2";
	}
	
	
	
	
	/*====================
	 *양도글 수정
	 =====================*/
	//수정 폼 호출
	@GetMapping("/assignboard/update")
	public String formUpdate(long ab_num, Model model) {
		AssignVO assignVO = assignService.ab_selectBoard(ab_num);
		model.addAttribute("assignVO", assignVO);
		log.debug("상품상태>> " + assignVO.getAb_item_status());
		log.debug("상품내용>> " + assignVO.getAb_content());
		log.debug("상품가격>> " + assignVO.getAb_price());
		/*if(assignVO.getAb_filenames() != null) {
			String[] filenamesArray = assignVO.getAb_filenames().split(",");
			model.addAttribute("ab_filenames", filenamesArray);
			log.debug(filenamesArray[0]);
		}*/
		
		return "assignModify";
	}
	
	//수정 폼에서 전송된 데이터 처리
	@PostMapping("/assignboard/update")
	public String submitUpdate(@Valid AssignVO assignVO, BindingResult result, Model model, 
								HttpServletRequest request, @RequestParam("ab_upload") List<MultipartFile> files) throws IllegalStateException, IOException {
		log.debug("<<양도글 수정>> : " + assignVO);
		
		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			AssignVO vo = assignService.ab_selectBoard(assignVO.getAb_num());
			assignVO.setAb_filename(vo.getAb_filename());
			return "assignModify";
		}
		//ip 셋팅
		assignVO.setAb_ip(request.getRemoteAddr());
		
		// 파일 업로드 처리
	    assignVO.setAb_filename(FileUtil.createFile(request,assignVO.getAb_upload()));

	    
	    /*if (files != null && !files.isEmpty()) {
	        List<String> filenames = new ArrayList<>();
	        long totalSize = 0;

	        for (MultipartFile file : files) {
	            if (!file.isEmpty()) {
	                try {
	                    String filename = FileUtil2.createFile(request, file);
	                    filenames.add(filename);
	                    totalSize += file.getSize();
	                    log.debug("*** " + filename + " **********");
	                } catch (IOException e) {
	                    log.error("파일 업로드 중 오류 발생: " + file.getOriginalFilename(), e);
	                }
	            } else {
	                log.debug("빈 파일이 업로드 시도됨: " + file.getOriginalFilename());
	            }
	        }

	        String filenamesString = String.join(",", filenames);
	        assignVO.setAb_filenames(filenamesString); // 파일명을 저장할 필드에 설정
	        log.debug("파일 전체 크기: " + totalSize + " bytes");
	    } else {
	        // 파일을 업로드하지 않은 경우 처리
	        assignVO.setAb_filenames(null);
	        log.debug("파일을 업로드하지 않았습니다.");
	    }*/
				
		/*
		 * List<String> filenames = new ArrayList<>(); for (MultipartFile file : files)
		 * { if (!file.isEmpty()) { String filename = FileUtil2.createFile(request,
		 * file); filenames.add(filename); } }
		 */
		/*
		 * String filenamesString = String.join(",", filenames);
		 * assignVO.setAb_filenames(filenamesString);
		 */
		
		//글 수정
		assignService.ab_updateBoard(assignVO);
		
		//View에 표시할 메시지
		model.addAttribute("message", "글 수정 완료");
		model.addAttribute("url", request.getContextPath() + "/assignboard/detail?ab_num=" + assignVO.getAb_num());
		return "common/resultAlert";
	}
	
	/*====================
	 *양도글 글삭제
	 =====================*/
	@GetMapping("/assignboard/delete")
	public String submitDelete(long ab_num, HttpServletRequest request) {
		log.debug("<<양도글 삭제 - ab_num>> : " + ab_num);
		
		AssignVO db_assign = assignService.ab_selectBoard(ab_num);
		
		//글 삭제
		assignService.ab_deleteBoard(ab_num);
		
		if(db_assign.getAb_filename() != null) {
			
			/*String[] filenamesArray = db_assign.getAb_filenames().split(",");

			// 배열을 리스트로 변환 (선택사항) List<String> filenamesList =
			Arrays.asList(filenamesArray);
			
			//파일 삭제
			for (String filename : filenamesArray) {
				FileUtil2.removeFile(request, filename);
			}

			//파일 삭제 FileUtil2.removeFile(request, db_assign.getAb_filenames());*/
			
			FileUtil.removeFile(request, db_assign.getAb_filename());
		}
		
		return "redirect:/assignboard/list";
	}
	
	
}
