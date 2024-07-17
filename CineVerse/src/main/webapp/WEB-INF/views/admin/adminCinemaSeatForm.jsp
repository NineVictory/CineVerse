<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- include ckeditor js -->
<script src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>
<script type="text/javascript">
    document.addEventListener('DOMContentLoaded', function() {
        const myForm = document.getElementById('insert_form');
        // 이벤트 연결
        myForm.onsubmit = function() {
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

    function generateSeats() {
        var rows = parseInt(document.getElementById('rows').value);
        var columns = parseInt(document.getElementById('columns').value);

        var seatForm = document.getElementById('seatForm'); // 좌석을 추가할 부모 요소
        seatForm.innerHTML = ''; // 기존 내용 초기화

        for (var row = 1; row <= rows; row++) {
            for (var col = 1; col <= columns; col++) {
                var seatNum = String.fromCharCode(65 + row - 1) + col; // 좌석 번호 생성 (A1, A2, B1, B2, ...)
                var seatInput = '<div>';
                seatInput += '<label>' + seatNum + '</label>';
                seatInput += '<input type="text" name="seatList[' + (row - 1) * columns + (col - 1) + '].seatNum" value="' + seatNum + '" hidden>';
                seatInput += '<input type="text" name="seatList[' + (row - 1) * columns + (col - 1) + '].seatRow" value="' + String.fromCharCode(65 + row - 1) + '" hidden>';
                seatInput += '<input type="text" name="seatList[' + (row - 1) * columns + (col - 1) + '].seatColumn" value="' + col + '" hidden>';
                seatInput += '<input type="text" name="seatList[' + (row - 1) * columns + (col - 1) + '].seatRank" value="basic">';
                seatInput += '</div>';

                seatForm.innerHTML += seatInput;
            }
        }

        seatForm.innerHTML += '<br><button type="submit">등록</button>';
    }
</script>
<div class="page-container">
    <h2>좌석 등록</h2>
    <div class="insert_seat_form">
        <form:form action="insertSeats" method="post"
            enctype="multipart/form-data" id="insert_form"
            modelAttribute="seatForm">
            
            <label for="branch">지점 선택:</label>
            <select id="branch" name="branchId" onchange="fetchTheaters(this.value)">
                <option value="">지점을 선택하세요</option>
                <c:forEach items="${branches}" var="branch">
                    <option value="${branch.branchId}">${branch.branchName}</option>
                </c:forEach>
            </select>
            <br><br>
            
            <label for="theater">상영관 선택:</label>
            <select id="theater" name="theaterId">
                <!-- 선택된 지점에 따라 동적으로 추가될 상영관 목록 -->
                <c:forEach items="${theaters}" var="theater">
                    <option value="${theater.id}">${theater.name}</option>
                </c:forEach>
            </select>
            <br><br>
            
            <label for="rows">행 수:</label>
            <input type="number" id="rows" name="rows" required>
            <br><br>
            
            <label for="columns">열 수:</label>
            <input type="number" id="columns" name="columns" required>
            <br><br>
            
            <button type="button" onclick="generateSeats()">좌석 생성</button>
            <br><br>
            
            <div id="seatForm"></div>
            
            <!-- 좌석 생성 후 등록 버튼 -->
            <button type="submit">등록</button>
        </form:form>
    </div>
</div>


