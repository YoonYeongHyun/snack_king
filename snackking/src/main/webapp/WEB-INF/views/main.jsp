<%@page import="java.util.List"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.js"></script>
<link rel="stylesheet" href="resources/css/main.css">
<link rel="stylesheet" href="https://unpkg.com/swiper@8/swiper-bundle.min.css"/>
<script src="http://code.jquery.com/jquery-latest.min.js"></script> 
<script src="https://unpkg.com/swiper@8/swiper-bundle.min.js"></script>
</head>
<body>
<jsp:include page="common/header.jsp">
		<jsp:param name="memberId" value="${memberId}"/>
</jsp:include>

<jsp:include page="common/sideBar.jsp">
		<jsp:param name="memberId" value="${memberId}"/>
</jsp:include>

<div class="login_button">
<div class="swiper mySwiper">
	<div class="swiper-wrapper">
        <div class="swiper-slide" style="background: rgb(250, 218, 207);">
        	<a href="@" ><img style="display: inline-block;"  src="/resources/images/main_slider04.png"></a>
        </div>
        <div class="swiper-slide" style="background: rgb(228, 230, 229);"> 
            <a href="@"><img style="display: inline-block;"  src="/resources/images/main_slider05.png"></a> 
        </div>
        <div class="swiper-slide" style="background: rgb(243, 243, 243);"> 
          	<a href="@"><img style="display: inline-block;"  src="/resources/images/main_slider06.png"></a> 
        </div>
        <div class="swiper-slide" style="background: rgb(133, 14, 3);"> 
         	<a href="@"><img style="display: inline-block;"  src="/resources/images/main_slider07.jpg"></a> 
        </div>
        <div class="swiper-slide" style=""> 
          	<a href="@"><img style="display: inline-block;"  src="/resources/images/main_slider08.png"></a> 
        </div>
		</div>
        <div class="swiper-button-next"></div>
        <div class="swiper-button-prev"></div>
		<div class="swiper-pagination"></div>
</div>

<script>
var swiper = new Swiper(".mySwiper", {
	autoplay: {
   		delay: 5000, // 시간 설정
    },
    loop: true,
    cssMode: true,
    navigation: {
      nextEl: ".swiper-button-next",
      prevEl: ".swiper-button-prev",
    },
    pagination: {
      el: ".swiper-pagination",
      clickable: true, 
    },
    mousewheel: false,
    keyboard: true,
});
  
document.addEventListener("DOMContentLoaded", function(){like_btn
	let product_img_box = document.getElementsByName("product_img_box");
	
	product_img_box.forEach(element => element.addEventListener("mouseenter", function(e){
		let product_image = e.target.firstChild.nextSibling;
		product_image.style.opacity= "0.5";
		let hidden_box = e.target.lastChild.previousSibling;
		hidden_box.style.visibility="visible";
	}));
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
	    if("${memberId}"==""){
			alert("로그인 하세요");
			location="/member/login"
	    } else {
		    $.ajax({
		        type:'post',
		        async:false,
		        url:'/cartInsert',
		        dataType:'text',
		        data:{id:id,product_id:product_id, product_amount:product_amount},
		        success:function(data) {
		        	$('#cart_box').attr('class','cart_disabled')
		        	$('#cart_3').val(1);
		        	if(data=="success"){
		        		alert("장바구니에 담겼습니다.");	
		        	}else if(data=="fail"){
		        		alert("이미 장바구니에있는 상품입니다.");
		        	}
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
	<h2>최고 인기상품</h2> 
	<table class="main_table">
		<tr>
			
			<c:forEach items="${list1}" var="list1"> 
			<c:set var="i" value="${i+1}" />
			<td width="25%"> 
				<div class="product_img_box" name="product_img_box">
					<a href="/productContent?product_id=${list1.product_id}">
					<c:choose> 
					<c:when test="${i == 1}">
						<img class="medal" src="resources/icons/gold-medal.png" width="48px">
					</c:when>
					<c:when test="${i == 2}">	
						<img class="medal" src="resources/icons/silver-medal.png" width="48px">
					</c:when>
					<c:when test="${i == 3}">
						<img class="medal" src="resources/icons/bronze-medal.png" width="48px">
					</c:when>
					</c:choose>
						<img  id="product_img" src="/images_yhmall/${list1.product_image}" width="200px" height="200px"/> 
					</a>
					<div class="product__hidden_menu">
						<button type="button" name="like_btn" id="like_btn"></button>
						<button type="button" name="cart_btn" id="cart_btn"></button>
						<input type="hidden" value="${list1.product_id}">
						<input type="hidden" value="${list1.product_name}">
						<input type="hidden" value="${list1.product_image}">
					</div>
				</div>
				<p><a href="/productContent?product_id=${list1.product_id}">${list1.product_name}</a></p>
				<c:choose>
					<c:when test="${list1.discount_rate == 0}">
						<span class="sale_price" style="color:black;">
							<fmt:formatNumber value="${list1.product_sale_price}"/>원
						</span>
					</c:when>
					<c:otherwise>
						<span class="price" style="color:#aaa;"><fmt:formatNumber value="${list1.product_price}"/>원</span>&nbsp;
						<span class="sale_price"><fmt:formatNumber value="${list1.product_sale_price}"/>원</span>
					</c:otherwise>
				</c:choose>
				<c:if test = "${i == 4}">
					</tr><tr>
      			</c:if>
			</td>
			</c:forEach>
		</tr>
	</table>
	<h2>최고 할인상품</h2> 
	<table class="main_table">
		<tr>
			<c:set var="i" value = "0" />
			<c:forEach items="${list2}" var="list2"> 
			<c:set var="i" value = "${i+1 }" />
			<td width="25%"> 
				<div class="product_img_box" name="product_img_box">
					<a href="/productContent?product_id=${list2.product_id}">
					<c:choose> 
					<c:when test="${i == 1}">
						<img class="medal" src="resources/icons/gold-medal.png" width="48px">
					</c:when>
					<c:when test="${i == 2}">	
						<img class="medal" src="resources/icons/silver-medal.png" width="48px">
					</c:when>
					<c:when test="${i == 3}">
						<img class="medal" src="resources/icons/bronze-medal.png" width="48px">
					</c:when>
					</c:choose>
						<img  id="product_img" src="/images_yhmall/${list2.product_image}" width="200px" height="200px"/> 
					</a>
					<div class="product__hidden_menu">
						<button type="button" name="like_btn" id="like_btn"></button>
						<button type="button" name="cart_btn" id="cart_btn"></button>
						<input type="hidden" value="${list2.product_id}">
						<input type="hidden" value="${list2.product_name}">
						<input type="hidden" value="${list2.product_image}">
					</div>
				</div>
				<p><a href="/productContent?product_id=${list2.product_id}">${list2.product_name}</a></p>
				<c:choose>
				<c:when test="${list2.discount_rate == 0}">
					<span class="sale_price" style="color:black;">
						<fmt:formatNumber value="${list2.product_sale_price}"/>원
					</span>
				</c:when>
				<c:otherwise>
					<span class="price" style="color:#aaa;"><fmt:formatNumber value="${list2.product_price}"/>원</span>&nbsp;
					<span class="sale_price"><fmt:formatNumber value="${list2.product_sale_price}"/>원</span>
				</c:otherwise>
				</c:choose>
				<c:if test = "${i == 4}">
					</tr><tr>
				</c:if>
			</td>
			</c:forEach>
		</tr>
	</table>
	<hr>
</div>
</body>

<jsp:include page="common/footer.jsp"></jsp:include>
</html>