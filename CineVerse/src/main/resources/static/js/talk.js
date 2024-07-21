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
                                output += '<div class="profile-image">';
                                output += '<img src="../myPage/viewProfile?mem_num=' + (item.mem_num ? item.mem_num : '') + '" width="40" height="40" class="my-photo">';
                                output += '</div>';
                                output += '<div class="space-message">';
                                output += '<div class="member-id">' + (item.mem_id ? item.mem_id : '') + '</div>';
                                output += '<div class="item">';
                                output += (item.read_count ? item.read_count : '') + ' <span>' + (item.message ? item.message.replace(/\r\n/g, '<br>').replace(/\r/g, '<br>').replace(/\n/g, '<br>') : '') + '</span>';
                                output += '</div>';
                                output += '</div>';
                                output += '</div><div class="space-clear"></div>';
                            } else {
                                output += '<div class="to-position">';
                                output += '<div class="profile-image">';
                                output += '<img src="../myPage/viewProfile?mem_num=' + (item.mem_num ? item.mem_num : '') + '" width="40" height="40" class="my-photo">';
                                output += '</div>';
                                output += '<div class="space-message">';
                                output += '<div class="member-id">' + (item.mem_id ? item.mem_id : '') + '</div>';
                                output += '<div class="item">';
                                output += (item.read_count ? item.read_count : '') + ' <span>' + (item.message ? item.message.replace(/\r\n/g, '<br>').replace(/\r/g, '<br>').replace(/\n/g, '<br>') : '') + '</span>';
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
                                output += '<div class="from-position">' + (item.mem_id ? item.mem_id : '') + '<div>';
                            } else {
                                output += '<div class="to-position">';
                                output += '<div class="space-photo">';
                                output += '<img src="../myPage/viewProfile?mem_num=' + (item.mem_num ? item.mem_num : '') + '" width="40" height="40" class="my-photo">';
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
});
