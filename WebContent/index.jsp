 <%--==============================================================
 * @설명    index 메인화면
 * @author 문성철
 * @since  2017.03.05
 * @version 1.0
 * 
===============================================================--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//페이지 로드
request.setCharacterEncoding("UTF-8");
String contentPage = request.getParameter("contentPage");
if(contentPage == null){
	//main 화면 로드시 보여지는 화면
	contentPage = "./layout/Mini_content.jsp";
}

%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MiniHome</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- include 파일은 항상 최상단으로 먼저 읽어와야함. -->
<%@include file="./Content/main_js.jsp" %>
<%@include file="./Content/main_css.jsp" %>
<link href="index.css" rel="stylesheet" type="text/css">
<link href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="./js/main_js/main.js"></script>
<!-- 다음지도 -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<!-- jQuery UI JS -->
<script type="text/javascript" src="./js/jquery-ui.min.js"></script>
<!-- jQuery UI CSS (CDN) -->
<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
<style>
     #nav{background-color:black;}
     a{color:black;}
     #news p{color:black;}
     #nav p{color:white;}
     #uls a{color:white; background-color:black;}
     #uls2 li > a:hover{background-color:#f0f0f0;}
     #login, #logout{margin-right:20px;}
     #navh a:hover {background-color:#fffff6;}
     #modal1, #modal2{top:350px;}
     #footer{background-color:black;}
     #footer h1, p {color:white;}
	 .carousel-inner > .item > img,
	 .carousel-inner > .item > a > img {
	      width: 1000%;
	      height:130px;
	      margin: auto;
	  }
	 
	 <!-- 드롭다운 메뉴 색상변경 -->
	.navbar-default .navbar-nav > .open > a,
	.navbar-default .navbar-nav > .open > a:hover,
	.navbar-default .navbar-nav > .open > a:focus {
	  background-color: black;
	  color: #000000;
	}
	
	.navbar-nav > li > .dropdown-menu {
    	background-color: black;
	}
	
	body{
		overflow:scroll; 
	}
</style>
<script type="text/javascript">
	$(function(){
		
		// 회원로그인 처리를위한 Ajax
		$("#check_id").click(function(){
			var id = $("#mem_id").val();
			var pass = $("#mem_pass").val();
			$.ajax({
				'url' : '${pageContext.request.contextPath}/login/loginCheck.jsp',
				'type' : 'post',
				'data' : {
					id : id,
					pass : pass
				},
				'success' : function(res){
				 	if((id==res.mid&&pass==res.mpass)){
				 		alert("로그인 성공");
				 		location.reload();
				 	}		 	
				},
				'error' : function(){
					alert("로그인 실패");
					location.reload();
			 		//location.href="member/Join.jsp";
				},
				'dataType' : 'json'
				
			});
		});
	
		// 로그아웃 누르고 확인 버튼눌렀을때 reload 시킴
		$("#out_check").click(function(){
			location.reload();	
		});
		
		//header부분 home 클릭
		$("#home").click(function(){
			location.href="${pageContext.request.contextPath}/index.jsp";
		});
		
		//header부분 드롭다운메뉴 클릭시 동작
		//게시판구분
		
		// 1.공지사항 게시판
		$("#board_1").click(function(){
			//헤더에있는 li태그의 val값을 읽어와서 게시판구분확인
			var val = $("#uls2 > li:eq(0)").val();
			//alert(val);
			//location.href="${pageContext.request.contextPath}/index.jsp?contentPage=board/Board.jsp?Pages="+val+"";			
			location.href="${pageContext.request.contextPath}/selectboard?gubun="+val+"";			
		});
		// 2.자유게시판
		$("#board_2").click(function(){
			//헤더에있는 li태그의 val값을 읽어와서 게시판구분확인
			var val = $("#uls2 > li:eq(1)").val();
			//alert(val);
			//location.href="${pageContext.request.contextPath}/index.jsp?contentPage=board/Board.jsp?Pages="+val+"";
			location.href="${pageContext.request.contextPath}/selectboard?gubun="+val+"";
		});		
		
		//member/Join 회원가입페이지
		$("#Join_us").click(function(){
			listf("${pageContext.request.contextPath}/member/Join.jsp");
		});		
				
	});
	
	// 다음 주소찾기 API 불러오기
	function sample6_execDaumPostcode() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            var fullAddr = ''; // 최종 주소 변수
	            var extraAddr = ''; // 조합형 주소 변수

	            // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                fullAddr = data.roadAddress;

	            } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                fullAddr = data.jibunAddress;
	            }

	            // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
	            if(data.userSelectedType === 'R'){
	                //법정동명이 있을 경우 추가한다.
	                if(data.bname !== ''){
	                    extraAddr += data.bname;
	                }
	                // 건물명이 있을 경우 추가한다.
	                if(data.buildingName !== ''){
	                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
	                fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
	            }

	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	            document.getElementById('addr1').value = data.zonecode; //5자리 새우편번호 사용
	            document.getElementById('addr2').value = fullAddr;

	            // 커서를 상세주소 필드로 이동한다.
	            document.getElementById('addr2').focus();
	        }
	    }).open();
	}
