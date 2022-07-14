<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<style>
	#container{width:1000px; height: auto; margin: 0 auto;}
	.menu_title{font-weight: bold; border-bottom: 2px solid black; margin: 0; padding: 20px 0;}
	.member_info{width: 100%; height: auto;}
	table{width: 100%;  border-collapse: collapse}
	.member_info table tr{border-bottom: 1px solid #aaa}
	.member_info table th{text-align: left;}
	.member_info_content{display: inline-block; width: 300px}
	.common_button_type{background: white; width: 100px; height: 36px; border: 1px solid #aaa; cursor: pointer;}
	.member_info_button_appear:hover, .member_info_button_hide:hover{border: 1px solid black;font-weight:bold;}
	table strong{display:inline-block; width:150px; padding: 5px 0; margin: 10px 0}
	
	.buy_info{width: 100%; height: auto; margin:70px 0;}
	.buy_info table th{border-top: 1px solid #777; border-bottom: 1px solid #aaa; padding: 10px; font-size: 0.9em}
	.hide_button{margin: 10px 20px;}
	.hide{display: none;}
	.appear{display: block;}
</style>
<script>
document.addEventListener("DOMContentLoaded", function(){
	let member_info_button = document.querySelectorAll('.member_info_button_appear');
	member_info_button.forEach(element => element.addEventListener("click", function(e){
		console.log(e.target);
		console.log(e.target.parentNode);
		console.log(e.target.parentNode.nextElementSibling);
		e.target.parentNode.className = 'hide';
		e.target.parentNode.nextElementSibling.className = 'appear';
	}));
	
	let member_info_button_hide = document.querySelectorAll('.member_info_button_hide');
	member_info_button_hide.forEach(element => element.addEventListener("click", function(e){
		console.log(e.target);
		console.log(e.target.parentNode);
		console.log(e.target.parentNode.previousElementSibling);
		e.target.parentNode.className = 'hide';
		e.target.parentNode.previousElementSibling.className = 'appear';
	}));
	
})

</script>

<jsp:include page="../common/header.jsp">
		<jsp:param name="memberId" value="${memberId}"/>
</jsp:include>

<jsp:include page="../common/sideBar.jsp">
		<jsp:param name="memberId" value="${memberId}"/>
</jsp:include>
<body>
	<div id="container">
		<p><strong style="font-size: 2em;">${member.id}</strong>님, 안녕하세요!</p>
		
		<div class="member_info">
			<h2 class="menu_title">회원정보</h2>
			<table>
				<tr> 
					<th width="30%">아이디</th>
					<td>
						<p class="member_info_content">${member.id}</p>
					</td>
				</tr> 
				<tr> 
					<th width="30%">비밀번호</th>
					<td class="appear" id="member_info">
						<p class="member_info_content">********</p>
						<input class="member_info_button_appear common_button_type"  type="button" value="비밀번호 변경">
					</td>
					<td class="hide">
						<strong>현재 비밀번호</strong> <input type="password"> <br>
						<strong>신규 비밀번호</strong> <input type="password"> <br>
						<strong>신규 비밀번호확인</strong> <input type="password"> <br>
						<input class="member_info_button_hide hide_button common_button_type" type="button" value="취소">
						<input class="hide_button common_button_type" type="button" value="변경">
					</td>
				</tr> 
				<tr> 
					<th width="30%">이름</th>
					<td class="appear" id="member_info">
						<p class="member_info_content">${member.name}</p>
						<input class="member_info_button_appear common_button_type" type="button" value="이름 변경">
					</td>
					<td class="hide">
						<strong>이름</strong> <input type="text"> <br>
						<input class="member_info_button_hide hide_button common_button_type"  type="button" value="취소">
						<input class="hide_button common_button_type"  type="button" value="변경">
					</td>
				</tr> 
				<tr> 
					<th width="30%">이메일</th>
					<td class="appear" id="member_info">
						<p class="member_info_content">${member.email}</p>
						<input class="member_info_button_appear common_button_type" type="button" value="이메일 변경">
					</td>
					<td class="hide">
						<strong>이메일</strong> <input type="text"> <br>
						<input class="member_info_button_hide hide_button common_button_type"  type="button" value="취소">
						<input class="hide_button common_button_type"  type="button" value="변경">
					</td>
				</tr> 
				<tr> 
					<th width="30%">연락처</th>
					<td class="appear" id="member_info">
						<p class="member_info_content">${member.tel}</p>
						<input class="member_info_button_appear common_button_type" type="button" value="연락처 변경">
					</td>
					<td class="hide">
						<strong>연락처</strong> <input type="text"> <br>
						<input class="member_info_button_hide hide_button common_button_type"  type="button" value="취소">
						<input class="hide_button common_button_type"  type="button" value="변경">
					</td>
				</tr> 
			</table>
		</div>
		
		<div class="buy_info">
			<h2 class="menu_title">주문내역</h2>
			<table>
				<tr>
					<th width="10%"></th> <th width="15%">주문번호/날짜</th> <th width="40%">상품명</th> <th width="15%">상품금액/수량</th> <th width="10%">주문상태</th> <th width="10%">확인/리뷰</th>  
				</tr>
				<c:forEach var="buy" items="${buy_list}" varStatus="status">
				<tr>
					<td><img width="80px" src="/images_yhmall/${buy.product_image}" ></td>
					<td>
						<fmt:formatDate value="${buy.buy_date}" pattern="yyyy/MM/dd"/> <br>
						${buy.buy_id}
					</td>
				</tr>
				</c:forEach>
			</table>
		</div>
	</div>
</body>
	<jsp:include page="../common/footer.jsp"></jsp:include>
</html>