<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- 마이페이지 시작 -->
<div class="myPage_main">
	<div class="myPage_active">
		<div class="m_except" onclick="location.href='/myPage/expectingMovie'">
			<!-- 아이콘 이미지 -->
			<div>
				<img src="${pageContext.request.contextPath}/images/pmj/expect.png"
					class="test_icon">
			</div>
			<div class="myPageMain_font_b">기대되는 영화</div>
			<div class="myPageMain_font_s">보고싶은 영화들을 미리 담아놓고 싶다면?</div>
		</div>
		<div class="m_watching" onclick="location.href='/myPage/watchedMovie'">
			<!-- 아이콘 이미지 -->
			<div>
				<img src="${pageContext.request.contextPath}/images/pmj/movie.png"
					class="test_icon">
			</div>
			<div class="myPageMain_font_b">내가 본 영화</div>
			<div class="myPageMain_font_s">관람한 영화들을 한번에 모아 보고 싶다면?</div>
		</div>
		<div class="m_review" onclick="location.href='/myPage/review'">
			<!-- 아이콘 이미지 -->
			<div>
				<img src="${pageContext.request.contextPath}/images/pmj/review.png"
					class="test_icon">
			</div>
			<div class="myPageMain_font_b">내가 쓴 평점</div>
			<div class="myPageMain_font_s">관람 후 내 감상평을 적어 추억하고 싶다면?</div>
		</div>
	</div>

	<div class="main_body_reservation">
			<div class="main_resrv"><span class="reserv_font">MY 예매내역</span><span class="main_count">0건</span></div>
		


		<c:if test="${resCnt == 0}"><div class="empty_position">예매한 영화가 존재하기 않습니다.</div></c:if>
		<c:if test="${resCnt > 0}">
		<c:forEach var="res" items="${lastRes}">
		<div class="main_body_reservation">
			<div class="myPageReservation_list"
				onclick="location.href='/myPage/reservation'">
				<div class="mp_reserv">
					<div class="m_movie_photo">
						<img alt="영화1" src="${fn:split(res.m_filename, '|')[0]}"
							onclick="location.href='${pagecontext.request.contextPath}/movie/movieDetail?m_code=${res.m_code}'"
							class="expect_movie_poster" width="150" height="210">
					</div>
					<div class="mpMovie_info">
						<div>
							<span class="mp_movie_number_1">예매번호</span>
							<span class="mp_movie_number_3">${res.user_mb_num}</span>
						</div>
						<div class="mp_movie_title">${res.m_name}</div>

						<div class="reservation_list">
							<div class="reserv_info">
								<div>관람극장</div>
								<div>관람일자</div>
								<div>상영시간</div>
							</div>

							<div class="my_reserv_info">
								<div>CINEVERSE${res.c_branch}</div>
								<div>${res.mt_date}</div>
								<div>${res.mt_start}~${res.mt_end}</div>
							</div>
						</div>
						<hr size="1" width="100%" class="reserv_line">
						<div class="reserv_pay_cancle">
							<div>
								<span class="m_pay">총 결제금액 </span><span class="my_blue_font">${res.mb_price}원</span>
							</div>
							
							<div><!-- class="add_del_btn" -->
								<input type="button" class="m_cancle" data-num="${res.mb_num}" data-mnum="${user.mem_num}" value="삭제">
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		</c:forEach>
	</c:if>










	</div>

	<div class="qna_box">
			<span class="reserv_font">MY QnA</span><span class="main_count">${count}건</span>

		<c:if test="${count == 0}">
			<div class="qna">
				<div class="mpQna">고객님의 1:1 문의내역이 존재하지 않습니다</div>
			</div>
		</c:if>
		<c:if test="${count > 0}">
			<div class="qna">
				<div class="mpQna">
					<c:choose>
						<c:when test="${lastConsult.consult_type == 'inquiry'}">[문의]</c:when>
						<c:when test="${lastConsult.consult_type == 'dissatisfaction'}">[불만]</c:when>
						<c:when test="${lastConsult.consult_type == 'compliment'}">[칭찬]</c:when>
						<c:when test="${lastConsult.consult_type == 'proposal'}">[제안]</c:when>
						<c:when test="${lastConsult.consult_type == 'missing'}">[분실물]</c:when>
						<c:when test="${lastConsult.consult_type == 'exchange'}">[교환/환불]</c:when>
					</c:choose>
					${lastConsult.consult_title}
				</div>
			</div>
		</c:if>
	</div>
</div>
<!-- 마이페이지 끝-->
