<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- include ckeditor js -->
<script src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>
<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function() {
    const items = document.querySelectorAll('.input-check');
    for (let i = 0; i < items.length; i++) {
        if (items[i].value.trim() == '') {
            const label = document.querySelector('label[for="'+items[i].id+'"]');
            alert(label.textContent + ' 항목은 필수 입력입니다!');
            items[i].value = '';
            items[i].focus();
            return false;
        }
    }
});

$(document).ready(function() {
    $('#m_code').on('input', function() {
        var input = $(this).val().trim();
        if (input.length >= 2) { // 입력 길이가 충분히 길 때만 검색 요청
            $.ajax({
                type: 'GET',
                url: '${pageContext.request.contextPath}/admin/searchMovies', // 실제 검색 처리하는 컨트롤러 경로
                data: { query: input },
                success: function(response) {
                    displaySuggestions(response);
                },
                error: function(xhr, status, error) {
                    console.error('Error:', error);
                }
            });
        } else {
            $('#m_code_suggestions').empty(); // 입력이 충분하지 않을 때는 결과 지우기
        }
    });

    function displaySuggestions(suggestions) {
        var suggestionList = '<ul>';
        suggestions.forEach(function(movie) {
            suggestionList += '<li data-mcode="' + movie.m_code + '">' + movie.m_name + '</li>';
        });
        suggestionList += '</ul>';
        $('#m_code_suggestions').html(suggestionList);

        // 결과 클릭 시 선택
        $('#m_code_suggestions li').on('click', function() {
            var selectedMCode = $(this).attr('data-mcode');
            $('#m_code').val(selectedMCode);
            $('#m_code_suggestions').empty(); // 선택 후 결과 지우기
        });
    }
});
</script>

<div class="page-container">
    <h2>상영 시간 등록</h2>
    <div class="insert_movie_time">
        <form action="${pageContext.request.contextPath}/admin/insertMovieTime" method="post" enctype="multipart/form-data" id="insert_form">
            <ul>
                <li>
                    <label for="mt_date">날짜</label>
                    <input type="date" name="mt_date" id="mt_date" class="input-check" required>
                </li>
                <li>
                    <label for="mt_start">시작 시간</label>
                    <input type="text" name="mt_start" id="mt_start" class="input-check" placeholder="HH:MM" required>
                </li>
                <li>
                    <label for="mt_end">종료 시간</label>
                    <input type="text" name="mt_end" id="mt_end" class="input-check" placeholder="HH:MM" required>
                </li>
        
        		<li>
                    <label for="m_code">영화코드</label>
                    <input type="text" name="m_code" id="m_code" class="input-check" placeholder="영화 코드를 입력하세요" required>
                    <div id="m_code_suggestions"></div>
                </li>
                <li>
                    <label for="c_num">극장번호</label>
                    <input type="text" name="c_num" id="c_num" class="input-check">
                </li>
				        
                <%-- <li>
                    <fieldset>
                        <legend>상영 영화 선택</legend>
                        <!-- 서버에서 가져온 영화 리스트를 라디오 버튼으로 출력 -->
                        <c:forEach items="${movieList}" var="movie">
                            <label>
                                <input type="radio" name="m_code" value="${movie.m_code}" required>
                                ${movie.m_name}
                            </label>
                        </c:forEach>
                    </fieldset>
                </li>
                
                <li>
                    <fieldset>
                        <legend>상영 극장 선택</legend>
                        <!-- 여기에 극장 리스트 추가 -->
                        <!-- 예시: <c:forEach items="${cinemaList}" var="cinema">
                                <label>
                                    <input type="radio" name="c_num" value="${cinema.c_num}" required>
                                    ${cinema.c_location} 극장
                                </label>
                            </c:forEach> -->
                    </fieldset>
                </li>  --%>
            </ul>
            <div class="btn_display_set">
                <input type="submit" value="등록" id="submit_btn">
            </div>
        </form>
    </div>
</div>
