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
.container{width: 1200px; height:auto; overflow:hidden; margin: 0 auto; padding: 20px 0;}
.order_box{float:left; width:870px; height:auto; margin: 30px auto;}	
input[type="text"]:focus{outline: none;}

table {border-top: 1px solid black; border-collapse: collapse; width: 100%;}
#product_table td, #product_table th{padding: 20px 0; text-align: center; vertical-align: middle; border-bottom: 1px solid #ddd;}
#product_table td{height: 100px}

.h2_side{display:inline-block; width:750px; text-align: right; font-size: 16px; margin:0px;}
#order_table {border-top: 1px solid black; border-bottom: 1px solid #aaa; padding: 20px 0; display: inline-block; float: right;}
#order_table th{ text-align: left; padding: 25px; font-size: 1.1em; font-weight:bolder;}
#order_table td input[type="text"]{height:30px; font-size: 16px; padding: 6px 16px; border: 1px solid #aaa;}
#order_table td input[type="text"]:not(#delivery_addr0){ width:300px;}
#delivery_addr0{ width:600px;}
#order_table td p{display: inline-block; width: 600px}

#delivery_table {border-top: 1px solid black; border-bottom: 1px solid #aaa; padding: 20px 0; display: inline-block; float: right;}
#delivery_table th{ text-align: left; padding: 25px; font-size: 1.1em; font-weight:bolder;}
#delivery_table td input[type="text"]{ height:30px; font-size: 16px; padding: 6px 16px; border: 1px solid #aaa;}
#delivery_table td input[type="text"]:not(#delivery_addrNum, #delivery_addr1, #delivery_addr2, #delivery_addr0){width:300px;}
#delivery_addrNum{width:150px; margin-bottom:5px}
#delivery_addr1{ margin-bottom:5px; width: 600px;}
#delivery_addr2, #delivery_addr0{ width: 600px;}
#delivery_th{vertical-align: top;}
#delivery_table #addr_btn{width: 70px;height:40px; background: white; border: 1px solid #bbb; cursor: pointer; }
#delivery_table #addr_btn:hover{border: 1px solid black; font-weight: bold;}


.fixed{position: absolute; top:384px;}
.non_fixed{position: fixed; top:200px;}
#final_payment_box{display:inline-block; width:250px; height: 400px;  border:2px solid #ff3399; 
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

#final_confirm{position:relative; width: 250px; margin-top: 30px}
#final_confirm input{position: absolute; left: 0px; top: 0px}
#final_confirm label{position: absolute; left: 30px; top: 0px display:inline-block; width: 200px;}
				   
