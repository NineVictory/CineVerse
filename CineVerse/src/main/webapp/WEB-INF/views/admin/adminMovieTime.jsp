<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- include ckeditor js -->
<script src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>
<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function() {
    /* const myForm = document.getElementById('insert_form');
    //이벤트 연결
    myForm.onsubmit = function() {
        const radioGroups = [
            document.querySelectorAll('input[name="m_status"]:checked'),
        ];

        for (let group of radioGroups) {
            if (group.length < 1) {
                alert('영화 상영여부는 필수 ');
                return false;
            }
        } */

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
    };
});
</script>


<div class="page-container">
	<h2>상영 시간 등록</h2>
	<div class="insert_movie_time">
		<form action="insertMovieTime" method="post" enctype="multipart/form-data" id="insert_form"> 
			<ul>
				<li>	
					<label for="mt_date">날짜</label>
					<input type="date" name="mt_date" id="mt_date" class="input-check">
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
						<!-- 서버에서 가져온 극장 리스트를 라디오 버튼으로 출력 -->
						<c:forEach items="${cinemaList}" var="cinema">
							<label>
								<input type="radio" name="c_num" value="${cinema.c_num}" required>
								${cinema.c_location} 극장
							</label>
						</c:forEach>
					</fieldset>
				</li> 
			</ul>
			<div class="btn_display_set">
				<input type="submit" value="등록" id="submit_btn">
			</div>
		</form>
	</div>
</div>



<!-- 상품 등록 끝 -->