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
	
	.box_enabled{display: inline-block; position:fixed; z-index:999; background: white; width: 384px; height: 60%; margin-left:760px; margin-top:-100px; border: 2px solid black}
	.box_disabled{display: none;}
	#review_box_top{width: 100%; height: 46px; text-align: right; font-size: 2em; border-bottom: 1px solid black; padding: 5px; box-sizing: border-box; margin-bottom: 20px;}
	#review_box_close {cursor: pointer;}
	#review_form_section{padding: 10px}
	#review_form_section h4{text-align: center; margin: 20px 0 10px 0; }
	#re_title{display: inline-block; width: 350px; padding:6px; font-size: 18px; }
	#re_content{display: inline-block; width: 350px; padding:6px; font-size: 18px; }
	#review_rate{text-align: center; margin-top:20px }
	
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
	
	
	.review_list{width: 100%; height: auto; margin:70px 0;}
	.review_list table th{border-top: 1px solid #444; border-bottom: 1px solid #aaa; padding: 10px; font-size: 0.9em}
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

	let buy_confirm_button = document.querySelectorAll('.buy_confirm_button');
	buy_confirm_button.forEach(element => element.addEventListener("click", function(e){

		let buy_id = e.target.nextElementSibling.value;
		let id = '${member.id}';
		if(confirm('해당 상품을 구매 확정 하시겠습니까??')){
			$.ajax({
				type:'post',
				async:false,
				url:'/member/buyConfirm',
				dataType:'text',
				data:{id:id, buy_id:buy_id},
				success:function(data){
					alert(data);
					console.log(data)
					location.reload();
				},
				error:function (data) {
					alert("오류가 발생하였습니다.")
			    }
			});
		}
	}));
	
	let review_button = document.querySelectorAll('.review_button');
	review_button.forEach(element => element.addEventListener("click", function(e){
		
		on_off_review_box();
		
		let review_image = document.querySelector('#review_image')
		let review_product_id = document.querySelector('#review_product_id')
		let review_buy_id = document.querySelector('#review_buy_id')
		
		review_image.src = e.target.nextElementSibling.value;
		review_product_id.value = e.target.nextElementSibling.nextElementSibling.value;
		review_buy_id.value = e.target.nextElementSibling.nextElementSibling.nextElementSibling.value;
	}));
	
	function on_off_review_box() {
		let review_box = document.querySelector('#review_box')
		
		if(review_box.className == 'box_disabled'){
			review_box.className = "box_enabled";
		}else{
			review_box.className = "box_disabled";
		}
	}
	

	let star = document.querySelectorAll('.star');
	review_button.forEach(element => element.addEventListener("", function(e){
})

</script>

<jsp:include page="../common/header.jsp">
		<jsp:param name="memberId" value="${memberId}"/>
</jsp:include>

<jsp:include page="../common/sideBar.jsp">
		<jsp:param name="memberId" value="${memberId}"/>
</jsp:include>
<body>
	<div class="box_disabled" id="review_box">	
		<div id="review_box_top">
			<img src="../resources/icons/X.png" width="32px" height="32px" id="review_box_close">
		</div>
		<div id="review_form_section">
			<img src="#" id="review_image" width="100px">
			<div id="review_rate">
				<img src="../resources/icons/nostar.png" width="32px" class="non_active star">
				<img src="../resources/icons/nostar.png" width="32px" class="non_active star">
				<img src="../resources/icons/nostar.png" width="32px" class="non_active star">
				<img src="../resources/icons/nostar.png" width="32px" class="non_active star">
				<img src="../resources/icons/nostar.png" width="32px" class="non_active star">
				<input type="hidden">
			</div>
			<form name="review_form" action="" method="post">
				<input type="hidden" name="id" id="review_id" value="${member.id}">
				<input type="hidden" name="product_id" id="review_product_id">
				<input type="hidden" name="buy_id" id="review_buy_id">
				<h4>상품후기의 제목을 적어주세요</h4>
				<input type="text" name="re_title" id="re_title"> <br>
				<h4>상품후기의 내용을 적어주세요</h4>
				<textarea rows="4" cols="20" name="re_content" id="re_content"></textarea>
			</form>
		</div>
	</div>
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
				<c:set var="exbuy_id" value="0"></c:set>
				<c:forEach var="buy" items="${buy_list}" varStatus="status">
				<tr style="border-bottom: 1px solid #eee;">
				<c:if test="${exbuy_id ne buy.buy_id}">
					<td style="text-align: center; border-right: 1px solid #eee;" rowspan="${buy.buy_bundles}">
						<span style="font-size: 0.9em; color:#888;"><fmt:formatDate value="${buy.buy_date}" pattern="yyyy/MM/dd"/></span> <br>
						<a style="color:#289aff; font-weight: bold; text-decoration:underline;" href="##"> ${buy.buy_id} </a>
					</td>
				</c:if>
					<td height="80px" width="70px">
						<div style="margin-left: 10px; border: 1px solid #eee; display: inline-block;">
							<img width="60px" src="/images_yhmall/${buy.product_image}" >
						</div>
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
				<c:if test="${exbuy_id ne buy.buy_id || buy.buy_com eq 'true'}">
				<c:choose>
				<c:when test="${buy.buy_com eq 'false'}">
					<td style="text-align: center; border-left: 1px solid #eee;" rowspan="${buy.buy_bundles}">
				</c:when>
				<c:otherwise>
					<td style="text-align: center; border-left: 1px solid #eee;">
				</c:otherwise>
				</c:choose>
						<c:choose>
							<c:when test="${buy.buy_com eq 'false'}">
								<input type="button" value="구매 확정" class="buy_confirm_button">
								<input type="hidden" name="product_id" value="${buy.buy_id}">
							</c:when>
							<c:when test="${buy.buy_com eq 'true' && buy.review_com eq 'false'}">
								<form name="review_form" action="" method="post">
									<input type="hidden" name="product_id" value="${buy.product_id}">
									<input type="hidden" name="id" value="${buy.id}">
									<input type="hidden" name="buy_id" value="${buy.buy_id}">
								</form>
								<input type="button" value="리뷰 쓰기" class="review_button">
								<input type="hidden" value="/images_yhmall/${buy.product_image}">
								<input type="hidden" value="${buy.product_id}">
								<input type="hidden" value="${buy.buy_id}">
							</c:when>
							<c:otherwise>
								<strong>구매/리뷰 완료</strong>
							</c:otherwise>
						</c:choose>
					</td>
				</c:if>
				</tr>
				<c:set var="exbuy_id" value="${buy.buy_id}"></c:set>
				</c:forEach>
			</table>
		</div>
		
		<div class="review_list">
			<h2 class="menu_title">내가쓴 리뷰</h2>
			<table id="review_table" >
				<tr>
					<th width="10%">평점</th>
					<th width="50%">제목</th>
					<th width="10%">작성자</th>
					<th width="15%">작성일</th>
					<th width="10%">조회수</th>
				</tr>
				<c:choose>
					<c:when test="${review_list.size() eq 0}">
						<tr>
							<td colspan="5" style="text-align:center;">등록된 글이 없습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="review" items="${review_list}">
							<tr>
								<td style="text-align:center; margin-right: 20px">
									<img src="../resources/icons/Star${review.re_rate}.png" width="80px">
								</td>
								<td>
									<a id="review_title" style="cursor:pointer;">${review.re_title}</a>
								</td>
								<td style="text-align: center">${review.id}</td>
								<td style="text-align: center">${review.re_regDate}</td>
								<td style="text-align: center">${review.readCount}</td>
							</tr>
							<tr class="hidden_review">
								<td colspan="5">
									<p>${review.re_content}</p>
								</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</table>
		</div>
	</div>
</body>
	<jsp:include page="../common/footer.jsp"></jsp:include>
</html>