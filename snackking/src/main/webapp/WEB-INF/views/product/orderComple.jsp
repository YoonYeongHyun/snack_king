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
h1{padding-top: 30px}
.container{width: 1200px; height:auto; overflow:hidden; margin: 0 auto; padding: 20px 0;}

.order_result{float:left; width:840px; height:750px; margin: 0px auto; ; border:1px solid #ddd; border-top: 2px solid black}	
#upper_box{background:#FFFFCC;  padding-top: 30px; height: 220px}
#upper_box h2{margin:0px;}
#upper_box p{margin:0px; color:#aaa;}
#order_result_table th, td{padding: 30px; }
#order_result_table th{padding: 30px; font-weight: bold;}
.btns{margin-top:100px; text-align: center;}
.btns input{width:150px ;height: 50px; border-radius: 20px; font-size: 1em; font-weight: bold; cursor: pointer;}


.fixed{position: absolute; top:384px;}
.non_fixed{position: fixed; top:200px;}
#final_payment_box{display:inline-block; width:250px; height: 230px;  border:2px solid #ff3399; 
				   border-radius:10px; padding: 20px; margin-left: 30px; background: white; z-index: 5;}
#final_payment_1{ padding-bottom:20px; border-bottom: 1px solid #ccc;}
#final_payment_1 span{display: inline-block; width: 115px;margin: 10px auto;}
#final_payment_1 .left_span{ color:#777;}
#final_payment_1 .right_span{ text-align: right; font-weight: bold;}

#final_payment_2{ padding:20px 0;}
#final_payment_2 span{display: inline-block; margin: 10px auto; color:#ff3399; font-weight: bold;}
#final_payment_2 .left_span{width: 110px; font-size: 1em;}
#final_payment_2 .right_span{width: 130px; font-size: 1.4em;text-align: right; font-weight: bold;}
#final_payment_2 form{text-align: center; padding: 30px 0; }
#final_payment_2 input[type="button"]{width:200px; height:50px; background:#ff3399; color: white; font-size:1.3em; font-weight:bold;
cursor: pointer; border-radius:30px; border: 1px solid #eee;}

#final_confirm{position:relative; width: 250px;}
#final_confirm input{position: absolute; left: 0px; top: 0px;}
#final_confirm label{position: absolute; left: 30px; top: 0px display:inline-block; width: 200px;}	
   
</style>
<script>
window.addEventListener("scroll", (event) => { 
	scoll_top = document.querySelector('html').scrollTop;
	let final_payment_box = document.getElementById("final_payment_box")
	
	if(scoll_top>200){
		final_payment_box.className = 'non_fixed';
	}else{
		final_payment_box.className = 'fixed';
	}
});
</script>
<body>
<jsp:include page="../common/header.jsp">
		<jsp:param name="memberId" value="${memberId}"/>
</jsp:include>

<jsp:include page="../common/sideBar.jsp">
		<jsp:param name="memberId" value="${memberId}"/>
</jsp:include>
<div class="container">
	<h1>주문완료</h1>
	<div class="left_side">
		<div class="order_result">
			<div style="text-align: center;" id="upper_box">
				<img src="../resources/icons/send_money.png" width="128px">
				<h2>결제가 완료 되었습니다.</h2>
				<p>빠른시일내에 상품을 만나보세요!!</p>
			</div>
			<div>
				<table id="order_result_table">
					<tr> 
						<th width="30%">주문번호</th>
						<td><a href="@">${buy.buy_id}</a></td>
					</tr>
					<tr> 
						<th>배송정보</th>
						<td>
							<span>${buy.buyer}&ensp;${buy.buyer}&ensp;${buy.buyer_tel}&ensp;</span> <br>
							<span>${buy.buyer_addr}</span>	
						</td>
					</tr>
					<tr> 
						<th>결제수단</th>
						<td>${buy.buy_info}</a></td>
					</tr>
				</table>
				
			<div class="btns">
				<input type="button" value="쇼핑 계속하기" id="shopping_btn">
				<input type="button" value="주문 상세보기" id="confirm_btn"> 
			</div>
			</div>
			<br>
		</div>
		
	</div>
	
	<div id="final_payment_box" class="fixed">
		<h3>최종 결제정보</h3>
		<div id="final_payment_1">
			<span class="left_span">총 상품금액</span>
			<span class="right_span"><fmt:formatNumber value="${total_product_price}"/>원</span>
			<span class="left_span">배송비</span>
			<span class="right_span">+&nbsp;<fmt:formatNumber value="${delivery_fee}"/>원</span>
		</div>
		<div id="final_payment_2">
			<span class="left_span">최종 결제금액</span>
			<span class="right_span"><fmt:formatNumber value="${total_order_price}"/>원</span>
		</div>
	</div>
	
</div>
</body>
	<jsp:include page="../common/footer.jsp"></jsp:include>
</html>