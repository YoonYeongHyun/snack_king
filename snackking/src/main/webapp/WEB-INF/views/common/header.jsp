<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<style>

@import url('https://fonts.googleapis.com/css2?family=Black+Han+Sans&display=swap');

body{margin: 0 auto; font-family: 'Gothic A1', sans-serif;}
a {text-decoration: none; color:black;}
ul{list-style-type: none;}
li{float: left;}


#top_menu{width:1200px; margin:0 auto; height: 40px;}
#top_menu ul{display: inline-block; margin:0; padding:9.5px; float: right;}
#top_menu ul li{margin-left: 20px;}
.hide_top_menu{display: none;}

#upper_header {width:100%; padding:30px 0; border-bottom: 1px solid #eee; margin:0 auto;}
.inner_contents{width:1200px; margin:0 auto; height: 90px}
#main_logo{width:340px;  height: 51px; padding: 19px 0; display: inline; float: left;}
#main_logo a{font-family: 'Black Han Sans', sans-serif; font-size: 50px; color:#eeaa00;}
#search_box{width:400px; height:48px; display: inline-block; border: 1px solid #FFBB00; ;
			border-radius: 30px; margin:20px 0 20px 100px; }
#search_input{float: left; font-size: 1.5em; margin:10px 10px 7px 20px; border:none;}
#search_input:focus{outline: none;}
#search_icon{float: right; height: 32px; cursor: pointer; margin:8px 20px 8px 0;}
#header_btns{display: inline-block; width:200px; height:50px; float:right; padding:20px 0 ;}
#header_btns ul{width:200px; height:40px; margin:0 0 ;padding:5px}
#header_btns li{float: left; margin:0 0 30px 30px;}

#lower_header{width: 100%; height: 60px; border-bottom: 1px solid #eee; margin:0; box-sizing: content-box; background: white; 
				position: sticky; top:0; z-index: 3;}
#lower_header nav{height: 60px; position: relative; z-index: 2;}
#lower_header ul{width:1200px; height: 60px; margin:auto; padding:0; display:inline-block; text-align: center;}
#lower_header li{height: 60px; padding:15px; margin:0 0 0 30px; display:inline-block; font-size: 1.2em; box-sizing: border-box; line-height: 35px}
#lower_header li:hover{font-weight: bold; border-bottom: 3px solid #F29661;}
#lower_header li div a{font-size: 0.7em; height: 20px; margin-bottom: 5px;}
#lower_header li div a:hover{font-size: 0.9em; font-weight: bold;}

#hidden_box1{left:395px;}
#hidden_box2{left:538px;}
#hidden_box3{left:680px;}
#hidden_box4{left:785px;}
.hidden_menu{width:150px; height:80px; position: absolute; bottom:-92px; border: 1px solid #eee; margin: auto; 
			display: none; z-index: 1; background: white; padding:5px}