</script>
</head>
  <body>
   	<!-- header -->
   	<div id="index_header">
		<jsp:include page="./layout/Mini_header.jsp"/>   	
   	</div>
	<!-- main -->
	<div id="index_main">
	    <jsp:include page="./layout/Mini_main.jsp"/>
	</div>    
	<!-- content -->   
	<div id="index_content">
    	<jsp:include page="<%=contentPage %>"/>	
	</div>
    
    
    <!--modal 로그인 모달 -->
<%-- <form class="form-horizontal" role="form" action="${pageContext.request.contextPath}/loginCheck" method="get"> --%>
<form class="form-horizontal" role="form" id="loginForm">
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static" data-keyboard="false">
      <div class="modal-dialog modal-sm">
        <div class="modal-content" id="modal1">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h3 class="modal-title text-center" id="modal">LOGIN</h3>
          </div>
          <div class="modal-body">
          <!-- 로그인 요청 -->
              <div class="form-group has-success">
                <div class="col-sm-2">
                  <label for="inputEmail3" class="control-label">ID</label>
                </div>
                <div class="col-sm-10">
                  <input type="text" class="form-control input-sm" id="mem_id" placeholder="ID" name="mem_id">
                </div>
              </div>
              <div class="form-group has-success">
                <div class="col-sm-2">
                  <label for="inputPassword3" class="control-label">PW</label>
                </div>
                <div class="col-sm-10">
                  <input type="password" class="form-control input-sm" id="mem_pass" placeholder="Password" name="mem_pass">
                </div>
              </div>
          </div>
          <div class="modal-footer">
            <input type="button" class="btn btn-primary" value="Login" id="check_id">
            <a class="btn btn-danger" data-dismiss="modal">Close</a>
          </div>
        </div>
      </div>
    </div>
</form>
    
    <!--modal2 로그아웃 모달-->
    <div class="fade modal" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static" data-keyboard="false">
      <div class="modal-dialog modal-sm">
        <div class="modal-content" id="modal2">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h3 class="modal-title text-center" id="modal">LOGOUT</h3>
          </div>
          <div class="modal-body">
            <div class="row">
              <div class="col-md-12 text-center">
                <i class="fa fa-5x fa-fw fa-power-off text-primary"></i>
                <p class="text-primary">로그아웃 성공</p>
              </div>
            </div>
          </div>
           <div class="modal-footer" style="text-align:center;">
            <a class="btn btn-danger" id="out_check" data-dismiss="modal">확인</a>
          </div>
        </div>
      </div>
    </div>
    
    <!-- footer -->
    <div id="index_footer">
		<jsp:include page="./layout/Mini_footer.jsp"/>  
    </div>
</body>
</html>