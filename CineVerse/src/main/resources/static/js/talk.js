$(function() {
    let message_socket;

    function connectWebSocket() {
        message_socket = new WebSocket('ws://localhost:8000/message-ws');

        message_socket.onopen = function(evt) {
            console.log('웹소켓 연결 성공');
            if ($('#talkDetail').length == 1) {
                message_socket.send('msg');
            }
        };

        message_socket.onmessage = function(evt) {
            let data = evt.data;
            if ($('#talkDetail').length == 1 && data.substring(0, 3) == 'msg') {
                selectMsg();
            }
        };

        message_socket.onclose = function(evt) {
            console.log('웹소켓 연결이 종료되었습니다:', evt);
        };

        message_socket.onerror = function(evt) {
            console.error('웹소켓 오류 발생:', evt);
        };
    }

function openChatWindow() {
    var button = document.querySelector('.ass-chatBtn');
    var abnum = button.getAttribute('data-abnum');
    var abmemnum = button.getAttribute('data-abmemnum');
    var usernum = button.getAttribute('data-usernum');

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
                window.open('/talk/talkDetail?talkroom_num=' + talkRoomNum, '_blank', 'width=800,height=680');
                connectWebSocket();

                if (param.messages && param.messages.length > 0) {
                    $('#chatting_message').empty();
                    let chat_date = '';
                    $(param.messages).each(function(index, item) {
                        let output = '';
                        if (chat_date != item.chat_date.split(' ')[0]) {
                            chat_date = item.chat_date.split(' ')[0];
                            output += '<div class="date-position"><span>' + chat_date + '</span></div>';
                        }
                        if (item.message.indexOf('@{member}@') >= 0) {
                            output += '<div class="member-message">' + (item.message ? item.message.substring(0, item.message.indexOf('@{member}@')) : '') + '</div>';
                        } else {
                            if (item.mem_num == param.user_num) {
                                output += '<div class="from-position">';
                                output += '<div class="space-message">';
                                output += '<div class="read_count">' + (item.read_count ? item.read_count : '') + '</div>';
                                output += '<div class="item">';
                                output += ' <span>' + (item.message ? item.message.replace(/\r\n/g, '<br>').replace(/\r/g, '<br>').replace(/\n/g, '<br>') : '') + '</span>';
                                output += '</div>';
                                output += '</div>';
                                output += '</div><div class="space-clear"></div>';
                            } else {
                                output += '<div class="to-position">';
                                output += '<div class="profile-image">';
                                output += '<img src="../myPage/viewProfile?mem_num=' + (item.mem_num ? item.mem_num : '') + '" width="40" height="40" class="my-photo">';
                                output += '</div>';
                                output += '<div class="space-message2">';
                                output += '<div class="read_count">' + (item.read_count ? item.read_count : '') + '</div>';
                                output += '<div class="member-id">' + (item.mem_id ? item.mem_id : '') + '</div>';
                                output += '<div class="item">';
                                output += ' <span>' + (item.message ? item.message.replace(/\r\n/g, '<br>').replace(/\r/g, '<br>').replace(/\n/g, '<br>') : '') + '</span>';
                                output += '</div>';
                                output += '</div>';
                                output += '</div><div class="space-clear"></div>';
                            }
                        }
                        $('#chatting_message').append(output);
                        if ($('#chatting_message').length && $('#chatting_message')[0].scrollHeight) {
                            $('#chatting_message').scrollTop($("#chatting_message")[0].scrollHeight);
                        }
                    });
                }
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
                console.log('AJAX 응답:', param);

                if (param.result == 'logout') {
                    alert('로그인 후 사용하세요!');
                    if (message_socket) {
                        message_socket.close();
                    }
                } else if (param.result == 'success') {
                    $('#chatting_message').empty();
                    let chat_date = '';
                    $(param.list).each(function(index, item) {
                        console.log('메시지 아이템:', item);

                        let output = '';
                        if (chat_date != item.chat_date.split(' ')[0]) {
                            chat_date = item.chat_date.split(' ')[0];
                            output += '<div class="date-position"><span>' + chat_date + '</span></div>';
                        }
                        if (item.message.indexOf('@{member}@') >= 0) {
                            output += '<div class="member-message">' + (item.message ? item.message.substring(0, item.message.indexOf('@{member}@')) : '') + '</div>';
                        } else {
                            if (item.mem_num == param.user_num) {
                                output += '<div class="from-position">';
                                output += '<div class="space-message">';
                                output += '<div class="read_count">' + (item.read_count ? item.read_count : '') + '</div>';
                                output += '<div class="item">';
                                output += ' <span>' + (item.message ? item.message.replace(/\r\n/g, '<br>').replace(/\r/g, '<br>').replace(/\n/g, '<br>') : '') + '</span>';
                                output += '</div>';
                                output += '</div>';
                                output += '</div><div class="space-clear"></div>';
                            } else {
                                output += '<div class="to-position">';
                                output += '<div class="profile-image">';
                                output += '<img src="../myPage/viewProfile?mem_num=' + (item.mem_num ? item.mem_num : '') + '" width="40" height="40" class="my-photo">';
                                output += '</div>';
                                output += '<div class="space-message2">';
                                output += '<div class="member-id">' + (item.mem_id ? item.mem_id : '') + '</div>';
                                output += '<div class="item">';
                                output +=  ' <span>' + (item.message ? item.message.replace(/\r\n/g, '<br>').replace(/\r/g, '<br>').replace(/\n/g, '<br>') : '') + '</span>';
                                output += '</div>';
                                output += '</div>';
                                output += '</div><div class="space-clear"></div>';
                            }
                        }
                        $('#chatting_message').append(output);
                        if ($('#chatting_message').length && $('#chatting_message')[0].scrollHeight) {
                            $('#chatting_message').scrollTop($("#chatting_message")[0].scrollHeight);
                        }
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
                    $('#message').val('');
                    selectMsg();
                } else if (param.result == 'wrongAccess') {
                    alert('타인의 채팅방에 메시지를 작성할 수 없습니다.');
                } else {
                    alert('등록시 오류 발생');
                }
            },
            error: function() {
                alert('네트워크 오류 발생');
            }
        });

        event.preventDefault();
    });

    $('.ass-chatBtn').click(function() {
        openChatWindow();
    });

    if ($('#talkDetail').length == 1) {
        connectWebSocket();
        selectMsg();
    }
    
    
     // 대화 종료 버튼 클릭 이벤트 처리
    $('#delete_talkroom').click(function() {
        var talkroom_num = new URLSearchParams(window.location.search).get('talkroom_num');
        
        if (confirm('대화방 삭제시 복구 불가능합니다. 정말 삭제하시겠습니까?')) {
        $.ajax({
            url: '/talk/delete',
            type: 'post',
            dataType: 'json',
            data: { talkroom_num: talkroom_num },
            success: function(param) {
                if (param.result == 'success') {
                    alert('대화방이 삭제되었습니다.');
                    window.close();
                    window.location.href = '/talk/chatList';
                } else if (param.result == 'logout') {
                    alert('로그인 후 사용 가능합니다.');
                    window.close();
                } else if (param.result == 'not_member') {
                    alert('대화방 멤버가 아닙니다.');
                     window.close(); 
                } else {
                    alert('대화방 삭제에 실패했습니다.');
                }
            },
            error: function() {
                alert('네트워크 오류가 발생했습니다.');
            }
        });
        
        }
    });
    
     // 채팅방 이름 변경 버튼 클릭 이벤트 처리
    $('#change_name').click(function() {
        var chatroomNameSpan = $('#chatroom_name');
        var currentName = chatroomNameSpan.text();

        // 기존 span을 숨기고 input을 추가
        chatroomNameSpan.hide();
        $(this).hide();

        var editNameInput = $('<input>', {
            type: 'text',
            id: 'edit_name',
            value: currentName,
            class: 'form-control',
            style: 'display: inline;'
        });

        var saveNameBtn = $('<input>', {
            type: 'button',
            value: '저장',
            id: 'save_name',
            class: 'btn btn-primary',
            style: 'display: inline; margin-left: 5px; font-size:0.7em; font-weight: 800;'
        });

        var cancelNameBtn = $('<input>', {
            type: 'button',
            value: '취소',
            id: 'cancel_name',
            class: 'btn btn-secondary',
            style: 'display: inline; margin-left: 5px;'
        });

        chatroomNameSpan.after(editNameInput);
        editNameInput.after(saveNameBtn);
        saveNameBtn.after(cancelNameBtn);

        // 저장 버튼 클릭 이벤트 처리
        $('#save_name').click(function() {
            var newName = $('#edit_name').val().trim();
            if (newName) {
                $.ajax({
                    url: '/talk/updateName',
                    type: 'POST',
                    dataType: 'json',
                    data: {
                        talkroom_num: $('#talkroom_num').val(),
                        room_name: newName
                    },
                    success: function(param) {
                        if (param.result == 'success') {
                            chatroomNameSpan.text(newName).show();
                            $('#edit_name').remove();
                            $('#save_name').remove();
                            $('#cancel_name').remove();
                            $('#change_name').show();
                        } else if(param.result == 'logout'){
							alert('로그인 후 사용 가능합니다.');
                   		 	window.close();
						} else if(param.result == 'not_member'){
							alert('대화방 멤버가 아닙니다.');
                     		window.close(); 
						} else {
                            alert('채팅방 이름 변경에 실패했습니다.');
                        }
                    },
                    error: function() {
                        alert('네트워크 오류가 발생했습니다.');
                    }
                });
            } else {
                alert('새로운 채팅방 이름을 입력하세요.');
            }
        });

        // 취소 버튼 클릭 이벤트 처리
        $('#cancel_name').click(function() {
            $('#edit_name').remove();
            $('#save_name').remove();
            $('#cancel_name').remove();
            chatroomNameSpan.show();
            $('#change_name').show();
        });
    });
 
    
});
