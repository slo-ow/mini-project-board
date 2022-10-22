<%--==============================================================
 * @기능    index - header - Join us - 회원가입 페이지
 * @author 문성철
 * @since  2017.03.06
 * @version 1.0
 * 
===============================================================--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 달력 datepicker 스타일 정의 -->
<style>
.ui-datepicker {font-size:12px; width: 180px;}
.ui-datepicker select.ui-datepicker-month {font-size:11px; width:50%;}
.ui-datepicker select.ui-datepicker-year {font-size:11px; width:50%;}
.ui-datepicker-calendar > tbody td.ui-datepicker-week-end:first-child a {color:#f00;}
.ui-datepicker-calendar > tbody td.ui-datepicker-week-end:last-child a {color:#00f;}
</style>

<script type="text/javascript">

//전역변수 인증번호 보관
var code = 0;
//중복검사 이후의 아이디
var getID;

$(function(){
	
	//시작과동시에 ID폼으로 포커스조정
	$("#mem_id").focus();
	
	//회원가입버튼 비활성화
	$("#join_member").attr("disabled",true);
	//인증번호확인버튼 비활성화
	$("#phone_check3").attr("disabled",true);
	//비밀번호 재확인폼 비활성
	$("#inputPassword2").attr('readonly',true);
	
	//아이디 중복검사
	$("#id_check").click(function(){
		var idCk = $("#mem_id").val();
		idCk = $.trim( idCk );
		
		//유효성검사	
		var regExp = new RegExp("^[a-zA-Z0-9+]{4,16}$");
		var id = regExp.test(idCk);
		
		//유효성 검증에 성공한다면 중복검사요청
		if(id == true){
		
		$.ajax({
			'url' : '${pageContext.request.contextPath}/member/member_Ck.jsp',
			'type' : 'post',
			'data' : {
				id : idCk				
			},
			'success' : function(res){
			 	if((res.mid===idCk)){
			 		alert("입력하신 아이디는 이미 가입된 아이디 입니다.");
			 		$("#mem_id").focus();
			 		$("#mem_id").val('');
			 	}else{
			 		alert("가입가능한 아이디 입니다.");
			 		getID = $("#mem_id").val();
			 		//alert(getID);
			 		$("#mem_id").attr('readonly',true);
			 	}		 	
			},
			'dataType' : 'json'			
		});
		
		//중복검사 실패시 
		}else{
			alert("아이디는 영문/숫자조합 4~16글자만 가능합니다");
			$("#mem_id").focus();
			$("#mem_id").val('');
			return;
		}
	});
	
	
	//비밀번호 유효성 검사 , 포커스를 잃는순간에 유효성검사를 실시함
	$("#inputPassword1").blur(function(){
		var pass1 = $("#inputPassword1").val();
		var regExp = new RegExp("^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{6,16}$");
		var check = regExp.test(pass1);
		if(check == false){
			alert("비밀번호는 영문/숫자/특수문자 조합\n6글자 이상 16글자 이하로 입력하세요");
			$("#pass_chk1").html("<input type='button' class='btn btn-danger btn-sm input-sm' value=' 불 일 치 '>");
			$("#inputPassword1").val('');
			$("#inputPassword2").attr('readonly',true);
			return;
		}else{
			$("#pass_chk1").html("<input type='button' class='btn btn-primary btn-sm input-sm' value=' 일 치 '>");
			$("#inputPassword1").attr('readonly',true);
			$("#inputPassword2").attr('readonly',false);
		}
	});
	
	//비밀번호 폼 검사
	$("#inputPassword2").blur(function(){		
		var pass1 = $("#inputPassword1").val();
		var pass2 = $("#inputPassword2").val();
		
		if(pass1===pass2&&pass1!=""){
			$("#pass_chk2").html("<input type='button' class='btn btn-primary btn-sm input-sm' value=' 일 치 '>");
			$("#inputPassword2").attr('readonly',true);
		}else{
			$("#pass_chk2").html("<input type='button' class='btn btn-danger btn-sm input-sm' value=' 불 일 치 '>");
			$("#inputPassword2").val('');
			return;
		}
	});
	
	//한번만 실행되는 One함수호출
	$("#inputName").one('click',function(){		
		$("#name_chk").html("<font color='red' style='font-size:11px;'>2글자이상<br>6글자이하</font>");
	});
	
	//이름 폼 검사
	$("#inputName").blur(function(){
		var name = $(this).val();
		var regExp = new RegExp("^[가-힣]{2,5}$");
		var check = regExp.test(name);
		if(check == false){			
			$("#name_chk").html("<input type='button' class='btn btn-danger btn-sm input-sm' value=' 불 일 치 '>");
			$("#inputName").val('');
			$("#inputName").focus();
			return;
		}else{
			$("#name_chk").html("<input type='button' class='btn btn-primary btn-sm input-sm' value=' 일 치 '>");
			$("#inputName").attr('readonly',true);
		}
	})
	
	//한번만 실행되는 One함수호출
	$("#inputMail").one('click',function(){		
		$("#mail_chk").html("<font color='red' style='font-size:11px;'>이메일형식에<br>맞춰서입력</font>");
	});
	
	//이메일 폼 검사
	$("#inputMail").blur(function(){
		var mail = $(this).val();
		var regExp = new RegExp("[0-9a-zA-Z][_0-9a-zA-Z-]*@[_0-9a-zA-Z-]+(\.[_0-9a-zA-Z-]+){1,2}$");
		var check = regExp.test(mail);
		if(check == false){			
			$("#mail_chk").html("<input type='button' class='btn btn-danger btn-sm input-sm' value=' 불 일 치 '>");
			$("#inputMail").val('');
			$("#inputMail").focus();
			return;
		}else{
			$("#mail_chk").html("<input type='button' class='btn btn-primary btn-sm input-sm' value=' 일 치 '>");
			$("#inputMail").attr('readonly',true);
		}
	});
	
	//생년월일 폼 검사
	$("#inputBir").blur(function(){		
	var bir = $(this).val();
	if(bir==""){
		$("#inputBir").focus();
		return;
	}else{
		$("#inputBir").attr('readonly',true);
	}
	});
	//생년월일 달력선택
	$("#inputBir").datepicker({		
		dateFormat: 'yy-mm-dd', // 텍스트 필드에 입력되는 날짜 형식
		prevText: '이전 달', // prev 아이콘의 툴팁
		nextText: '다음 달', // next 아이콘의 툴팁
		monthNamesShort:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'], // 월의 한글 형식
		dayNamesMin:['일','월','화','수','목','금','토'], // 요일의 한글 형식
		changeMonth: true, // 월을 바꿀수 있는 셀렉트 박스를 표시한다.
		changeYear : true, // 년을 바꿀수 있는 셀렉트 박스를 표시한다.
		showMonthAfterYear: true, // 월, 년순의 셀렉트 박스를 년,월 순으로 바꿔준다.
		yearRange: 'c-100:c' // 년도 선택 셀렉트박스를 현재 년도에서 이전, 이후로 얼마의 범위로 표시할것인가.
	});
	
	//우편번호,상세주소 폼 막아두기
	$("#addr1").attr('readonly',true);
	$("#addr2").attr('readonly',true);	
	
	//핸드폰 인증번호 요청
	$("#phone_check").click(function(){
 				
 		var pnum = $("#p_number2").val(); 		
 		//alert(pnum);
		var regExp = new RegExp("^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})([0-9]{3,4})([0-9]{4})$");
		var check = regExp.test(pnum);
		if(check == false){			
			alert("올바르지않은 핸드폰 번호입니다\n다시입력하세요");
			$("#p_number2").val('');
			$("#p_number2").focus();
			return;
		}else{
			alert("인증번호 발송완료 !\n 10초 이내로 인증번호를 입력해주세요");
			$.ajax({
				'url' : 'sendSMS',
				'type': 'post',
				'data' : {
					pnum : pnum
				},
				'success' : function(res){
					//alert(res);
					//비교를위해 전역변수에 보관
					code = res.number;
					//setTimeout을 정지시키기위해 변수설정 C_ID
					C_ID = setTimeout(function(){
			 			alert("인증번호 요청시간이 지났습니다 : [제한시간 10초]");
			 			//인증번호 확인버튼 비활성화
			 			$("#phone_check3").attr("disabled",true);
			 			//인증번호 폼 초기화
			 			$("#phone_check2").val('');
			 		},10000);
					//올바른핸드폰번호를 입력했을경우 랜덤한 인증번호6자리를 리턴										
					$("#phone_check2").val(res.number);
					//인증번호확인버튼 활성화
					$("#phone_check3").attr("disabled",false);
				},
				'dataType' : 'json'
				
			});
		}
	});
	
	//인증번호확인요청
	$("#phone_check3").click(function(){
		//TimeOut 중지
		//setTimeout의 변수를 찾아서 해당 Timeout을 정지시킨다.
		clearTimeout(C_ID);
		//alert(code + " 인증번호확인");
		//인증번호 폼의 value값 읽어옴
		var check = $("#phone_check2").val();
		//alert(check + " 폼 번호확인");
		//인증번호가없거나 폼의 값과 다르다면 회원가입을 할수없음
		if(check==""||check!=code){
			alert("올바른 인증번호를 입력해주세요");
			//인증번호 확인버튼 비활성화
 			$("#phone_check3").attr("disabled",true);
 			//인증번호 폼 초기화
 			$("#phone_check2").val('');
			return;
		}else{
			alert("인증성공");
			//회원가입버튼 활성화
			$("#join_member").attr("disabled",false);
			$("#p_number2").attr("readonly",true);
			$("#phone_check2").attr("readonly",true);
			$("#phone_check3").attr("disabled",true);
			$("#phone_check").attr("disabled",true);
			$("#p_number1").attr("disabled",true);
		}
	})
	
	
	//회원가입전송
	$("#join_member").click(function(){
		//아이디폼 검사
		if(Memberform.mem_id.value == ""){
			alert("아이디를 입력하세요");
			Memberform.mem_id.focus();
			return;
		}
		//아이디 검사, 아이디입력폼의 아이디와 중복검사를마친 아이디가 같지않다면 가입실패
		if(Memberform.mem_id.value != getID){ 
			alert("아이디가 옳바르지않습니다\n아이디 중복검사를 해주세요!");
			Memberform.mem_id.focus();
			return;
		}
		//비밀번호 폼 검사
		if(Memberform.mem_pass.value == ""){
			alert("비밀번호를 입력하세요");
			//Memberform.mem_pass.focus();
			return;
		}
		var pass2 = $("#inputPassword2").val();
		//비밀번호 확인 폼 검사
		if(pass2==""){
			alert("비밀번호 재확인을 해주세요");
			$("#inputPassword2").focus();
			return;
		}
		//이름 폼 검사
		if(Memberform.mem_name.value == ""){
			alert("이름을 입력하세요");
			Memberform.mem_name.focus();
			return;
		}
		//이메일 폼 검사
		if(Memberform.mem_mail.value == ""){
			alert("이메일을 입력하세요");
			Memberform.mem_mail.focus();
			return;
		}
		//생년월일 폼 검사
		if(Memberform.mem_bir.value == ""){
			alert("생년월일을 입력하세요");
			Memberform.mem_bir.focus();
			return;
		}
		//생년월일 폼 검사
		if(Memberform.mem_bir.value == ""){
			alert("생년월일을 입력하세요");
			Memberform.mem_bir.focus();
			return;
		}
		//우편번호 폼 검사
		if(Memberform.mem_addr1.value == ""){
			alert("우편번호를 입력하세요");
			Memberform.mem_addr1.focus();
			return;
		}
		//상세주소 폼 검사
		if(Memberform.mem_addr2.value == ""){
			alert("상세주소를 입력하세요");
			Memberform.mem_addr2.focus();
			return;
		}
		//휴대전화번호 폼 검사
		if(Memberform.mem_phone.value == ""){
			alert("휴대전화번호를 입력하세요");
			Memberform.mem_phone.focus();
			return;
		}
		
		//모든조건에 만족한다면 회원가입성공
		success = 1;
		
		//회원가입 성공여부
		if(success===1){			
			Memberform.submit();
		}else{
			alert("회 원 가 입 실 패\n똑바로 입력안하면 너만힘들어진다");
			//입력폼 전체 초기화
			$("#join_form").each(function(){  
		      this.reset();  
		    }); 
			success = 0;
			return false;
		}
	});
});

//뒤로가기
function back_home(){	
	location.href="${pageContext.request.contextPath}/index.jsp";
};

</script>
    <div class="section">
      <div class="container">
        <div class="row">
          <div class="col-md-12">
            <div class="page-header text-center">
              <h1 class="text-primary">회원가입
                <i class="fa fa-2x fa-fw fa-user-plus s text-primary"></i>
              </h1>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="section">
      <div class="container">
        <div class="row">
          <div class="col-md-3"></div>
          <div class="col-md-7">
          
          <!-- ///////////////////// form start /////////////////////////-->
            <form class="form-horizontal" name="Memberform" id="join_form" method="POST" action="${pageContext.request.contextPath}/MemberJoin">
              <div class="form-group">
                <div class="col-sm-2 text-right">
                  <label for="inputId" class="control-label">*</label>
                </div>
                <!-- ID -->
                <div class="col-sm-6">
                  <input type="text" class="form-control input-sm" name="mem_id" placeholder="아이디" id="mem_id" 
                  pattern="[a-z\d]{4,16}" title="아이디는 숫자포함 4글자이상 16글자 이하로 입력하세요" required>
                </div>
                <!-- 중복검사 -->
                <div class="col-sm-2">
                  <input type="button" class="btn btn-primary btn-sm input-sm" id="id_check" value="중복검사">
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-2 text-right">
                  <label for="inputPassword3" class="control-label">*</label>
                </div>
                <!-- PASS -->
                <div class="col-sm-6">
                  <input type="password" class="form-control input-sm" id="inputPassword1" name="mem_pass" placeholder="비밀번호" 
                  pattern="^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{6,16}$" title="비밀번호는 영문+숫자+특수문자 조합 6글자 이상 16글자 이하로 입력하세요" required>
                </div>
                <!-- PASS 확인여부 -->
                <div class="col-sm-2">
                  <span id="pass_chk1"></span>
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-2 text-right">
                  <label for="inputPassword3" class="control-label">*</label>
                </div>
                <!-- PASS 재확인 -->
                <div class="col-sm-6">
                  <input type="password" class="form-control input-sm" id="inputPassword2" placeholder="비밀번호 재확인">
                </div>
                <!-- PASS 확인여부 -->
                <div class="col-sm-2">
                  <span id="pass_chk2"></span>
                </div>
              </div>
              <hr>
              <div class="form-group">
                <div class="col-sm-2 text-right">
                  <label for="inputEmail3" class="control-label">*</label>
                </div>
                <!-- 이름 -->
                <div class="col-sm-6">
                  <input type="text" class="form-control input-sm" id="inputName" name="mem_name" placeholder="이름">
                </div>
                 <!-- 이름 확인여부 -->
                <div class="col-sm-2">
                  <span id="name_chk"></span>
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-2 text-right">
                  <label for="inputEmail3" class="control-label">*</label>
                </div>
                <!-- 성별선택 -->
                <div class="col-sm-6">
                  <div class="container-fluid text-center">
                    <label class="checkbox-inline">
                      <input type="radio" value="남자" name="mem_sex" checked>남자</label>
                    <label class="checkbox-inline">
                      <input type="radio" value="여자" name="mem_sex">여자</label>
                  </div>
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-2 text-right">
                  <label for="inputEmail3" class="control-label">*</label>
                </div>
                <!-- 이메일 -->
                <div class="col-sm-6">
                  <input type="email" class="form-control input-sm" id="inputMail" name="mem_mail" placeholder="본인확인 이메일">
                </div>
                <!-- 이메일 확인여부 -->
                <div class="col-sm-2">
                  <span id="mail_chk"></span>
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-2 text-right">
                  <label for="inputEmail3" class="control-label">*</label>
                </div>
                <!-- 생년월일 -->
                <div class="col-sm-6">
                  <input type="text" class="form-control input-sm" id="inputBir" name="mem_bir" placeholder="생년월일">
                </div>
                <!-- 생년월일 확인여부 -->
                <div class="col-sm-2">
                  <span id="bir_chk"></span>
                </div>
              </div>
              <hr>
              <div class="form-group">
                <div class="col-sm-2 text-right">
                  <label for="inputEmail3" class="control-label">*</label>
                </div>
                <div class="col-sm-3">
                  <input type="text" class="form-control input-sm" id="addr1" name="mem_addr1" placeholder="우편번호">
                </div>
                <div class="col-sm-3">
                  <!-- 공백 -->
                </div>
                <!-- 주소찾기 기능버튼 -->
                <div class="col-sm-2">
                  <input type="button" class="btn btn-danger btn-sm input-sm" onclick="sample6_execDaumPostcode()" value="주소 검색">
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-2 text-right">
                  <label for="" class="control-label"></label>
                </div>
                <!-- 주소 (상세주소) -->
                <div class="col-sm-6">
                  <input type="text" class="form-control input-sm" id="addr2" name="mem_addr2" placeholder="상 세 주 소">
                </div>
              </div>
              <hr>
              <div class="form-group">
                <div class="col-sm-2 text-right">
                  <label for="inputEmail3" class="control-label">*</label>
                </div>
                <!-- 휴대폰번호1 -->
              <!--   <div class="col-sm-2">
                  <select class="form-control input-sm" id="p_number1" name="phone_Num">
                    <option value="010">010</option>
                    <option value="011">011</option>
                    <option value="016">016</option>
                  </select>
                </div> -->
                <!-- 휴대폰번호2 -->
                <div class="col-sm-6">
                  <input type="text" class="form-control input-sm" id="p_number2" name="mem_phone" placeholder="휴대전화번호 -빼고입력">
                </div>
                <!-- 휴대번호 인증문자 발송 버튼 -->
                <div class="col-sm-2">
                  <input type="button" class="btn btn-info btn-sm input-sm" id="phone_check" value=" 인 증 ">
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-2 text-right">
                  <label for="" class="control-label">*</label>
                </div>
                <!-- 휴대번호 인증번호요청 확인 -->
                <div class="col-sm-6">
                  <input type="text" class="form-control input-sm" id="phone_check2" placeholder="인증번호확인">
                </div>
                <!-- 휴대번호 인증번호 결과확인 버튼 -->
                <div class="col-sm-2">
                  <input type="button" class="btn btn-info btn-sm input-sm" id="phone_check3" value=" 확 인 ">
                </div>
              </div>
              <hr>
              <div class="form-group">
              <!-- 회원가입버튼 / 모든입력 성공시 submit() -->
                <div class="col-md-3 col-sm-offset-2 text-right">
                  <button type="button" class="btn btn-sm btn-success" id="join_member">회원가입</button>
                </div>
              <!-- 메인화면으로 돌아가기 -->
                <div class="col-md-4  text-left">
                  <button type="button" class="btn btn-sm btn-success" onclick="back_home();">돌아가기</button>
                </div>
              </div>
            </form>
            <!-- //////////////////////////// form end //////////////////////////////-->
          </div>
        </div>
      </div>
    </div>

