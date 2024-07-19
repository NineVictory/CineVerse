package kr.spring.talk.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.talk.service.TalkService;
import kr.spring.talk.vo.TalkMemberVO;
import kr.spring.talk.vo.TalkRoomVO;
import kr.spring.talk.vo.TalkVO;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class TalkController {

	@Autowired
	private TalkService talkService;

	@Autowired
	private MemberService memberService;


	// 전송된 데이터 처리하기
	@PostMapping("/talk/talkRoomWrite")
	public String talkRoomSubmit(TalkRoomVO vo, HttpSession session) {

		log.debug(" << 채팅방 생성 >> : " + vo);
		MemberVO user = (MemberVO) session.getAttribute("user");

		// 채팅 멤버 초대 문구 설정하기
		vo.setTalkVO(new TalkVO());
		vo.getTalkVO().setMem_num(user.getMem_num());
		vo.getTalkVO().setMessage(user.getMem_id() + "님이 " + findMemberId(vo, user) + "님을 초대했습니다. @{member}@");

		talkService.insertTalkRoom(vo);

		return "redirect:/talk/talkList";
	}
	
	// 채팅방 생성하기
	@PostMapping("/talk/createTalkRoom")
    @ResponseBody
    public Map<String, Object> createTalkRoom(@RequestParam("abmemnum") Long abmemnum,
                                              @RequestParam("usernum") Long usernum,
                                              HttpSession session) {
        Map<String, Object> mapAjax = new HashMap<>();
        
        Long[] membersObj = new Long[] {usernum, abmemnum};
        long[] members = new long[membersObj.length];
        for (int i = 0; i < membersObj.length; i++) {
            members[i] = membersObj[i]; // `Long`을 `long`으로 변환
        }
        try {
        	// 현재 세션의 사용자 정보를 가져와서 생성자 정보를 설정
            MemberVO user = (MemberVO) session.getAttribute("user");	// 양도글에서 버튼 누른 사람
            MemberVO abmem = memberService.selectMember(abmemnum);		// 양도글에 글 올린 사람
        	
            // 채팅방 생성 및 채팅방 번호 생성
            TalkRoomVO talkRoomVO = new TalkRoomVO();
            talkRoomVO.setBasic_name(user.getMem_id() + "&" + abmem.getMem_id() ); // 채팅방 기본 이름 설정
            talkRoomVO.setMembers(members); // 채팅방 멤버 설정
            talkRoomVO.setTalkVO(new TalkVO()); // 메시지 객체 초기화
            
            talkRoomVO.setTalkVO(new TalkVO());
            talkRoomVO.getTalkVO().setMem_num(usernum);
            talkRoomVO.getTalkVO().setMessage(user.getMem_id() + "님이 " + abmem.getMem_id() + "님을 초대했습니다.");
            
            
            // 채팅방 및 멤버 추가
            talkService.insertTalkRoom(talkRoomVO);

            // 채팅방 번호 가져오기
            Long talkRoomNum = talkRoomVO.getTalkroom_num();
            
            mapAjax.put("result", "success");
            mapAjax.put("talkRoomNum", talkRoomNum);
        } catch (Exception e) {
            e.printStackTrace();
            mapAjax.put("result", "error");
            mapAjax.put("message", "채팅방 생성에 실패했습니다.");
        }

        return mapAjax;
    }
	
	
//	채팅 메세지 처리하기
	@GetMapping("/talk/talkDetail")
	public String talkDetail(long talkroom_num, Model model, HttpSession session) {

		String chatMember = "";
		String room_name = "";

		MemberVO user = (MemberVO) session.getAttribute("user");

		List<TalkMemberVO> list = talkService.selectTalkMember(talkroom_num);

		for (int i = 0; i < list.size(); i++) {
			TalkMemberVO vo = list.get(i);
			// 로그인한 회원의 채팅방 이름 세팅하기
			if (user.getMem_num() == vo.getMem_num()) {
				room_name = vo.getRoom_name();
			}
			// 채팅 멤버 저장하기
			if (i > 0) { // 하나의 문장으로 만들기 위해for 문의 순서대로 아이디를 뽑아내고 , 도 끊어주는
				chatMember += ",";
			}
			chatMember += list.get(i).getMem_id();
		}

		// 채팅 멤버의 id
		model.addAttribute("chatMember", chatMember);
		// 채팅 멤버의 수 - 리스트의 사이즈로 멤버수를 지정함
		model.addAttribute("chatCount", list.size());
		// 로그인한 회원의 채팅방 이름
		model.addAttribute("room_name", room_name);
		return "talkDetail";
	}

	// 채팅 메세지 전송
	@PostMapping("/talk/writeTalk")
	@ResponseBody
	public Map<String, String> writeTalkAjax(TalkVO vo, HttpSession session) {

		log.debug("<< 채팅 메세지 전송 >> : " + vo);

		Map<String, String> mapAjax = new HashMap<String, String>();
		MemberVO user = (MemberVO) session.getAttribute("user");

		if (user == null) {
			// 로그인이 되지 않은 경우
			mapAjax.put("result", "logout");
		} else {
			// 로그인이 된 경우
			vo.setMem_num(user.getMem_num());
			// 메세지 등록
			talkService.insertTalk(vo);

			mapAjax.put("result", "success");
		}

		return mapAjax;
	}

	// 채팅 메세지 읽기
	@GetMapping("/talk/talkDetailAjax")
	@ResponseBody
	public Map<String, Object> talkDetailAjax(Long talkroom_num, HttpSession session) {

		Map<String, Object> mapJson = new HashMap<String, Object>();
		MemberVO user = (MemberVO) session.getAttribute("user");

		if (user == null) {
			mapJson.put("result", "logout");
		} else {
			Map<String, Long> map = new HashMap<String, Long>();
			map.put("talkroom_num", talkroom_num);
			map.put("mem_num", user.getMem_num());

			List<TalkVO> list = talkService.selectTalkDetail(map);

			mapJson.put("result", "success");
			mapJson.put("list", list);
			mapJson.put("user_num", user.getMem_num());
		}

		return mapJson;
	}

	// 초대한 회원의 id 구하기
	private String findMemberId(TalkRoomVO vo, MemberVO user) {
		String member_id = "";
		long[] members = vo.getMembers();
		for (int i = 0; i < members.length; i++) {
			String temp_id = memberService.selectMember(members[i]).getMem_id();
			// 초대한 사람의 아이디는 제외
			if (!user.getMem_id().equals(temp_id)) {
				member_id += temp_id;
				if (i < members.length - 1)
					member_id += ", ";
			}
		}
		return member_id;
	}

}
