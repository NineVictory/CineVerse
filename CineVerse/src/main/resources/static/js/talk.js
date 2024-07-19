function openChatWindow() {
    // data 속성 값을 가져오기
    var button = document.querySelector('.ass-chatBtn');
    var abnum = button.getAttribute('data-abnum');			// 해당하는 양도글의 번호
    var abmemnum = button.getAttribute('data-abmemnum');	// 초대된 사람 - 양도/교환글 작성자
    var usernum = button.getAttribute('data-usernum');		// 초대한 사람 - 양도/교환글 구매하려는 사람
    
  $.ajax({
        url: '/talk/createTalkRoom',
        type: 'post',
        dataType: 'json',
        data: {
            abmemnum: abmemnum,
            usernum: usernum
        },
        success: function(param) {
            if (param.result == 'success') {
                var talkRoomNum = param.talkRoomNum;
                // 여기에서 채팅 창을 여는 로직을 추가하세요.
                alert('채팅방이 성공적으로 생성되었습니다. 채팅방 번호: ' + talkRoomNum);
                 window.open('/talk/talkDetail?talkroom_num=' + talkRoomNum, '_blank','width=800,height=600');
            } else if (param.result == 'error'){
				alert('오류가 발생')
			} else {
                alert('채팅방 생성에 실패했습니다');
            }
        },
        error: function() {
            alert('네트워크 오류가 발생하였습니다.');
        }
    });
}

