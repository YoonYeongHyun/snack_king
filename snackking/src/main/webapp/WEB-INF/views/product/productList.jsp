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
<script src="http://code.jquery.com/jquery-latest.js"></script>
<style>
#container{width:1200px; margin:0 auto;}

table{width:1200px; border-collapse: collapse;}
tr {height: 300px; width:1200px;}
td {text-align: center;}
td p {margin:0 auto;}
td img{border: 1px solid #ccc;}

.product_img_box{position: relative; text-align: center; display:inline-block; width:202px}
.product__hidden_menu{position: absolute; top:120px; left:26.1px; visibility: hidden;}
.product__hidden_menu button{display:inline-block; width:50px; height:50px; background: white; border-radius: 100%;
							position: relative; border: 1px solid black; margin:0 10px; cursor: pointer; }
.product__hidden_menu #like_btn{background: url("/resources/icons/heart.png") no-repeat center white}
.product__hidden_menu #cart_btn{background: url("/resources/icons/basket.png") no-repeat center white}
.product__hidden_menu #like_btn:hover{background: url("../resources/icons/heart_negative.png") no-repeat center #F39;border: 1px solid #F39;}
.product__hidden_menu #cart_btn:hover{background: url("../resources/icons/basket_negative.png") no-repeat center #F39;border: 1px solid #F39;}
#product_info{display:inline-block; width:240px; height: 63px;}
.price{text-decoration: line-through;}
.sale_price{color: red}
		
#paging{text-align: center; margin-top: 20px}
#p_box{display: inline-block; width:25px; height:25px; border-radius: 10px; padding:5px; margin:5px }
#p_box:hover{background: black; color:white;}
.p_box_c{background: black; color:white; }
.p_box_b{font-weight: bold}

.cart_disabled{display:none;}
.cart_enabled{ position: fixed; left: 50%; transform: translate(-50%, 0); top:20%; z-index:1000; text-align:center;
width:400px; height: 400px; border: 2px solid black; border-radius:20px; padding:30px; background: white; }
#qty_set button{background:white; border:1px solid #888; ;border-radius:30%;font-size:1.3em;}
#qty_set input[type="number"]{text-align:center; border:none;}
#qty_set input[type="number"]:focus{outline:none;}
input::-webkit-inner-spin-button { -webkit-appearance:none; margin:0; }
#cart_btns{display: inline-block; width: 100%; margin-top: 30px}
#cart_btns button{width:130px; height:50px; margin:10px; font-size:0.9em; border: 0.5px solid #888; cursor: pointer;}
#cart_btns button:hover {font-weight: bold; box-shadow: 1px 1px 5px 1px #888;}
#cart_cancel{background: white}
#cart_insert{background: #D2691E; color: white;}
</style>
<script>

document.addEventListener("DOMContentLoaded", function(){
	let product_img_box = document.getElementsByName("product_img_box");
	
	product_img_box.forEach(element => element.addEventListener("mouseenter", function(e){
		let product_image = e.target.firstChild.nextSibling;
		product_image.style.opacity= "0.5";
		let hidden_box = e.target.lastChild.previousSibling;
		hidden_box.style.visibility="visible";
	}));
	product_img_box.forEach(element => element.addEventListener("mouseleave", function(e){
		let product_image = e.target.firstChild.nextSibling;
		product_image.style.opacity= "1";
		let hidden_box = e.target.lastChild.previousSibling;
		hidden_box.style.visibility="hidden";
	}));
	
	let cart_btn = document.getElementsByName("cart_btn");
	cart_btn.forEach(element => element.addEventListener("click", function(e){
		let cart__product_id = (e.target).nextElementSibling.value;
		let cart__product_name = (e.target).nextElementSibling.nextElementSibling.value;
		let cart__product_img = (e.target).nextElementSibling.nextElementSibling.nextElementSibling.value;
		let cart_1 = document.getElementById("cart_1");
		let cart_2 = document.getElementById("cart_2");
		let cart_product_name = document.getElementById("cart_product_name");
		let cart_product_img = document.getElementById("cart_product_img");
		
		cart_product_img.src="/images_yhmall/" + cart__product_img;
		cart_1.value = '${memberId}';
		cart_2.value = cart__product_id;
		cart_product_name.innerHTML = cart__product_name;
		document.getElementById('cart_box').className = 'cart_enabled';
	}));
	
	let cart_3 = document.getElementById("cart_3");
	document.getElementById("btn_plus").addEventListener("click", function(){
		if(cart_3.value > 999){
			alert("최대 구매 수량을 초과 하였습니다. (999개)");
		}else{
			cart_3.value = Number(cart_3.value)+1;	
		}
	});
	document.getElementById("btn_minus").addEventListener("click", function(){
		if(cart_3.value < 2){	
			alert("최소 1개이상 구매하셔야합니다.");
		}else{
			cart_3.value = Number(cart_3.value)-1;
		}
	});
	
	document.getElementById("cart_3").addEventListener("keyup", function(){
		if(cart_3.value > 999){
			cart_3.value = 1;	
			alert("최대 구매 수량을 초과 하였습니다. (999개)");
		}else if(cart_3.value < 1){
			cart_3.value = 1;	
			alert("최소 1개이상 구매하셔야합니다.");
		}
	});
})
$(document).ready(function(){
	$('#cart_insert').on("click", function(e){
		let id = $('#cart_1').val();
	    let product_id = $('#cart_2').val();
	    let product_amount = $('#cart_3').val();
	    let result = "";
	    e.preventDefault()
	    if("${memberId}"==""){
			alert("로그인 하세요");
			location="/member/login"
	    } else {
		    $.ajax({
		        type:'post',
		        async:false,
		        url:'/cartInsert',
		        dataType:'text',
		        async: false,
		        data:{id:id,product_id:product_id, product_amount:product_amount},
		        success:function(data) {
		        	$('#cart_box').attr('class','cart_disabled')
		        	$('#cart_3').val(1);
		        	alert("장바구니에 담겼습니다.");
		        	
		        },
		        error:function (data) {
		        	$('#cart_3').val() = 1;
		        	alert("오류가 발생하였습니다.")
		            
		        }
		    })
	    }
	})
	$('#cart_cancel').on("click", function(e){
		$('#cart_box').attr('class','cart_disabled')
	})
});
</script>
<body>
<jsp:include page="../common/header.jsp">
		<jsp:param name="memberId" value="${memberId}"/>
</jsp:include>

<jsp:include page="../common/sideBar.jsp">
		<jsp:param name="memberId" value="${memberId}"/>
</jsp:include>

	<div id="container">
		<div class="cart_disabled" id="cart_box">
			<div>
				<img src="" id="cart_product_img" width="200px">
			</div>
			<p id="cart_product_name"> </p>
			<input type="hidden" id="cart_1">
			<input type="hidden" id="cart_2">
			<div id="qty_set">
				<button type="button" id="btn_plus">+</button>
				<input type="number" id="cart_3" value="1" max="999" min="1">
				<button type="button" id="btn_minus">-</button>
			</div>
			<div id="cart_btns">
				<button id="cart_cancel">취소</button>
				<button id="cart_insert">장바구니 담기</button>
			</div>
		</div>
		<table>
			<tr>
				<c:set var="rootCnt" value="${0}" />
				<c:forEach items="${list}" var="list">  
					<c:if test="${((rootCnt % 5) eq 0) && ((rootCnt ne 0))}"></tr><tr></c:if>
						
						<td width="20%"> 
						<div class="product_img_box" name="product_img_box">
							<a href="/productContent?product_id=${list.product_id}">
								<img  id="product_img" src="/images_yhmall/${list.product_image}" width="200px" height="200px"/> 
							</a>
							<div class="product__hidden_menu">
								<button type="button" name="like_btn" id="like_btn"></button>
								<button type="button" name="cart_btn" id="cart_btn"></button>
								<input type="hidden" value="${list.product_id}">
								<input type="hidden" value="${list.product_name}">
								<input type="hidden" value="${list.product_image}">
							</div>
						</div>
						<br>
						<div id="product_info">
						<p><a href="/productContent?product_id=${list.product_id}">${list.product_name}</a></p>
						<c:choose>
							<c:when test="${list.discount_rate eq 0}">
								<span class="sale_price" style="color:black;">
									<fmt:formatNumber value="${list.product_sale_price}"/>원
								</span>
							</c:when>
							<c:otherwise>
								<span class="price" style="color:#aaa;"><fmt:formatNumber value="${list.product_price}"/>원</span>&nbsp;
								<span class="sale_price"><fmt:formatNumber value="${list.product_sale_price}"/>원</span>
							</c:otherwise>
							</c:choose>
						<c:set var="rootCnt" value="${rootCnt+1}" />
						</div>
						</td>
				
				</c:forEach>
			</tr>
		</table>
		<div id="paging">
			<c:set var="cnt" value="${count}" />
			<c:set var="currentPage" value="${pageNum}" />
			<c:set var="pageSize" value="20" />
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
					<a href='productList?pageNum=1&category=${category}&search='>
						<div id='p_box' class='p_box_b' title='첫 페이지'>≪</div>
					</a>
					<a href='productList?pageNum=${startPage-10}&category=${category}'>
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
							<a href='productList?pageNum=${status.count+currentPage_stage*10}&category=${category}'>
								<div id='p_box'> 
									<c:out value="${status.count+currentPage_stage*10}" />
								</div>
							</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if test="${endPage <= pageCount - (pageCount % pageBlock)}">
					<a href='productList?pageNum=${startPage+10}&category=${category}'>
						<div id='p_box' class='p_box_b' title='다음 페이지'>＞</div>
					</a>
					<a href='productList?pageNum=${pageCount}&category=${category}'>
						<div id='p_box' class='p_box_b' title='끝 페이지'>≫</div>
					</a>
				</c:if>
			</c:if>
		</div>
	</div>
</body>
	<jsp:include page="../common/footer.jsp"></jsp:include>
</html>
