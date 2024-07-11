<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="myPageMain_1">
	<div class="myPageMain_photo">
		<img src="${pageContext.request.contextPath}/member/photoView" width="50" height="50" class="my-photo">
	</div>

	<div class="myPageMain_right">
		<div class="myPageMain_information">
			<span class="myPageMain_name">${member.mem_name } 님</span> <span
				class="myPageMain_id">${member.mem_id }</span> <span
				class="myPageMain_nickName">닉네임 : ${member.mem_id }</span> <input type="button"
				value="수정이미지로 변경">
		</div>

		<div class="myPageMain_vip">고객님은 2024년 1월 
		<c:if test="${member.mem_rank==1 }">
			 <b>BASIC</b>
		</c:if>
		<c:if test="${member.mem_rank==2 }">
			 <b>MEMBER</b>
		</c:if>
		<c:if test="${member.mem_rank==3 }">
			<b> REGULAR</b>
		</c:if>
		<c:if test="${member.mem_rank==4 }">
			<b> VIP</b>
		</c:if>
		<c:if test="${member.mem_rank==5 }">
			 <b>VVIP</b>
		</c:if>
		
		 입니다</div>

		<div class="mp_vip_lounge">VIP 라운지</div>
	</div>
</div>


<div class="myPageMain_2">
	<div class="myPage_ticket" onclick="location.href='/myPage/'">
		<!-- 나의 예매 내역 링크 -->
		<div class="mp_ticket">모바일 티켓</div>
		<div class="ticket_content">
			<div class="mypage_movie_name">듄(재개봉,IMAX LASER 2D)</div>
			<div class="main_display">
				<div class="main_movie_info1">
					<div>관람극장</div>
					<div>관람일시</div>
					<div>상영</div>
				</div>
				<div class="main_movie_info2">
					<div class="myPage_bold">
						<a href="#">CGV용산아이파크몰</a>
					</div>
					<div class="myPage_bold">2024.07.06(토) 26:00</div>
					<div class="myPage_bold">IMAX관</div>
				</div>
			</div>
		</div>
	</div>

	<div class="myPage_coupon" onclick="location.href='/myPage/coupon'">
		<!-- 나의 쿠폰 링크 -->
		<div class="mp_coupon">나의 쿠폰</div>
		<div class="coupon_content">
			<span>쿠폰</span><span>${member.coupon_cnt }</span>
		</div>
		<hr size="1" width="90%" class="line">
	</div>

	<div class="myPage_point">
		<!-- 포인트 충전 링크 -->
		<span class="mp_point">CV POINT</span> <span class="my_point_charge" onclick="location.href='/member/pointCharge'">충전</span><br>
		<div class="point_content">
			<span>사용가능한 포인트</span><span class="user_point">${member.point}P</span>
		</div>
		<hr size="1" width="90%" class="line">
		<div class="point_list">
			<a href="#">포인트 내역</a>
		</div>
		<!--마이페이지-구매-포인트충전 링크  -->
	</div>
</div>

