<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 자주 묻는 질문 -->
<div id="support_main" class="">
	<h3>공지/뉴스</h3>
	<div class="news-sub-info">
		CINEVERSE의 주요한 이슈 및 여러가지 소식들을 확인하실 수 있습니다.
	</div>
	<div class="news-search-container">
		<div class="search flexbox-h">
			<form action="news" id="news_search_form" class="flexbox-h" method="get" style="margin-left: auto;">
		
				<select>
					<option value="title">제목</option>
	           		<option value="content">내용</option>
				</select>
		
				<input type="hidden" name="" value="">
				<input type="search" class="search-input" name="keyword" placeholder="검색어를 입력해 주세요">
				<button type="submit" class="search-button" aria-label="검색하기">검색</button>
			<%--<input type="image" src="${pageContext.request.contextPath}/images/kbm/search.png" width="20" alt="검색"> --%>
            </form>
        </div>
	</div>
	<table class="news-table">
		<tr><%--faq,news 클래스명 합치기 --%>
			<td class="news-table-num">번호</td>
			<td class="news-table-title">제목</td>
			<td class="news-table-rdate">등록일</td>
			<td class="news-table-hit">조회수</td>
		</tr>
		<tr>
			<td class="news-table-num">999</td>
			<td class="news-table-title">CINEVERSE 개인정보처리방침 개정 안내</td>
			<td class="news-table-rdate">24.07.11</td>
			<td class="news-table-hit">999</td>
		</tr>
		<tr>
			<td class="news-table-num">999</td>
			<td class="news-table-title">CINEVERSE 개인정보처리방침 개정 안내</td>
			<td class="news-table-rdate">24.07.11</td>
			<td class="news-table-hit">999</td>
		</tr>
		<tr>
			<td class="news-table-num">999</td>
			<td class="news-table-title">CINEVERSE 개인정보처리방침 개정 안내</td>
			<td class="news-table-rdate">24.07.11</td>
			<td class="news-table-hit">999</td>
		</tr>
		<tr>
			<td class="news-table-num">999</td>
			<td class="news-table-title">CINEVERSE 개인정보처리방침 개정 안내</td>
			<td class="news-table-rdate">24.07.11</td>
			<td class="news-table-hit">999</td>
		</tr>
		<tr>
			<td class="news-table-num">999</td>
			<td class="news-table-title">CINEVERSE 개인정보처리방침 개정 안내</td>
			<td class="news-table-rdate">24.07.11</td>
			<td class="news-table-hit">999</td>
		</tr>
		<tr>
			<td class="news-table-num">999</td>
			<td class="news-table-title">CINEVERSE 개인정보처리방침 개정 안내</td>
			<td class="news-table-rdate">24.07.11</td>
			<td class="news-table-hit">999</td>
		</tr>
		<tr>
			<td class="news-table-num">999</td>
			<td class="news-table-title">CINEVERSE 개인정보처리방침 개정 안내</td>
			<td class="news-table-rdate">24.07.11</td>
			<td class="news-table-hit">999</td>
		</tr>
		<tr>
			<td class="news-table-num">999</td>
			<td class="news-table-title">CINEVERSE 개인정보처리방침 개정 안내</td>
			<td class="news-table-rdate">24.07.11</td>
			<td class="news-table-hit">999</td>
		</tr>
		<tr>
			<td class="news-table-num">999</td>
			<td class="news-table-title">CINEVERSE 개인정보처리방침 개정 안내</td>
			<td class="news-table-rdate">24.07.11</td>
			<td class="news-table-hit">999</td>
		</tr>
		<tr>
			<td class="news-table-num">999</td>
			<td class="news-table-title">CINEVERSE 개인정보처리방침 개정 안내</td>
			<td class="news-table-rdate">24.07.11</td>
			<td class="news-table-hit">999</td>
		</tr>
	</table>
</div>