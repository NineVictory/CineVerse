<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>
<script>
    $(document).ready(function() {
        $('#c_num').change(function() {
            let selectedOption = $(this).find('option:selected');
            let c_num = selectedOption.data('cnum');

            $.ajax({
                url: '${pageContext.request.contextPath}/getTheaters',
                type: 'GET',
                data: { c_num: c_num },
                success: function(response) {
                    let theaterSelect = $('#th_num');
                    theaterSelect.empty();
                    theaterSelect.append('<option value="" disabled selected>상영관을 선택해주세요</option>');
                    $.each(response, function(index, theater) {
                        theaterSelect.append('<option value="' + theater.th_num + '">' + theater.th_name + '</option>');
                    });
                },
                error: function() {
                    alert('상영관 목록을 불러오는데 오류가 발생했습니다.');
                }
            });
        });

        $('#insert_form').submit(function(event) {
            var isValid = true;
            var errorMessage = "";

            if ($('#mt_date').val() === "") {
                errorMessage += "날짜를 입력해주세요\n";
                isValid = false;
            }

            if ($('#mt_start').val() === "") {
                errorMessage += "시작 시간을 입력해주세요\n";
                isValid = false;
            }

            if ($('#mt_end').val() === "") {
                errorMessage += "종료 시간을 입력해주세요\n";
                isValid = false;
            }

            if ($('#m_code').val() === "") {
                errorMessage += "영화를 선택해주세요\n";
                isValid = false;
            }

            if ($('#c_num').val() === "") {
                errorMessage += "지점명을 선택해주세요\n";
                isValid = false;
            }

            if ($('#th_num').val() === "") {
                if ($('#c_num').val() === "") {
                    errorMessage += "지점명을 먼저 선택해주세요\n";
                } else {
                    errorMessage += "상영관을 선택해주세요\n";
                }
                isValid = false;
            }

            if (!isValid) {
                alert(errorMessage);
                event.preventDefault();
            }
        });
    });
</script>
<div class="page-container">
    <h2>상영 시간 등록</h2>
    <div class="insert_movie_time">
        <form:form action="adminMovieTime" enctype="multipart/form-data" id="insert_form" modelAttribute="cinemaVO">
            <ul>
                <li>
                    <label for="mt_date">날짜</label>
                    <input type="date" name="mt_date" id="mt_date" class="input-check" required>
                </li>
                <li>
                    <label for="mt_start">시작 시간</label>
                    <input type="text" name="mt_start" id="mt_start" class="input-check" placeholder="숫자만 입력(ex.1600: 오후4시)" required>
                </li>
                <li>
                    <label for="mt_end">종료 시간</label>
                    <input type="text" name="mt_end" id="mt_end" class="input-check" placeholder="숫자만 입력(ex.1600: 오후4시)" required>
                </li>
                <li>
                    <label for="m_code">영화</label>
                    <select name="m_code" id="m_code" class="input-check" required>
                        <option value="" disabled selected>영화를 선택해주세요</option>
                        <c:forEach items="${movieList}" var="movie">
                            <option value="${movie.m_code}" data-mcode="${movie.m_code}">${movie.m_name}</option>
                        </c:forEach>
                    </select>
                </li>
                <li>
                    <label for="c_num">지점명</label>
                    <select name="c_num" id="c_num" class="input-check" required>
                        <option value="" disabled selected>지점명을 선택해주세요</option>
                        <c:forEach items="${cinemaList}" var="cinema">
                            <option value="${cinema.c_num}" data-cnum="${cinema.c_num}">${cinema.c_branch}</option>
                        </c:forEach>
                    </select>
                </li>
                <li>
                    <label for="th_num">상영관</label>
                    <select name="th_num" id="th_num" class="input-check" required>
                        <option value="" disabled selected>상영관을 선택해주세요</option>
                        <!-- 상영관 옵션들 -->
                    </select>
                </li>
            </ul>
            <div class="btn_display_set">
                <input type="submit" value="등록" id="submit_btn">
            </div>
        </form:form>
    </div>
</div>
