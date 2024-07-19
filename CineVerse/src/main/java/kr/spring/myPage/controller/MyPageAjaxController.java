package kr.spring.myPage.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.assignment.service.AssignService;
import kr.spring.assignment.vo.AssignFavVO;
import kr.spring.assignment.vo.AssignVO;
import kr.spring.board.service.BoardService;
import kr.spring.board.vo.BoardBookmarkVO;
import kr.spring.board.vo.BoardFavVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.movie.service.MovieService;
import kr.spring.movie.vo.MovieBookMarkVO;
import kr.spring.myPage.service.MyPageService;
import kr.spring.myPage.service.MyPageService2;
import kr.spring.myPage.vo.AddressVO;
import kr.spring.myPage.vo.MyPageVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MyPageAjaxController {
	@Autowired
	MyPageService mypageService;

	@Autowired
	MyPageService2 mypageService2;
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	AssignService assignService;
	
	@Autowired
	MovieService movieService;
	
	@PostMapping("/myPage/updateMyPhoto")
	@ResponseBody
	public Map<String, String> processProfile(MyPageVO myPageVO, HttpSession session) {
		Map<String, String> mapAjax = new HashMap<>();
		MemberVO user = (MemberVO) session.getAttribute("user");
		if (user == null) {
			mapAjax.put("result", "logout");
		} else {
			myPageVO.setMem_num(user.getMem_num());
			mypageService.updateProfile(myPageVO);

			// 세션에 업데이트된 프로필 사진 저장
			user.setPhoto(myPageVO.getPhoto());
			user.setPhoto_name(myPageVO.getPhoto_name());
			session.setAttribute("user", user);

			log.debug("<< 프로필 사진 업데이트 성공 >> : " + user.getPhoto_name());

			mapAjax.put("result", "success");
		}

		return mapAjax;
	}

	
	//배송지 삭제
	@PostMapping("/myPage/deleteAddress")
	@ResponseBody
	public Map<String, Object> deleteAddress(long a_num, HttpSession session) {
	    log.debug("<<배송지 삭제 - a_num>> : " + a_num);
	    Map<String, Object> mapJson = new HashMap<String, Object>();
	    MemberVO user = (MemberVO) session.getAttribute("user");
	    AddressVO address = mypageService2.selectOrder(a_num);
	    if (user == null) {
	        mapJson.put("result", "logout");
	    } else if(address != null){
	    	mypageService2.updateAddressStatus(a_num);
	    	mapJson.put("result", "success");
	    } else {
	    	mypageService2.deleteAddress(a_num);
	    	mapJson.put("result", "success");
	    }
	    
	    return mapJson;
	}
	
	
	//양도/교환 북마크 삭제
	@PostMapping("/myPage/deleteABoardBookMark")
	@ResponseBody
	public Map<String, Object> deleteABoardBookMark(long ab_num,long mem_num,HttpSession session){
		log.debug("<<양도/교환 북마크 삭제 - ab_num>> : " + ab_num);
		Map<String, Object> mapJson = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		if(user == null) {
			mapJson.put("result", "logout");
		}else if(user.getMem_num() != mem_num) {
			mapJson.put("result", "wrongAccess");
		}else{
			// AssignFavVO 객체 생성 및 설정
	        AssignFavVO fav = new AssignFavVO();
	        fav.setAb_num(ab_num);
	        fav.setMem_num(mem_num);
			
	        assignService.ab_deleteFav(fav);
			mapJson.put("result", "success");
		}
		return mapJson;
	}
	
	//게시글 북마크
	@PostMapping("/myPage/deleteCBoardBookMark")
	@ResponseBody
	public Map<String, Object> deleteCBoardBookMark(BoardBookmarkVO board,HttpSession session){
		log.debug("<<커뮤니티 북마크 삭제>> : " + board.getCb_num() + ", mem_num: " + board.getMem_num());
		Map<String, Object> mapJson = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		if(user == null) {
			mapJson.put("result", "logout");
		}else if(user.getMem_num() != board.getMem_num()) {
			mapJson.put("result", "wrongAccess");
		}else {
			boardService.deleteBM(board);
			mapJson.put("result", "success");
		}
		return mapJson;
	}
	
	//게시글 좋아요
	@PostMapping("/myPage/deleteCboardFav")
	@ResponseBody
	public Map<String, Object> deleteCBoardFav(BoardFavVO board, HttpSession session) {
	    log.debug("<<커뮤니티 좋아요 삭제>> : " + board.getCb_num() + ", mem_num: " + board.getMem_num());
	    Map<String, Object> mapJson = new HashMap<String, Object>();
	    MemberVO user = (MemberVO) session.getAttribute("user");

	    if (user == null) {
	        mapJson.put("result", "logout");
	    } else if (user.getMem_num() != board.getMem_num()) {
	        mapJson.put("result", "wrongAccess");
	    } else {
	    	//board.setMem_num(user.getMem_num());
	        boardService.deleteFav(board);
	        mapJson.put("result", "success");
	    }
	    return mapJson;
	}


	//기대되는 영화
	@PostMapping("/myPage/deleteMovieBookMark")
	@ResponseBody
	public Map<String, Object> deleteMovieBookMark(MovieBookMarkVO bookMark,HttpSession session){
		log.debug("<<찜영화 삭제 - m_code>> : " + bookMark.getM_code());
		Map<String, Object> mapJson = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		if(user==null) {
			mapJson.put("result", "logout");
		}else if(user.getMem_num()!=bookMark.getMem_num()) {
			mapJson.put("result", "wrongAccess");
		}else {
			movieService.deleteBookMark(bookMark);
			mapJson.put("result", "success");
		}
		return mapJson;
	}
	
	
}
