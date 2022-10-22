$(function(){
	
	//요청받은 페이지로 content의 내용을 바꿔주는 함수
	listf = function(urls){
		$('#index_content').load(urls);
		
	}
	
  	//로그아웃버튼 감추기
// 	$("#logout").attr("disabled",true);
	$("#logout").css("display","none");
  		
	
  	//로그아웃 클릭하면 로그인 버튼 활성화,문자 감추고 세션지우기   		
	$("#logout").click(function(){
// 		$("#login").attr("disabled",false);
// 		$("#logout").attr("disabled",true);
		$("#login").css("display","inline");
		$("#logout").css("display","none");
		
		$.ajax({
			'url' : 'login/logOut.jsp'
		});
		/*var url = "login/logOut.jsp";
		$(location).attr('href',url);*/
	});
  	
  	//로그인세션을 읽어옴
	var log = $("#loginUser").text();	
	if(log!=""){
		//로그인하면 로그인 버튼 비활성화   		
// 		$("#login").attr("disabled",true);
// 		$("#logout").attr("disabled",false);
		$("#login").css("display","none");
		$("#logout").css("display","inline");
		$("#loginUser").append('님 환영합니다');
	}
});
