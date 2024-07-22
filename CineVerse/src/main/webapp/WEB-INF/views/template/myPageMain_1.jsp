<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="myPageMain_1">
	<div class="modify_ph">
		<div class="camera" id="photo_btn">
			<img src="${pageContext.request.contextPath}/images/camera.png" width="30">
		</div>
		<div id="photo_choice">
		    <label for="upload" class="custom-file-upload">파일 선택</label>
		    <input type="file" id="upload" accept="image/gif, image/png, image/jpeg">
		    <div class="photo-buttons">
		        <input type="button" value="전송" id="photo_submit">
		        <input type="button" value="취소" id="photo_reset">
		    </div>
		</div>
	</div>
	<div class="myPageMain_photo">
		<img src="${pageContext.request.contextPath}/myPage/photoView" width="50" height="50" class="my-photo">
	</div>
	<div class="myPageMain_right">
		<div class="myPageMain_information">
			<span class="myPageMain_name">${member.mem_name } 님</span> <span class="myPageMain_id">닉네임 :${member.mem_nickName }</span> <span class="myPageMain_nickName">아이디 : ${member.mem_id }</span>
		</div>
		<div class="myPageMain_vip">
			고객님은 2024년 1월
			<c:if test="${member.mem_rank==1 }"><b>BASIC</b></c:if>
			<c:if test="${member.mem_rank==2 }"><b>MEMBER</b></c:if>
			<c:if test="${member.mem_rank==3 }"><b>REGULAR</b></c:if>
			<c:if test="${member.mem_rank==4 }"><b>VIP</b></c:if>
			<c:if test="${member.mem_rank==5 }"><b>VVIP</b></c:if>
			입니다
		</div>
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
			<span>쿠폰</span><span>${member.coupon_cnt}</span>
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
			<a href="/myPage/pointList">포인트 내역</a>
		</div>
		<!--마이페이지-구매-포인트충전 링크  -->
	</div>
</div>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/myPage.profile.js"></script>

<!-- CSS -->
<style>
/* 파일 입력 요소 숨기기 */
#photo_choice input[type="file"] {
    display: none;
}

/* 사용자 정의 파일 선택 버튼 스타일 */
.custom-file-upload {
    display: inline-block;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    background-color: #3F66ED;
    color: #fff;
    cursor: pointer;
    font-size: 14px;
    text-align: center;
    width: 100%;
    margin-bottom: 10px;
    transition: background-color 0.3s;
}

.custom-file-upload:hover {
    background-color: #2C4BB8;
}
#photo_choice {
position: absolute;
    top: 45px;
    left: 55%;
    transform: translateX(-50%);
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    padding: 20px;
    width: 290px;
    text-align: center;
    z-index: 2;
}

.photo-buttons {
    display: flex;
    justify-content: flex-end;
    margin-top: 10px;
}

#photo_choice #photo_reset {
	background-color: var(--red-check-btn);
}

#photo_choice input[type="button"]:hover {
    transform: scale(1.05); 
}

#photo_choice input[type="button"]:focus {
    outline: none;
}


.myPageMain_photo {
    border: 3px solid var(--main-color-strong);
    }

#photo_choice {
	margin-top: 10px; 
	text-align: center;
}
.modify_ph{
	width: 50px;
	height: 50px;
	border-radius: 100%;
	background-color: #3F66ED;
	cursor: pointer;
	position: relative; /* 화면에 고정 */
    top: 60px; /* 화면의 위쪽에서 20px 떨어진 위치에 고정 */
    left: 250px; /* 화면의 왼쪽에서 20px 떨어진 위치에 고정 */
    width: 50px; /* 요소의 너비 설정 */
    height: 50px; /* 요소의 높이 설정 */
    display: flex; /* flexbox로 설정 */
    justify-content: center; /* 수평 중앙 정렬 */
    align-items: center; /* 수직 중앙 정렬 */
    cursor: pointer; /* 커서 설정 */
    z-index: 1; /* z-index를 높여 다른 요소보다 앞에 표시 */
}

.camera {
	line-height: 0;
}

#photo_choice {
	display: none;
	flex-direction: column;
	align-items: center;
}
#photo_choice input[type="button"] {
	width: 70px;
	padding: 5px;
	margin: 2px;
	border: none;
	border-radius: 5px;
	background-color: #3F66ED;
	color: white;
	cursor: pointer;
}
</style>
