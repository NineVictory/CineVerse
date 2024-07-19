$(function() {
    let message_socket; // 웹소켓 식별자

    function connectWebSocket() {
        message_socket = new WebSocket('ws://localhost:8000/message-ws'); // appconfig에서 지정한 식별자로 맞춰주기 message-ws

        message_socket.onopen = function(evt) {
            console.log('채팅 페이지 : 접속' + $('#talkDetail').length);
            if ($('#talkDetail').length == 1) {
                message_socket.send('msg');
            }
        };

        // 서버로부터 메세지를 받으면 호출 되는 함수를 지정한다.
        message_socket.onmessage = function(evt) {
            let data = evt.data;
            if ($('#talkDetail').length == 1 && data.substring(0, 3) == 'msg') {
                selectMsg();
            }
        };

        message_socket.onclose = function(evt) {
            console.log('chat close');
        };

        message_socket.onerror = function(evt) {
            console.error('WebSocket error:', evt);
        };
    }

    function openChatWindow() {
        var button = document.querySelector('.ass-chatBtn');
        var abnum = button.getAttribute('data-abnum'); // 해당하는 양도글의 번호
        var abmemnum = button.getAttribute('data-abmemnum'); // 초대된 사람 - 양도/교환글 작성자
        var usernum = button.getAttribute('data-usernum'); // 초대한 사람 - 양도/교환글 구매하려는 사람

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
                    alert('채팅방이 성공적으로 생성되었습니다. 채팅방 번호: ' + talkRoomNum);
                    window.open('/talk/talkDetail?talkroom_num=' + talkRoomNum, '_blank', 'width=800,height=600');
                    connectWebSocket(); // 웹소켓 생성하기
                } else {
                    alert('채팅방 생성에 실패했습니다');
                }
            },
            error: function() {
                alert('네트워크 오류가 발생하였습니다.');
            }
        });
    }

    function selectMsg() {
    $.ajax({
        url: '../talk/talkDetailAjax',
        type: 'get',
        data: { talkroom_num: $('#talkroom_num').val() },
        dataType: 'json',
        success: function(param) {
            console.log('AJAX 응답:', param); // 응답을 콘솔에 출력

            if (param.result == 'logout') {
                alert('로그인 후 사용하세요!');
                if (message_socket) {
                    message_socket.close();
                }
            } else if (param.result == 'success') {
				
                $('#chatting_message').empty();
                let chat_date = '';
                $(param.list).each(function(index, item) {
                    console.log('메시지 아이템:', item); // 아이템의 내용을 콘솔에 출력

                    let output = '';
                    if (chat_date != item.chat_date.split(' ')[0]) {
                        chat_date = item.chat_date.split(' ')[0];
                        output += '<div class="date-position"><span>' + chat_date + '</span></div>';
                    }
                    if (item.message.indexOf('@{member}@') >= 0) {
                        output += '<div class="member-message">' + (item.message ? item.message.substring(0, item.message.indexOf('@{member}@')) : '') + '</div>';
                    } else {
                        if (item.mem_num == param.user_num) {
                            output += '<div class="from-position">' + (item.mem_id ? item.mem_id : '') + '<div>';
                        } else {
                            output += '<div class="to-position">';
                            output += '<div class="space-photo">';
                            output += '<img src="../member/viewProfile?mem_num=' + (item.mem_num ? item.mem_num : '') + '" width="40" height="40" class="my-photo">';
                            output += '</div><div class="space-message">' + (item.mem_id ? item.mem_id : '');
                        }
                        output += '<div class="item">';
                        output += (item.read_count ? item.read_count : '') + ' <span>' + (item.message ? item.message.replace(/\r\n/g, '<br>').replace(/\r/g, '<br>').replace(/\n/g, '<br>') : '') + '</span>';
                        output += '<div class="align-right">' + (item.chat_date ? item.chat_date.split(' ')[1] : '') + '</div>';
                        output += '</div>';
                        output += '</div><div class="space-clear"></div>';
                        output += '</div>';
                    }
                    $('#chatting_message').append(output);
                    $('#chatting_message').scrollTop($("#chatting_message")[0].scrollHeight);
                });
            } else {
                alert('채팅 메시지 읽기 오류 발생');
                if (message_socket) {
                    message_socket.close();
                }
            }
        },
        error: function() {
            alert('네트워크 오류 발생');
            if (message_socket) {
                message_socket.close();
            }
        }
    });
}


    $('#message').keydown(function(event) {
        if (event.keyCode == 13 && !event.shiftKey) {
            $('#detail_form').trigger('submit');
        }
    });

    $('#detail_form').submit(function(event) {
        if ($('#message').val().trim() == '') {
            alert('메세지를 입력하세요');
            $('#message').val('').focus();
            return false;
        }

        if ($('#message').val().length > 1000) {
            alert('메세지는 1000자까지 입력 가능합니다.');
            return false;
        }

        let form_data = $(this).serialize();

        $.ajax({
            url: '../talk/writeTalk',
            type: 'post',
            data: form_data,
            dataType: 'json',
            success: function(param) {
                if (param.result == 'logout') {
                    alert('로그인 후 사용 가능합니다.');
                    if (message_socket) {
                        message_socket.close();
                    }
                } else if (param.result == 'success') {
                    $('#message').val('').focus();
                    if (message_socket) {
                        message_socket.send('msg');
                    }
                    selectMsg();
                } else {
                    alert('채팅 전송 중 오류가 발생하였습니다.');
                    if (message_socket) {
                        message_socket.close();
                    }
                }
            },
            error: function() {
                alert('네트워크 오류가 발생하였습니다.');
                if (message_socket) {
                    message_socket.close();
                }
            }
        });

        event.preventDefault();
    });
});
