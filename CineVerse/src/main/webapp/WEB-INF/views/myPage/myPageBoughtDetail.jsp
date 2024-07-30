<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/product.review.js"></script>
<!-- 굿즈 결제 내역 상세 시작 -->
<div class="myPage_main">

	<div class="reservation_display">
		<span class="myPage_title_re">결제 내역</span>
		<span class="watched_movie"><a href="/myPage/bought" style="color:#fff;">내가 산 굿즈</a></span>
	</div>
	<hr size="1" width="100%" class="wa_line">
	<c:if test="${!empty orderDetail}">
	
	<c:forEach var="od" items="${orderDetail}">
	<div class="reservation_rep">
		<div class="re_movie_number">
			<span class="mp_movie_number_1">결제 번호</span> <span
				class="mp_movie_number_3">${order.od_number}</span>
		</div>
		<div class="reserv_display">
		<!-- 여기도 검은색삐죽... -->
			<div class="wa_photo" style="background:none;">
					<img src="${pagecontext.reuqest.contextPath}/upload/${od.p_filename}"
						alt="결제 내역" width="160" height="160" onclick="location.href='${pageContext.request.contextPath}/shop/shopDetail?p_num=${od.p_num}'">
			</div>
			<div class="reservation_info">
				<div class="reservation_movie_name">
					${od.p_name}
				</div>
				<div class="reservation_infomation">
					<div class="my_reserv_info_1">
						<div>구매일시</div>
						<div>상품금액</div>
						<div>주문수량</div>
					</div>
					<div class="my_reserv_info_2">
						<div>${od.order_date }</div>
						<div>${od.p_price }원</div>
						<div>${od.order_quantity}개</div>
					</div>
					<div class="my_reserv_info_3">
						<div></div>
						<div></div>
						<div></div>
					</div>
					<div class="my_reserv_info_4">
						<div></div>
						<div></div>
						<div></div>
					</div>

				</div>
				<hr size="1" width="100%" class="wa_line">
				<div class="reserv_pay_cancle">
					<div>
						<span class="m_pay">총 상품금액 </span><span class="my_blue_font">${od.p_price*od.order_quantity}원</span>
					</div>
					<div class="my_bought_btn">
						<div>
							<c:if test="${od.order_status==6 && od.od_review_status==1}">
								<span class="my_order_review" data-pnum="${od.p_num}" data-num="${od.od_num}" style="padding:9px;">리뷰쓰기</span>
							</c:if>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</c:forEach>
</c:if>
	<div class="payment_receipt">결제 내역</div>
	<div class="pay_receipt_box">
		<div class="pay_receipt">
			<div class="reservation_pay">총 결제금액</div>
			<div class="reservation_pay_blue_font">
					${order_price}원
					<c:if test="${!empty deli}">
						(배송비 ${deli}원)
					</c:if>
			</div>
		</div>
		<hr size="1" width="100%" class="wa_line">



		<div class="payment_way">
			<div class="pay_way">
				<div class="pay_point">포인트 결제</div>
				<div class="pay_coupon">쿠폰 결제</div>
			</div>
			<div class="pay_way_count">
				<div class="point_count">${point_price}원</div>
				<div class="coupon_count">${coupon_price}원</div>
			</div>
		</div>
	</div>


	<div></div>
	<div></div>

</div>




<div id="mate_review" style="display:none;">
    <div class="mate_review_window">
        
		
        <div class="content">
            <div class="mate_review_profile">
                <h2>상품은 만족하셨나요?</h2>
            </div>
			<div class="star">
				<img src="${pageContext.request.contextPath}/images/cje/star_no.png" class="reStar" id="star1">
				<img src="${pageContext.request.contextPath}/images/cje/star_no.png" class="reStar" id="star2">
				<img src="${pageContext.request.contextPath}/images/cje/star_no.png" class="reStar" id="star3">
				<img src="${pageContext.request.contextPath}/images/cje/star_no.png" class="reStar" id="star4">
				<img src="${pageContext.request.contextPath}/images/cje/star_no.png" class="reStar" id="star5">
			</div>
            <div class="mr_content_div">
                <form id="mr_form">
                	<input type="hidden" name="pr_grade" class="pr_grade">
                	<input type="hidden" name="od_num" class="od_num">
                	<input type="hidden" name="p_num" class="p_num">
                    <textarea id="mr_content" name="pr_content"></textarea>
                    <div class="btn-div">
						<input type="button" class="mate_review_close" id="close-btn" value="취소">
                        <input type="submit" id="submit-btn" value="제출">
                    </div>
                </form>
            </div>
        </div>
    </div>
</div> 	
<!-- 굿즈 결제 내역 상세 끝-->