</style>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script> 
document.addEventListener("DOMContentLoaded", function(){
	document.getElementById("addr_btn").addEventListener("click", function(){
		let addrNum = document.getElementById("delivery_addrNum");
		let addr1 = document.getElementById("delivery_addr1");
		let addr2 = document.getElementById("delivery_addr2");
		//????????? ?????? ??????
        new daum.Postcode({
            oncomplete: function(data) { //????????? ????????? ??????
            	addrNum.value = data.zonecode; // ?????? ??????
                addr1.value = data.address; // ?????? ??????
                addr2.value = "";
                addr2.focus(); //???????????? ?????????
            }
		}).open();  
	});
	let final_order_btn = document.getElementById("final_order_btn");
    let final_order_chk = document.getElementById("final_order_chk");
    let recipient_addr = document.getElementById("recipient_addr");
    let delivery_addrNum = document.getElementById("delivery_addrNum").value;
    let delivery_addr1 = document.getElementById("delivery_addr1").value;
    let delivery_addr2 = document.getElementById("delivery_addr2").value;
    final_order_btn.addEventListener("click", function(){
    	if(final_order_chk.checked){
    		recipient_addr.value ="[" + delivery_addrNum + "] " + delivery_addr1 + " " + delivery_addr2;
    		
    		
    		document.forms[0].submit();
    	}else{
    		alert("?????? ????????? ?????? ??????????????????.");
    	}
    	
    	
    })
});

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
	<form action="orderComple" method="post" name="orderForm">
		<div class="order_box">
			<h1>????????????</h1>
			<table id="product_table">
				<tr> 
					<th width="14%"></th>
					<th width="36%">?????????</th>
					<th width="7%">??????</th>
					<th width="14%">????????????</th>
					<th width="14%">????????????</th>
					<th width="15%">?????????</th>
				</tr>
				<c:set var="flag" value="${true}"/>
				<c:set var="index" value="${0}"/>
				<c:set var="total_product_price" value="${0}"/>
				<c:set var="delivery_fee" value="${0}"/>
				<c:set var="product_amount_list" value="${product_amount_list}"/>
				<c:set var="member" value="${member}"/>
				<c:forEach var="product" items="${product_list}">
					<input type="hidden" name="buy_product_id" value="${product.product_id}">
					<input type="hidden" name="buy_product_amount" value="${product_amount_list[index]}">
					<input type="hidden" name="buy_product_price" value="${product.product_sale_price}">
					<tr>
						<td>
							<img src="/images_yhmall/${product.product_image}" style="width:100px; float: left;">
						</td>
						<td style="text-align: left;">
							${product.product_name}
						</td>
						<td>${product_amount_list[index]}???</td>
						<td><fmt:formatNumber value="${product.product_sale_price}"/>???</td>
						<td style="font-weight:bold;"><fmt:formatNumber value="${product_amount_list[index] * product.product_sale_price}"/>???</td>
						<c:if test="${flag}">
							<td rowspan="${product_list.size()}">
							<span>4??????????????????</span><br>
							<span id="delivery_fee_span"></span>???<br>
							<span>(??????-?????????)</span>
							</td> 
							<c:set var="flag" value="${false}"/>
						</c:if>
					</tr>
				<c:set var="total_product_price" value="${total_product_price + (product.product_sale_price*product_amount_list[index])}"/>
				<c:set var="index" value="${index+1}"/>
				</c:forEach>
				<c:choose>
					<c:when test="${total_product_price >= 40000}">
						<c:set var="delivery_fee" value="${0}"/>
					</c:when>
					<c:otherwise>
						<c:set var="delivery_fee" value="${2500}"/>
					</c:otherwise>
				</c:choose>
				<c:set var="total_order_price" value="${total_product_price + delivery_fee}"/>
				<script> 
					document.addEventListener("DOMContentLoaded", function(){
						document.getElementById('delivery_fee_span').innerHTML = ${delivery_fee}
					});
				</script>
			</table>
			<br>
			<a href="productCart"> <strong>??? ???????????? ????????????</strong></a>
		</div>
		<div class="order_box">
			<h2>???????????????<p class="h2_side"><img src="../resources/icons/check.png" width="10px">????????? ?????????????????? ?????????.</p> </h2>
			<table id="order_table">
				<tr>
					<th width="30%">????????? ??????&nbsp;<img src="../resources/icons/check.png" width="16px"></th>
					<td width="70%"><input type="text" value="${member.name}" name="buyer"></td>
				</tr>
				<tr>
					<th>??????</th>
					<td>
						<input type="text" readonly="readonly" value="[${member.addrNum}] ${member.addr1} ${member.addr2}" id="delivery_addr0" name="buyer_addr">
					</td>
				</tr>
				<tr>
					<th>????????? ??????&nbsp;<img src="../resources/icons/check.png" width="16px"></th>
					<td>
						<input type="text" value="${member.tel}" name="buyer_tel">
					</td>
				</tr>
				<tr>
					<th>?????????</th>
					<td>
						<input type="text" value="${member.email}" name="buyer_email">
					</td>
				</tr>
			</table>
		</div>
		
		<div class="order_box">
			<h2>???????????????<p class="h2_side"><img src="../resources/icons/check.png" width="10px">????????? ?????????????????? ?????????.</p> </h2>
			<table id="delivery_table">
				<tr>
					<th width="30%">??????&nbsp;<img src="../resources/icons/check.png" width="16px"></th>
					<td width="70%"><input type="text" value="${member.name}" name="recipient"></td>
				</tr>
				<tr>
					<th id="delivery_th" height="122px">??????&nbsp;<img src="../resources/icons/check.png" width="16px" style="vertical-align: top;"></th>
					<td id="delivery_td">
						<input type="text" id="delivery_addrNum" value="${member.addrNum}"> 
						<input type="button" id="addr_btn" value="????????????"> <br>
						<input type="text" id="delivery_addr1" value="${member.addr1}"> <br>
						<input type="text" id="delivery_addr2" value="${member.addr2}">
						<input type="hidden" value="" name="recipient_addr" id="recipient_addr">
						<input type="hidden" value="${total_product_price}" name="total_product_price">
						<input type="hidden" value="${delivery_fee}" name="delivery_fee">
						<input type="hidden" value="${total_order_price}" name="total_order_price">
					</td>
				</tr>
				<tr>
					<th>????????? ??????&nbsp;<img src="../resources/icons/check.png" width="16px"></th>
					<td>
						<input type="text" value="${member.tel}" name="recipient_tel">
					</td>
				</tr>
			</table>
		</div>
		<div class="order_box">
			<h2>???????????? ?????? / ?????? </h2>
			<table>
				<th>????????????</th>
				<td>
					 <input type="radio" value="????????????" name="buy_info" id="radio1" checked> <label for="radio1">????????????</label>
					 <input type="radio" value="???????????????" name="buy_info" id="radio2"> <label for="radio2">???????????????</label>
					 <input type="radio" value="????????????" name="buy_info" id="radio3"> <label for="radio3">????????????</label>
					 <input type="radio" value="???????????????" name="buy_info" id="radio4"> <label for="radio4">???????????????</label>
					 <input type="radio" value="???????????????" name="buy_info" id="radio5"> <label for="radio5">???????????????</label>
				</td>
			</table>
		</div>
	</form>
	<div id="final_payment_box" class="fixed">
		<h3>?????? ????????????</h3>
		<div id="final_payment_1">
			<span class="left_span">??? ????????????</span>
			<span class="right_span"><fmt:formatNumber value="${total_product_price}"/>???</span>
			<span class="left_span">?????????</span>
			<span class="right_span">+&nbsp;<fmt:formatNumber value="${delivery_fee}"/>???</span>
		</div>
		<div id="final_payment_2">
			<span class="left_span">?????? ????????????</span>
			<span class="right_span"><fmt:formatNumber value="${total_order_price}"/>???</span>
				<input type="button" id="final_order_btn" value="????????????"> 
				<br>
			<div id="final_confirm">
				<input type="checkbox" id="final_order_chk"> 
				<label for="final_order_chk"><strong>(??????)</strong>???????????? ????????? ?????? ????????? ???????????????.</label>
			</div>
		</div>
	</div>
</div>
</body>
	<jsp:include page="../common/footer.jsp"></jsp:include>
</html>