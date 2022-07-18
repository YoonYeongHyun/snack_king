<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
</head>
<style>
	#container{width:1000px; height: auto; margin: 0 auto;}
	.menu_title{font-weight: bold; border-bottom: 2px solid black; margin: 0; padding: 20px 0;}
	.member_info{width: 100%; height: auto;}
	table{width: 100%;  border-collapse: collapse}
	.member_info table tr{border-bottom: 1px solid #ddd}
	.member_info table th{text-align: left;}
	.member_info_content{display: inline-block; width: 300px}
	.common_button_type{background: white; width: 100px; height: 36px; border: 1px solid #aaa; cursor: pointer;}
	.member_info_button_appear:hover, .member_info_button_hide:hover{border: 1px solid black; font-weight:bold;}
	.member_table strong{display:inline-block; width:150px; padding: 5px 0; margin: 10px 0}
	
	.buy_info{width: 100%; height: auto; margin:70px 0;}
	.buy_info table th{border-top: 1px solid #444; border-bottom: 1px solid #aaa; padding: 10px; font-size: 0.9em}
	.hide_button{margin: 10px 20px;}
	.hide{display: none;}
	.appear{display: block;}
</style>
<script>
document.addEventListener("DOMContentLoaded", function(){
	
	let member_info_button = document.querySelectorAll('.member_info_button_appear');
	member_info_button.forEach(element => element.addEventListener("click", function(e){
		e.target.parentNode.className = 'hide';
		e.target.parentNode.nextElementSibling.className = 'appear';
	}));
	
	let member_info_button_hide = document.querySelectorAll('.member_info_button_hide');
	member_info_button_hide.forEach(element => element.addEventListener("click", function(e){

		e.target.parentNode.className = 'hide';
		e.target.parentNode.previousElementSibling.className = 'appear';
	}));


	let new_password = document.getElementById('new_password');
	let new_password_confirm = document.getElementById('new_password_confirm');
	let new_name = document.getElementById('new_name');
	let new_email = document.getElementById('new_email');
	let new_tel = document.getElementById('new_tel');
	
	
	
	
	let member_info_update_button = document.querySelectorAll('.member_info_update_button');
	member_info_update_button.forEach(element => element.addEventListener("click", function(e){

		console.log(new_password.value);
		console.log(new_password_confirm.value);
		let id = '${member.id}';
		let change_info1 = e.target.nextElementSibling.value;
		let change_info2 = '';
		let pwd = document.getElementById('password').value;
		if(change_info1 == 'password'){
			if(new_password.value == new_password_confirm.value){
				change_info2 = new_password.value;
				if(new_password.value.length >= 4 && new_password.value.length <= 15) memberUpdate(id, change_info1, change_info2, pwd);
				else alert('비밀번호는 4 ~ 15자리로 설정하세요.');
			}else alert('신규 비밀번호와 신규 비밀번호확인이 일치하지 않습니다.');
		}else if(change_info1 == 'name'){ 
			change_info2 = new_name.value;
			memberUpdate(id, change_info1, change_info2, pwd);
		}else if(change_info1 == 'email'){
			change_info2 = new_email.value;
			memberUpdate(id, change_info1, change_info2, pwd);
		}else if(change_info1 == 'tel'){
			change_info2 = new_tel.value;
			memberUpdate(id, change_info1, change_info2, pwd);
		}
		
		
		//memberUpdate(id, change_info1, change_info2);
		console.log(e.target.nextElementSibling.value);
		console.log(e.target.previousElementSibling.previousElementSibling.previousElementSibling.value);
		console.log(new_password);
		console.log(pwd);
	}));
	
	function memberUpdate(id, change_info1, change_info2, pwd) {
		
		$.ajax({
			type:'post',
			async:false,
			url:'/member/memberUpdate',
			dataType:'text',
			data:{id:id, change_info1:change_info1, change_info2:change_info2, pwd:pwd},
			success:function(data){
				alert(data);
				console.log(data)
				location.reload();
			},
			error:function (data) {
				alert("오류가 발생하였습니다.")
		    }
		})
	}
	
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
			<table class="member_table">
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
						<strong>현재 비밀번호</strong> <input type="password" id="password"> <br>
						<strong>신규 비밀번호</strong> <input type="password" id="new_password"> <br>
						<strong>신규 비밀번호확인</strong> <input type="password" id="new_password_confirm"> <br>
						<input class="member_info_button_hide hide_button common_button_type" type="button" value="취소">
						<input class="member_info_update_button hide_button common_button_type" type="button" value="변경">
						<input type="hidden" value="password">
					</td>
				</tr> 
				<tr> 
					<th width="30%">이름</th>
					<td class="appear" id="member_info">
						<p class="member_info_content">${member.name}</p>
						<input class="member_info_button_appear common_button_type" type="button" value="이름 변경">
					</td>
					<td class="hide">
						<strong>이름</strong> <input type="text" id="new_name"> <br>
						<input class="member_info_button_hide hide_button common_button_type"  type="button" value="취소">
						<input class="member_info_update_button hide_button common_button_type"  type="button" value="변경">
						<input type="hidden" value="name">
					</td>
				</tr> 
				<tr> 
					<th width="30%">이메일</th>
					<td class="appear" id="member_info">
						<p class="member_info_content">${member.email}</p>
						<input class="member_info_button_appear common_button_type" type="button" value="이메일 변경">
					</td>
					<td class="hide">
						<strong>이메일</strong> <input type="text" id="new_email"> <br>
						<input class="member_info_button_hide hide_button common_button_type"  type="button" value="취소">
						<input class="member_info_update_button hide_button common_button_type"  type="button" value="변경">
						<input type="hidden" value="email">
					</td>
				</tr> 
				<tr> 
					<th width="30%">연락처</th>
					<td class="appear" id="member_info">
						<p class="member_info_content">${member.tel}</p>
						<input class="member_info_button_appear common_button_type" type="button" value="연락처 변경">
					</td>
					<td class="hide">
						<strong>연락처</strong> <input type="text" id="new_tel" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"> <br>
						<input class="member_info_button_hide hide_button common_button_type"  type="button" value="취소">
						<input class="member_info_update_button hide_button common_button_type"  type="button" value="변경">
						<input type="hidden" value="tel">
					</td>
				</tr>
			</table>
		</div>
		
		<div class="buy_info">
			<h2 class="menu_title">주문내역</h2>
			<table>
				<tr>
					<th width="18%">주문번호/날짜</th> <th width="12%"></th> <th width="45%">상품명</th> <th width="15%">상품금액/수량</th><th width="10%">확인/리뷰</th>  
				</tr>
				<c:forEach var="buy" items="${buy_list}" varStatus="status">
				<tr>
					<td style="text-align: center;">
						<span style="font-size: 0.9em; color:#888;"><fmt:formatDate value="${buy.buy_date}" pattern="yyyy/MM/dd"/></span> <br>
						<a style="color:#289aff; font-weight: bold; text-decoration:underline;" href="##"> ${buy.buy_id} </a>
					</td>
					<td>
						<img width="80px" src="/images_yhmall/${buy.product_image}" >
					</td>
					<td>
						<a href="/productContent?product_id=${buy.product_id}"><strong>${buy.product_name}</strong></a>
					</td>
					<td style="text-align: right; padding:0 15px 0 0;">
						<p>
							<strong><fmt:formatNumber value="${buy.buy_price}"/>원</strong>/ 
							<span style="font-size: 0.9em; color:#888;">${buy.buy_amount}개</span>&ensp;
						</p>
					</td>
					
				</tr>
				</c:forEach>
			</table>
		</div>
	</div>
</body>
	<jsp:include page="../common/footer.jsp"></jsp:include>
</html>