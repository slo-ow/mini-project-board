 <%--==============================================================
 * @기능    index 메인 header화면
 * @author 문성철
 * @since  2017.03.05
 * @version 1.0
 * 
===============================================================--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="navbar navbar-default navbar-static-top" id="nav">
	<div class="container">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target="#navbar-ex-collapse">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand"><img height="20" alt="Brand"
				src="images/brand.png"></a>
		</div>
		<div class="collapse navbar-collapse" id="navbar-ex-collapse">
			<ul class="nav navbar-nav navbar-right" id="uls">
				<li><a href="#" id="home">Home<i class="fa fa-fw fa-home"></i></a></li>
				<li><a href="#" id="Join_us">Join us<i class="fa fa-fw fa-user"></i></a></li>
				<li><a href="#">Gellery<i class="fa fa-fw fa-instagram"></i></a></li>
				<li><a href="#">Contact<i class="fa fa-fw fa-map-marker"></i></a></li>
				<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">Board<i class="fa fa-fw fa-pencil"></i><span class="caret"></span></a>
			        <ul class="dropdown-menu" id="uls2">
			        <!-- 게시판페이지는 하나로 value를 구분자로사용해서 list를 출력함 -->
			          <li value="1"><a href="#" id="board_1">공지사항게시판</a></li>
			          <li value="2"><a href="#" id="board_2">자유게시판</a></li>
			        </ul>
		        </li>
			</ul>
			<ul class="nav navbar-nav navbar-right"></ul>
			<a class="btn btn-warning btn-xs navbar-btn navbar-right"
				data-target="#myModal2" id="logout" data-toggle="modal">LogOut<i
				class="fa fa-fw fa-lock"></i></a> <a
				class="btn btn-warning btn-xs navbar-btn navbar-right"
				data-toggle="modal" data-target="#myModal" id="login">Login<i
				class="fa fa-fw fa-unlock"></i></a>
			<p class="navbar-left navbar-text">MINI BOARD HOMEPAGE</p>
			<!-- 로그인 하면 유저 닉네임 들어오는 부분 -->
			<%
				HttpSession ses = request.getSession();
				String loginUser = (String)ses.getAttribute("USEROK");
				//로그인을 했다면
				if(loginUser!=null){
			%>		
			<p class="navbar-left navbar-text" id="loginUser"><%=loginUser %></p>
			<%
			}
			%>
		</div>
	</div>
</div>