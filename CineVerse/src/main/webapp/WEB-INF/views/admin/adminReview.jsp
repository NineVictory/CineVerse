<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>


<div class="page-container">
<div class = "admin_member">
	<div class = "firstTitle">
		<p id ="title">리뷰 관리</p>
	</div>
		<form id="admin_search">
			<ul>
				<li>
					<select name="keyfield">
						<option value="2">아이디</option>
						<option value="1">상품이름</option>
					</select>
					<input type="search" name="keyword" placeholder="회원 아이디를 입력하세요">
					<input type="submit" value="" class = "search-button" style="background-image: url('${pageContext.request.contextPath}/images/pgh/searchButton.png');">
				</li>
			</ul>
		</form>
    <table class="adminMember-table">
        <thead>
            <tr>
                <th>회원번호</th>
                <th>아이디</th>
                <th>상품 이름</th>
                <th>별점</th>
                <th>내용</th>
                <th>등록일</th>
                <th>삭제</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="review" items="${reviewList}">
                <tr>
                    <td class="mem-data">${review.mem_num}</td>
                    <td class="mem-data">${review.mem_id}</td>
                    <td class="mem-data">${review.p_name}</td>
                    <td class="mem-data">${review.pr_grade}</td>
                    <td class="mem-data">${review.pr_content}</td>
                    <td class="mem-data">${review.pr_reg_date}</td>
                    <td class="button2"><input type="button" value="리뷰 삭제" class="review_del" data-prNum="${review.pr_num}"></td>
                    
                    
                </tr>
            </c:forEach>
            
        </tbody>
    </table>
</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
    $('.review_del').click(function() {
        const choice = confirm('삭제하시겠습니까?');
        if (choice) {
            const prNum = $(this).attr('data-prNum');
            $.ajax({
                url: 'deleteReview',
                data: { pr_num: prNum }, 
                type: 'post',
                dataType: 'json',
                success: function(param) {
                    if (param.result == 'logout') {
                        alert('로그인 후 사용하세요');
                    } else if (param.result == 'noAdmin') {
                        alert('잘못된 접속입니다.');
                    } else if (param.result == 'success') {
                        alert('성공적으로 리뷰를 삭제했습니다.');
                        window.location.reload(); 
                    } else {
                        alert('리뷰 삭제 오류 발생');
                    }
                },
                error: function() {
                    alert('네트워크 오류 발생');
                }
            });
        }
    });
});
                        </script>