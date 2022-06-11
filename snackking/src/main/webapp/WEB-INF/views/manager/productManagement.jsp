<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<style>

	#container{width:1000px; margin:0 auto;}
	@import url('https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Do+Hyeon&family=Nanum+Gothic:wght@700&display=swap');
 	a {text-decoration : none; color:black}
	.m_title {font-family: 'Bebas Neue', cursive; text-align: center; font-size: 5em;}
	.s_title {font-family: 'Nanum Gothic', sans-serif; font-size:1.5em; text-align: center;}
	h2{text-align:center;}
	.top_menu th:nth-child(1) {background:#555;}
	.top_menu th:nth-child(1) a {color:white}
	
	/* 상단 메뉴 */ 
	.top_menu {width:100%; height: 60px; border-collapse: collapse;}
	.top_menu th {background:#eee;}
	.top_menu th:hover {background:#555;}
	.top_menu th a:hover {color:white}
	.top_menu th a {display: block; height: 100%; text-decoration: none; color:black; line-height: 60px;font-size: 1.2em}
	/* 상품 목록*/
	.list_table{width:100%; border-collapse:collapse; border-bottom: 2px solid black; border-top: 2px solid black; margin-top: 20px;}
	tr{height: 50px}
	th{background:#aaa;}
	
	td{border:1px solid #eee;}
	.list_table td:nth-child(1){text-align: center}
	.list_table td:nth-child(2){text-align: center}
	.list_table td:nth-child(4){text-align: center}
	.list_table td:nth-child(5){text-align: center}
	.list_table td:nth-child(6){text-align: center}
	.list_table td:nth-child(7){text-align: center}
	list_button{text-align: center}
	#update_btn{width:50px; height:30px; background:#86E57F; color:white; border: none; border-radius:20%; font-weight: bold; cursor: pointer;}
	#delete_btn{width:50px; height:30px; background:#aaa;    color:white; border: none; border-radius:20%; font-weight: bold; cursor: pointer;}
	
	#paging{text-align: center; margin-top: 20px}
	#p_box{display: inline-block; width:25px; height:25px; border-radius: 10px; padding:5px; margin:5px }
	#p_box:hover{background: black; color:white;}
	.p_box_c{background: black; color:white; }
	.p_box_b{font-weight: bold}
</style>

<script>
document.addEventListener("DOMContentLoaded", function(){

	// 페이지 로드시 분류 선택
	let main_category = document.getElementById('main_category');
	for (let i=0; i<main_category.options.length; i++){
		if(main_category.options[i].value == ${category} ){
			main_category.options[i].selected = true;
		}
	}
	
	document.getElementById('search_btn').addEventListener("click", function(){
		let s_select = document.getElementById('s_select');
		let s_input = document.getElementById('s_input');
		let search = s_select.value + s_input.value; //검색분류와 검색값을 같이 보냄
		location="productManagement.jsp?category=" +  + "&search=" + search;
	});
	
	//리스트 수정 및 삭제 버튼 구현
	let update_btns = document.getElementsByName("update_btn");
	let delete_btns = document.getElementsByName("delete_btn");
	
	delete_btns.forEach(element => element.addEventListener("click", function(e){
		if(confirm("정말 삭제하시겠습니까?")){
			let l_num = e.target.previousSibling.previousSibling.previousSibling.previousSibling.value;
			window.open('productDeletePro.jsp?product_id='+l_num, "", "width = 500, height = 200 left = 740");
			setTimeout(function(){
				location.reload();
			},500);
		}
	}));

	update_btns.forEach(element => element.addEventListener("click", function(e){
		let l_num = e.target.previousSibling.previousSibling.value;
		location="productUpdate?product_id="+ l_num
		//location="productUpdateForm.jsp?product_id="+ l_num + "&pageNum=&category=&search=";
		function reloadDivArea() {
		    $('#list_table').load(location.href+' #list_table');
		}
	}));		
});

function main_category(){
	let main_category = document.getElementById("main_category")
	if(main_category != "0") location="productManagement?category="+main_category.value+ "&pageNum=1"; 
}
	 
</script>
</head>
<body>
	<div id="container">
		<div class="m_title"><a href="#">MALL</a></div>
		<h2>쇼핑몰 관리자 페이지</h2>
		<p>카테고리 : ${category}, 상품수: ${count}, 페이지넘버: ${pageNum},</p>
		
		
		<table class="top_menu">
			<tr>
				<th><a href="productManagement">상품 관리</a></th>
				<th><a href="productInsert">상품 등록</a></th>
				<th><a href="@">주문 관리</a></th>
				<th><a href="@">회원 관리</a></th>
				<th><a href="/manager/logout">로그아웃</a></th>
			</tr>
		</table>
		
		<div>
			<span>상품 종류</span>
			<select id=main_category onchange="main_category()">
				<option value="0">대분류</option>
				<option value="1">과자</option>
				<option value="2">껌/초콜릿/사탕</option>
				<option value="3">라면</option>
				<option value="4">음료</option>
				<option value="5">세트상품</option>
				<option value="6">수입상품</option>
			</select>
		</div>
		
		<div class="top_search">
			<input type="hidden" name="search" value="0">
			<span class="c_1">
				<select id="s_select">
					<option value = "1" selected>제품명</option>
					<option value = "2">제조사</option>
				</select>
			</span>
			<span class="c_2"><input type="text" id="s_input"> </span>
			<span class="c_3"> <input type="button" value="검색" id="search_btn"> </span>
		</div>
		<c:set var="cnt" value="${fn:length(list)}" />
		<p> ${managerId}</p>
		<div id="list_table">
			<table class="list_table" >
				<tr>
					<th width="10%">상품코드</th>
					<th width="5%"></th>
					<th width="30%">상품명</th>
					<th width="10%">제조사</th>
					<th width="10%">판매가격</th>
					<th width="10%">재고</th>
					<th width="10%">판매량</th>
					<th width="15%">기능</th>
				</tr>
				<c:if test = "${cnt == 0}">
					<tr><td colspan="8"> 등록된 상품이 없습니다.</td></tr>		
	      		</c:if>
				<c:forEach items="${list}" var="list"> 
					<tr>
						<td id="1con">${list.product_id}</td>
							<td>
							<img src="/images_yhmall/${list.product_image}" width="30px" height="30px"/>
						</td>
						<td>${list.product_name}</td>
						<td>${list.product_brand}</td>
						<td>
							<fmt:formatNumber value="${list.product_sale_price}"/>원
						</td>
						<td>${list.product_qty}</td>
						<td>${list.product_sales}</td>
						<td>
							<form action="" class="list_button">
								<input type="hidden" name="l_id" id="l_id" value="${list.product_id}">
								<input type="button" value="수정" name="update_btn" id="update_btn">
								<input type="button" value="삭제" name="delete_btn" id="delete_btn">
							</form> 
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		
		<div id="paging">
			<c:set var="cnt" value="${count}" />
			<c:set var="currentPage" value="${pageNum}" />
			<c:set var="pageSize" value="10" />
			<c:if test="${cnt > 0}">
				<fmt:parseNumber var="cntPageSize" value="${cnt / pageSize}" integerOnly="true" />		
						
				<c:set var="pageCount" value="${(cntPageSize) + (cnt%pageSize==0 ? 0 : 1)}" />
				<c:set var="pageBlock" value="10" />
					
				<c:set var="startPage" value="1" />
				<c:choose>
					<c:when test="${currentPage % 10 != 0}">
						<fmt:parseNumber var="currentPage_stage" value="${currentPage/10}" integerOnly="true" />		
						<c:set var="startPage" value="${currentPage_stage * 10 +1 }" />
					</c:when>
					<c:otherwise>
						<fmt:parseNumber var="currentPage_stage" value="${currentPage/10}" integerOnly="true" />	
						<c:set var="startPage" value="${(currentPage_stage -1) * 10 +1}" />
					</c:otherwise>
				</c:choose>
				
				<c:set var="endPage" value="${startPage + pageBlock-1}" />
				<c:if test="${endPage > pageCount}">
					<c:set var="endPage" value="${pageCount}"/>
				</c:if>
				<c:if test="${startPage > 10}">
					<a href='productManagement?pageNum=1&category=${category}&search='>
						<div id='p_box' class='p_box_b' title='첫 페이지'>≪</div>
					</a>
					<a href='productManagement?pageNum=${startPage-10}&category=${category}'>
						<div id='p_box' class='p_box_b'title='이전 페이지'>＜</div>
					</a>
				</c:if>
				<c:forEach begin="${startPage}" end="${endPage}" step="1" varStatus="status">
					<c:choose>
						<c:when test="${currentPage == status.count+currentPage_stage*10}">
							<div id='p_box' class='p_box_c'>
								<c:out value="${status.count+currentPage_stage*10}" />
							</div>
						</c:when>
						<c:otherwise>
							<a href='productManagement?pageNum=${status.count+currentPage_stage*10}&category=${category}'>
								<div id='p_box'> 
									<c:out value="${status.count+currentPage_stage*10}" />
								</div>
							</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if test="${endPage <= pageCount - (pageCount % pageSize)}">
					<a href='productManagement?pageNum=${startPage+10}&category=${category}'>
						<div id='p_box' class='p_box_b' title='다음 페이지'>＞</div>
					</a>
					<a href='productManagement?pageNum=${pageCount}&category=${category}'>
						<div id='p_box' class='p_box_b' title='끝 페이지'>≫</div>
					</a>
				</c:if>
			</c:if>
		</div>
	</div>
</body>
</html>