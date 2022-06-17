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
.container{width: 1200px; height:auto; overflow:hidden;  margin: 0 auto; padding: 50px 20px;}
#cart_box{float:left; width:900px; height: 1200px;}	
table {border-top: 1px solid black; border-collapse: collapse; width: 100%;}
#cart_table td, #cart_table th{padding: 20px 0; text-align: center; vertical-align: middle; border-bottom: 1px solid #ddd;}
#cart_table td{height: 100px}
#cart_num{width: 40px}
.amount_btn{width:70px; height:40px; border: 1px solid #aaa; margin-top:20px; background:white; font-weight: bold; cursor: pointer;  }
.amount_btn:hover{background: black; color:white;}

#delete_btns{width: 100%; height: 100px; text-align: right;}
#delete_btn{width: 150px; height: 50px; border: 1px solid #ccc; background: white; font-size: 1.2em; cursor: pointer; margin: 20px}
#delete_btn:hover{border: 1px solid black; font-weight: bold; }

#order_info{width: 1140px; height: 80px; background: #f5f0c5; padding: 30px; text-align: center; font-size: 1.2em; 
			border-top:1px solid #966147; }
#final_price1, #final_price2, #final_price3{font-size: 1.5em; font-weight: bold;}

#order_btns{width:1160px; height:112px; padding:20px; text-align: right;}
#order_btns form{display: inline-block; width: 210px}
#order_btns input[type="button"]{width:200px; height:70px; padding: 10px; font-size: 1.2em; border: 1.5px solid #ccc; border-radius:20px; cursor: pointer;}
#se_purchase_btn{background: black; color:white;}
#all_purchase_btn{background: white; color:black;}
				   
</style>
<script>
document.addEventListener("DOMContentLoaded", function(){
	let cart_cnt = ${cart_cnt};
	if(cart_cnt != 0){
		
		let cart_num = document.querySelectorAll('#cart_num');
		cart_num.forEach(element => element.addEventListener("keyup", function(e){
			let cart_qty = e.target.previousSibling.previousSibling;
			amount_func(e);
			if(e.target.value > parseInt(cart_qty.value)){
				alert('선택량이 재고량 보다 많습니다.');
				e.target.value = parseInt(cart_qty.value);
			}
		}));
		
		cart_num.forEach(element => element.addEventListener("change", function(e){
			let cart_qty = e.target.previousSibling.previousSibling;
			amount_func(e);
			if(e.target.value > parseInt(cart_qty.value)){
				alert('선택량이 재고량 보다 많습니다.');
				e.target.value = parseInt(cart_qty.value);
			}
		}));
		
		function amount_func(e){
			if(e.target.value > 999){
				e.target.value = 999;
				alert("999개 이하로 주문하세요");
			}else if(e.target.value < 1){
				e.target.value = 1;
				alert("1개 이상 주문하세요")
			}
		}
		let cart_chk_all = document.getElementById("cart_chk_all");
		let cart_chk = document.getElementsByName("cart_chk");
		func01();

		
		cart_chk_all.addEventListener("click", function(){
			if(cart_chk_all.checked){
				cart_chk.forEach(element => {
					element.checked = true;
				});
			}else{
				cart_chk.forEach(element => {
					element.checked = false;
				});
			}
			func01();
		});
		

		
		cart_chk.forEach(element => element.addEventListener("change", function(e){
			let chk_cnt = cart_chk.length;
			let chk_checked_cnt = 0;
			for(let chk of cart_chk){
				if(chk.checked) chk_checked_cnt++;
			}
			if(chk_cnt == chk_checked_cnt) cart_chk_all.checked = true;
			else cart_chk_all.checked = false;
			func01();
		}));
		
		
		document.getElementById("se_purchase_btn").addEventListener("click", function(){
			document.getElementById('cartForm').submit();	
		});
		document.getElementById("all_purchase_btn").addEventListener("click", function(){
			cart_chk.forEach(element => {
				element.checked = true;
			});
			func01();
			document.getElementById('cartForm').submit();
		});
		
		function func01(){
			let selected_cnt = 0;
			sum = 0;
			cart_chk.forEach(element => {
				if(element.checked){
					let chk_product_id = element.nextElementSibling;
					let chk_product_amount = element.nextElementSibling.nextElementSibling;
					let chk_product_price = element.nextElementSibling.nextElementSibling.nextElementSibling;
					
					
					chk_product_id.setAttribute('name', 'chk_product_id');
					chk_product_amount.setAttribute('name', 'chk_product_amount');
					chk_product_price.setAttribute('name', 'chk_product_price');
					selected_cnt++;
					sum += (chk_product_amount.value * chk_product_price.value);
				}else{
					element.nextElementSibling.setAttribute('name', 'unchk_product_id');
					element.nextElementSibling.nextElementSibling.setAttribute('name', 'unchk_product_amount');
					element.nextElementSibling.nextElementSibling.nextElementSibling.setAttribute('name', 'unchk_product_price');
				}
			});
			document.getElementById("final_price1").innerHTML = sum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
			if(sum >= 40000){
				document.getElementsByClassName('delivery_Fee')[0].innerHTML = 0;
				document.getElementsByClassName('delivery_Fee')[1].innerHTML = 0;
				document.getElementById("final_price3").innerHTML = sum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
			}else{
				document.getElementsByClassName('delivery_Fee')[0].innerHTML = '2,500';
				document.getElementsByClassName('delivery_Fee')[1].innerHTML = '2,500';
				document.getElementById("final_price3").innerHTML = (sum+2500).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
			}
			document.getElementById('selected_cnt').innerText= selected_cnt;
		}
	}
});
$(document).ready(function(){
	$('.amount_btn').on("click", function(e){
	    let product_id = $(event.target).prev().prev().val();
	    let product_amount = $(event.target).prev().prev().prev().val();
	    $.ajax({
	        type:'post',
	        async:false,
	        url:'/cartUpdate',
	        data:{product_id:product_id, product_amount:product_amount},
	        success:function(data){
	        	alert("수량이 변경되었습니다.");
	        	location.reload();
	        },
	        error:function (data) {
	            alert("오류가 발생하였습니다.")
	        }
	    })
	})
	
	$('#delete_btn').on("click", function(e){
	    let product_ids = [];
	    $('input[name="cart_chk"]:checked').each(function(i){//체크된 리스트 저장
	    	product_ids.push($(this).next().val());
        });
	    $.ajax({
	        type:'post',
	        async:false,
	        url:'/cartDelete',
	        data:{product_ids : product_ids},
	        success:function(data){
	        	alert("삭제 하였습니다.");
	        	location.reload();
	        },
	        error:function (data) {
	           alert("오류가 발생하였습니다.")
	        }
	    })
	})
	
	
	$('#none_btn').on("click", function(e){
		var data = {'message' : "message"};
	    $.ajax({
	        type:'post',
	        url:'/cartNone',
	        success:function(data){       	
	        	alert("성공 하였습니다.");
	        	console.log(data);
	        	alert(data);	        
	        },
	        error:function (obj) {
	           alert("실패 하였습니다.");
	        }
	    })
	})
})
</script>
<jsp:include page="../common/header.jsp">
		<jsp:param name="memberId" value="${memberId}"/>
</jsp:include>

<jsp:include page="../common/sideBar.jsp">
		<jsp:param name="memberId" value="${memberId}"/>
</jsp:include>
<div class="container">
	<h2>장바구니</h2>
	<table id="cart_table">
		<form action="/productOrderCart" method="post" id="cartForm">
			<tr> 
				<th width="4%"><input type="checkbox" id="cart_chk_all" checked></th>
				<th width="12%"></th>
				<th width="30%">상품명</th>
				<th width="11%">수량</th>
				<th width="14%">상품금액</th>
				<th width="14%">합계금액</th>
				<th width="15%">배송비</th> 
			</tr>
			<c:set var="flag" value="${true}"></c:set>
			<c:set var="delivery_fee" value="${0}"></c:set>
			<c:set var="cart_cnt" value="${cart_cnt}"></c:set>
			<c:set var="i" value="${0}" />
			<c:choose>
				<c:when test="${cart_cnt eq 0}">
					<tr><td colspan="7">장바구니가 비었습니다.</td></tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="cart" items="${cartList}" varStatus="status">
						<c:set var="product" value="${productList[i]}" />
						<tr>
							<td>
								<input type="checkbox" name="cart_chk" checked>
								<input type="hidden" name="chk_product_id" value="${product.product_id}">
								<input type="hidden" name="chk_product_amount" value="${cart.product_amount}">
								<input type="hidden" name="chk_product_price" value="${ product.product_sale_price}">
							</td>
							<td>
								<img src="/images_yhmall/${ product.product_image}" style="width:100px; float: left;" >
							</td>
							<td style="text-align: left;">
								${ product.product_name}
							</td>
							<td>
								<input type="hidden" id="cart_qty" value="${ product.product_qty}">
								<input type="number" id="cart_num" value="${ cart.product_amount}" min="1" max="999">
								<input type="hidden" id="cart_id" value="${ product.product_id}">
								<br>
								<button type="button" class="amount_btn" >수량변경</button>
							</td>
							<td><fmt:formatNumber value="${product.product_sale_price}"/>원</td>
							<td style="font-weight:bold;">
							 	<fmt:formatNumber value="${cart.product_amount * product.product_sale_price}"/>원
							 </td>
							<c:if test="${flag eq true }">
								<td rowspan="${cart_cnt}">
									<span>4만원이상무료</span><br>
									<span class="delivery_Fee"></span>원<br>
									<span>(택배-선결제)</span>
									<c:set var="flag" value="${false}"/>								
								</td>
							</c:if>
						</tr>
						<c:set var="i" value="${i+1}" />
					</c:forEach>
				</c:otherwise>			
			</c:choose>
		</form>
	</table>
	<c:if test="${cart_cnt ne 0}">
		<div id="delete_btns">
			<button id=delete_btn>선택 상품 삭제</button>
			<button id=none_btn>버튼</button>
		</div>
	</c:if>
	<div id="order_info">
		<p>
			총 <span id="selected_cnt">${cart_cnt}</span>개의 상품금액&nbsp;<span id="final_price1"></span>&nbsp;원,&ensp;&ensp; &ensp;
			<img src="../resources/icons/plus.png" width="24px">&ensp;&ensp;&ensp;
			배송비&nbsp;<span id="final_price2" class="delivery_Fee"></span>&nbsp;원&ensp;&ensp;&ensp;
			<img src="../resources/icons/equal.png" width="24px">&ensp;&ensp;&ensp;
			<span id="final_price3"></span>&nbsp;원
		</p>
	</div>
	<c:if test="${cart_cnt ne 0}">
		<div id="order_btns">
				<input type="button" id="se_purchase_btn" value="선택 상품 주문">
				<input type="button" id="all_purchase_btn" value="전체 상품 주문">
		</div>
	</c:if>
</div>
	<jsp:include page="../common/footer.jsp"></jsp:include>
</html>