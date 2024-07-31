<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/myPage.bought.js"></script>

<!--  굿즈 내역 시작 -->
<div class="myPage_main">

	<div class="main_body_reservation">
		<div class="my_reserv_info">
			<span class="reserv_font">나의 굿즈 결제 내역</span><span class="main_count">${count}건</span>
		</div>
		<c:if test="${count==0 }">
			<div class="empty_position">구매한 내역이 존재하지 않습니다.</div>
		</c:if>
		<c:if test="${count>0 }">

			<c:forEach var="o" items="${orders}">
				<div class="myPageReservation_list">
					<!--  css 수정 예매추가로 하면 박스 늘어나게 -->
					<div class="mp_reserv">
						<!-- 근데 이 부분 css를 똑같이 썼더니 하얀색으로 삐죽... -->
						<!-- 영화사진 비율로 느낌만 낸거라 삐죽/css를 다르게 해야될수도! -->
						<div class="m_movie_photo">
							<img
								src="${pagecontext.request.contextPath}/upload/${o.p_filename}"
								alt="결제 내역" width="160" height="160"
								onclick="location.href='/myPage/boughtDetail?order_num=${o.order_num}'">
						</div>


						<div class="mpMovie_info" onclick="location.href='/myPage/boughtDetail?order_num=${o.order_num}'">
							<div class="bought_info">
								<!-- 20,47,48,49에 사용한 변수는 myPage.css(1086)에 새로 추가했어요 쩝 -->
								<span class="mp_movie_number_1">결제번호</span> <span
									class="mp_movie_number_3">${o.od_number} </span> <span
									class="my_delivery_process">
									<c:if test="${o.order_status==1}">
									결제완료
									</c:if>
									<c:if test="${o.order_status==2}">
									배송준비중
									</c:if>
									<c:if test="${o.order_status==3}">
									배송중 
									</c:if>
									<c:if test="${o.order_status==4}">
									배송완료
									</c:if>
									<c:if test="${o.order_status==5}">
									주문취소
									</c:if>
									
									<c:if test="${o.order_status==6}">
									주문 확정
									</c:if>
								</span>
							</div>
							<div class="mp_movie_title">${o.p_name}외
								${o.total_quantity}건</div>

							<div class="reservation_list">
								<div class="reserv_info">
									<div>구매일시</div>
									<div>상품금액</div>
									<div>주문수량</div>
								</div>

								<div class="my_reserv_info">
									<div>${o.order_date}</div>
									<div>${o.total_price}원(배송비X)</div>
									<div>${o.total_quantity}개</div>
								</div>
							</div>
							<hr size="1" width="100%" class="reserv_line">
							<div class="reserv_pay_cancle">
								<div>
									<span class="m_pay">총 결제금액 </span><span class="my_blue_font">${o.total_price }</span>
								</div>
								<!-- 버튼들 -->
								<div class="my_bought_btn">
									<c:if test="${o.order_status!=6}">
										<span class="my_order_confirm" data-num="${o.order_num}"
											data-mnum="${o.mem_num}">주문확정</span>
										<span class="my_order_return"> <a
											href="${pagecontext.request.contextPath}/support/consultForm2?order_num=${o.order_num}">교환/반품</a></span>
									</c:if>
									<c:if test="${o.order_status==6 && o.order_re_status==1}">
										<span class="my_order_review"
											onclick="location.href='/myPage/boughtDetail?order_num=${o.order_num}'">리뷰쓰기</span>
									</c:if>
								</div>
							</div>
						</div>

					</div>
				</div>
			</c:forEach>
		</c:if>
	</div>




</div>



<!--  내가 본 영화 끝 -->