.hidden_btn{font-size: 0.8em; color:#666; display: block;}
.hidden_btn:hover{font-size: 1em; color:black; display: block;}
</style>
<% 
request.setCharacterEncoding("UTF-8");
String product_id = request.getParameter("product_id");
String memberId = request.getParameter("memberId");
if(memberId == ""){
	memberId = "";
}
System.out.println(memberId);
%>
<script>
document.addEventListener("DOMContentLoaded", function(){
	let memberId = "<%=memberId%>";
	if(memberId == ""){
		let top_login = document.getElementById("top_login");
		let top_join = document.getElementById("top_join");
		top_login.style.display="inline-block";
		top_join.style.display="inline-block";
	}
	if(memberId != ""){
		let top_logout = document.getElementById("top_logout");
		top_logout.style.display="inline-block";
	}
	
	let showing_btn = document.getElementsByName("showing_btn");
	showing_btn.forEach(element => element.addEventListener("mouseenter", function(e){
		let hidden_menu = e.target.lastChild.previousSibling;
		hidden_menu.style.display="inline-block"
	}));
	showing_btn.forEach(element => element.addEventListener("mouseleave", function(e){
		let hidden_menu = e.target.lastChild.previousSibling;
		hidden_menu.style.display="none"
	}));
	
	let search_icon = document.getElementById("search_icon");
	search_icon.addEventListener("click", function(){
	let search_input = document.getElementById("search_input").value;
	location="../shopping/shoppingAll.jsp?code=2&search=1" + search_input;
	});
	
	let top_logout = document.getElementById("top_logout");
	top_logout.addEventListener("click", function(){
			window.open('../logon/memberLogout.jsp',"PopupWin",'width = 500, height = 200 left = 740');
			setTimeout(function(){
				location.reload();
			},500);
	});
})

</script>
<div id="top_menu">
	<ul>
		<li class="hide_top_menu" id="top_login">
			<a href="/member/login">로그인</a>
		</li>
		<li class="hide_top_menu" id="top_join">
			<a href="/member/join" >회원가입</a>
		</li>
		<li class="hide_top_menu" id="top_logout">
			<a href="#">로그아웃</a>
		</li>
		<li>
			<a href="@">마이페이지</a>
		</li>
		<li>
			<a href="@" >고객센터</a>
		</li>
	</ul>
</div>
<div id="upper_header">
	<div class="inner_contents">
		<div id="main_logo" ><a href="/main">Snack King</a></div>
		<div id="search_box">
			<input type="text" id="search_input" placeholder="<% if(memberId != ""){out.print(memberId+'님');} %> 어서오세요!!">
			<span id="search_icon"><img src="../resources/icons/search_icon1.png" width="32px"></span>
		</div>
		<div id="header_btns">
			<ul>
				<li>
					<a>
						<img src="../resources/icons/main_heart.png">
					</a>
				</li>
				<li>
					<a href="/productCart">
						<img src="../resources/icons/main_cart.png">
					</a>
				</li>
				<li>
					<a>
						<img src="../resources/icons/main_login.png">
					</a>
				</li>
			</ul>
		</div>
	</div>
</div>
	<div id="lower_header">
		<nav class="inner_contents" id="header_nav">
	        <ul>
    	        <li><a href="/productList?subject=1">인기상품</a></li>
                <li><a href="/productList?subject=1">특가상품</a></li>
                <li><a href="/productList?category=5">세트상품</a></li>
                <li name="showing_btn">
        	      	<a href="/productList?category=1">과자</a>
                   	<div class="hidden_menu" id="hidden_box1">
             		<a href="/productList?category=101" class="hidden_btn">파이류</a>
               		<a href="/productList?category=102" class="hidden_btn">비스킷류</a>
               		<a href="/productList?category=103" class="hidden_btn">스넥류</a>
               	</div>
            </li>
            <li name="showing_btn">
              	<a href="/productList?category=2">껌/초콜릿/사탕</a>
               	<div class="hidden_menu" id="hidden_box2">
               		<a href="/productList?category=201" class="hidden_btn">껌</a>
               		<a href="/productList?category=202" class="hidden_btn">초콜릿</a>
              		<a href="/productList?category=203" class="hidden_btn">사탕</a>
               	</div>
         	</li>
            <li name="showing_btn">
               	<a href="/productList?category=3">라면</a>
               	<div class="hidden_menu" id="hidden_box3">
               		<a href="/productList?category=301" class="hidden_btn">봉지라면</a>
              		<a href="/productList?category=302" class="hidden_btn">컵라면</a>
               	</div>
            </li>
          	<li name="showing_btn">
               	<a href="/productList?category=4">음료</a>
               	<div class="hidden_menu" id="hidden_box4">
               		<a href="/productList?category=401" class="hidden_btn">탄산음료</a>
               		<a href="/productList?category=402" class="hidden_btn">이온음료</a>
               		<a href="/productList?category=403" class="hidden_btn">주스</a>
               	</div>
            </li>
	        <li><a href="/productList?category=6">수입과자</a> </li>
   		</ul>
  	</nav>
</div>