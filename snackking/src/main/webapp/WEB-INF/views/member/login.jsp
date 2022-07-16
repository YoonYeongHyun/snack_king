<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/member/login.css">
</head>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
document.addEventListener("DOMContentLoaded", function(){
    let form = document.LoginForm;
    let btn_login = document.getElementById("btn_login");
    /*
    btn_login.addEventListener("click", function(){
    
   		if(!form.id.value){
    		alert('아이디를 입력하시오!');
    		return;
   		}
   		if(!form.pwd.value){
    		alert('비밀번호를 입력하시오!');
    		return;
    	}

    	//http 속성: 연결상태를 유지하지않음
    	// cookie, session: 연결상태를 유지함
    	// cookie: 연결정보를 클라이언트쪽에 저장
    	// session: 연결정보를 서버에 저장
		// escape() 함수: *,-, _, +, ., / 를 제외한 모든문자를 16진수로 변환하는 함수  	    
		// 쉼표, 세미콜론 등과 같은 문자가 쿠키에서 사용되는 문자열과 충돌을 방지하기 위해 사용

    	let chk = document.getElementById("chk");	    	
		let now = new Date();
		let name = "cookieId";
		let value = form.id.value;
    	if(chk.checked){// 체크박스가 체크되었을 때 -> 쿠키 생성, 쿠키 만료시간 설정
    		now.setDate(now.getDate()+14); //만료시간을 지금으로부터 7일뒤로 설정
    		
    	}else {                      // 체크박스가 체크되지 않았을 때 -> 쿠키 삭제 
			now.setDate(now.getDate()+0);
		}
    	document.cookie = name + "=" + escape(value) + ";path=/;expires=" + now.toGMTString() + ";";
    	form.submit();
    });

	
	if(document.cookie.length > 0){// 쿠기가 존재할 경우
		var cookieData = document.cookie;
		var search = "cookieId="; //쿠키아이디값을 찾음
		var idx = cookieData.indexOf(search); //인덱스를 못찾을경우 -1출력 
		if(idx != -1){ //인덱스를 찾은경우
			idx += search.length;
			var end = cookieData.indexOf(';', idx);
			
			if(end == -1){
				end = document.cookie.length;
			}
			form.id.value = document.cookie.substring(idx, end);
			form.chk.checked = true;	
		}
	}*/
});


$(document).ready(function(){
	$('#btn_login').on("click", function(e){
		
		if(!$('#id').val()){
    		alert('아이디를 입력하시오!');
    		return;
   		}
   		if(!$('#pwd').val()){
    		alert('비밀번호를 입력하시오!');
    		return;
    	}
   		let id = $('#id').val();
	    let pwd = $('#pwd').val();
	    
	    $.ajax({
	        type:'post',
	        url:'/member/login',
	        data : {id : id, pwd : pwd},
	        success:function(data){       	
	        	if(data == "success"){
	        		location="../main";
	        	}else if(data == "error_id"){
					alert("해당 회원정보를 찾을 수 없습니다.");	        		
	        	}else if(data == "error_password"){
	        		alert("아이디 또는 비밀번호를 확인하시길 바랍니다.");
	        	}
	        },
	        error:function (data) {
	           alert("오류가 발생하였습니다.");
	        }
	    })
	})
})

</script>
</head>
<body>

<jsp:include page="../common/header.jsp">
		<jsp:param name="memberId" value="${memberId}"/>
</jsp:include>

<jsp:include page="../common/sideBar.jsp">
		<jsp:param name="memberId" value="${memberId}"/>
</jsp:include>
<div id="container" >
<form action="" method="post" name = "LoginForm">
	<div class="f_input">
		<div class="f_id"><input type="text" id="id" name="id" class="c_id" placeholder="아이디" size="50"></div>
		<div class="f_pwd"><input type="password" id="pwd" name="pwd" class="c_pwd" placeholder="비밀번호" size="50"> </div>
		<div class="f_chk"> 
			<input type="checkbox" id="chk" class="c_chk">
			<label for="chk"> 아이디 기억 </label> 
		</div>
		<div class="f_submit"> <input type="button" value="로그인" id="btn_login" >
		</div>
	</div>
	<div class="f_a">
		<a href="#">비밀번호 찾기</a>&emsp;|&emsp;
		<a href="#">아이디 찾기</a>&emsp;|&emsp;
		<a href="/member/join">회원가입</a> 
	</div>
</form>
</div>


</body>
<jsp:include page="../common/footer.jsp"></jsp:include>
</html>