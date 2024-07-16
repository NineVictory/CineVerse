$(function() {
    // 북마크 읽기 (북마크 선택 여부와 선택한 총개수 표시)
    function selectBookMark(m_code) {
        // 서버와 통신
        $.ajax({
            url: 'getbookMark',
            type: 'get',
            data: {m_code: m_code},
            dataType: 'json',
            success: function(param) {
				console.log("북마크 상태:", param);
                displayBookMark(param);
            },
            error: function() {
                alert('네트워크 오류 발생');
            }
        });
    }

    // 북마크 등록/삭제
    $('#output_bookMark').click(function() {
        // 서버와 통신
        $.ajax({
            url: 'writebookMark',
            type: 'post',
            data: {m_code: $('#output_bookMark').attr('data-num')},
            dataType: 'json',
            success: function(param) {
				console.log("북마크 변경 응답:", param);
                if (param.result == 'logout') {
                    alert('로그인 후 북마크를 눌러주세요');
                } else if (param.result === 'success') {
                    displayBookMark(param);
                } else {
                    alert('북마크 등록/삭제 오류 발생');
                }
            },
            error: function() {
                alert('네트워크 오류 발생');
            }
        });
    });

    // 북마크 표시 공통 함수
    function displayBookMark(param) {
        let output;
        if (param.status == 'yesbookMark') {
            output = '../images/heart02.png';
        } else if (param.status == 'nobookMark') {
            output = '../images/heart01.png';
        } else {
            alert('북마크 표시 오류 발생');
        }
        // 문서 객체에 추가
        $('#output_bookMark').attr('src', output);
        $('#output_mfcount').text(param.count);
    }

    // 초기 데이터 표시
    selectBookMark($('#output_bookMark').attr('data-num'));
});
