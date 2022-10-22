 <%--==============================================================
 * index - header - board - 공지사항,자유게시판 페이지
 * @author 문성철
 * @since  2017.03.05
 * @version 1.0
 * 
===============================================================--%>
<%@page import="kr.or.miniboard2.board.vo.BoardVO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="kr.or.miniboard2.board.service.BoardServiceImpl"%>
<%@page import="kr.or.miniboard2.board.service.BoardService"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
//문자 인코딩
request.setCharacterEncoding("UTF-8");
//로그인 세션확인
String value = (String)session.getAttribute("USEROK");
%>

<style>
#tableHeader {
	text-align: center;
}

#writemodal2 {
	top: 250px;
}

.btitle {
	text-align: center;
}

#newcom {
	font-size: 12px;
}

.date_size{
	width : 150px;
}

#dropzone
{
    border:2px dotted #008b8b;
    width:100%;
    height:80px;
    color:#92AAB0;
    text-align:center;
    font-size:24px;
    padding-top:20px;
    margin-bottom:20px;
}
.filelist > td:hover
{
	background-color:antiquewhite;
}
</style>
<script type='text/javascript'>
<%-- 검색 --%>
function check(f){
	 var type=  bform.stype.value;
     var word = bform.sword.value;
	location.href="selectboard?gubun=" + ${gubun} + "&page=" + ${page} + "&stype=" + type + "&sword=" + word;
}

//파일업로드를위한 저장공간배열
var fileCount = new Array();
<%-- 파일업로드 체크 --%>
function fileCheck()
{
	if(document.insertBoard.brd_title.value==""){
		alert("제목을 입력해주세요");
		return;
	}
	if(document.insertBoard.brd_content.value==""){
		alert("내용을 입력해주세요");
		return;
	}
	
	//비동기로 게시글작성과동시에 파일전송
	var data = new FormData();
	var title = $("#brd_title").val();
	var content = $("#brd_content").val();
	var writer = $("#brd_writer").val();
	var gubun = brd_gubun.value;
	for(var i=0; i<fileCount.length; i++){
		//alert(fileCount[i].name);
		data.append('file'+i, fileCount[i]);
	}
	data.append('title',title);
	data.append('content',content);
	data.append('gubun',gubun);
	data.append('writer',writer);
    var url = "insertboard";
    $.ajax({
       url  : url,
       type :'post',
       data : data,
       contentType:false,
       processData:false,
       'success': function() {
           //성공하면 callback 함수를 실행해서 모달창을 닫아준다.
           //alert("callback");
           //모달창 닫기
           $('#writemodal').modal('hide');
           //모달창의 내용지우기
           $("#brd_title").val('');
           $("#brd_content").val('');
           $("#dropHeader").html('');
   		   $("#dropitem").html('');
   		   //새로고침
   		   location.reload();
       },
       'dataType': 'json'
    });
	//alert(fileCount.length + "파일개수");
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
$(function(){          
	
	<%-- 검색 --%>
	 /* $("#goSeach").click(function(){
		var forms = $("#seachAll").serialize();
		$("#seachAll").submit();
				
	}); */
		
	<%-- 글쓰기 권한 확인 --%>
	$("#write").click(function(){
		if("<%=value%>"=="null"||"<%=value%>"==""){
			alert("글쓰기 권한이 없습니다.");
			return false;
		}
	});
	
	<%-- 게시글 작성 --%>	
	$("#writeBoard").click(function(){
		var forms = $("#insertBoard").serialize();
		$("#insertBoard").submit();
	});
	
	//close 모달초기화
	//취소버튼 누를시 모달폼 초기화
	$("#close").click(function(){
		//alert("close");
		$("#dropHeader").html('');
		$("#dropitem").html('');
		$("#brd_content").val('');
		$("#brd_title").val('');
	});	
	
	////파일 멀티 업로드 // 마우스 드래그 멀티파일 업로드 영역 (1)
     var obj = $("#dropzone");
     obj.on('dragenter', function (e) {
          e.stopPropagation();
          e.preventDefault();
          $(this).css('border', '2px solid #5272A0');
     });
     obj.on('dragleave', function (e) {
          e.stopPropagation();
          e.preventDefault();
          $(this).css('border', '2px dotted #8296C2');
     });
     obj.on('dragover', function (e) {
          e.stopPropagation();
          e.preventDefault();
     });
     obj.on('drop', function (e) {
          e.preventDefault();
          $(this).css('border', '2px dotted #778899');
          var files = e.originalEvent.dataTransfer.files;
          if(files.length < 1)
               return;
          
          // 사이즈체크
          var maxSize  = 50 * 1024 * 1024    //50MB
          var fileSize = new Array();
      	  var check = 1;
          
          for (var i = 0; i < files.length; i++) {        	  
       		//파일의 개수만큼 배열에 넣음
       	    fileSize[i] = files[i].size;
       		
      	  //파일확장자 제한
            var fileExt = files[i].name.split('.').pop().toLowerCase();            
           	if($.inArray(fileExt, ['gif','png','jpg','jpeg']) == -1) {   
              alert('gif, png, jpg, jpeg 파일만 업로드 할수 있습니다.');
              return;
           } 
       	 	
			//파일업로드 개수제한
			if(files.length > 5){
				alert("파일업로드 실패/최대업로드가능한 파일은 5개 입니다");
				return;
			}
	      	
        	//파일업로드 용량제한
	        if(fileSize[i] > maxSize) {
	      	    
      			iSize = fileSize[i] / 1024
      			if (iSize / 1024 > 1) {
      				if (((iSize / 1024) / 1024) > 1) {
      					iSize = (Math.round(((iSize / 1024) / 1024) * 100) / 100);
      					alert("파일업로드 실패/첨부파일 용량" + iSize +"GB\n첨부파일 용량은 50MB 이내로 등록 가능합니다.");
      					return;
      				}else{
      					iSize = (Math.round((iSize / 1024) * 100) / 100);
      					alert("파일업로드 실패/첨부파일 용량" + iSize +"MB\n첨부파일 용량은 50MB 이내로 등록 가능합니다.");
      					return;
      				}
      			}else{
      				iSize = (Math.round(iSize * 100) / 100);
      				alert("파일업로드 실패/첨부파일 용량" + iSize +"KB\n첨부파일 용량은 50MB 이내로 등록 가능합니다.");
      				return;
      			}
      			
	      	   }
	        }       
	    	
	   		//문제가없을시 업로드
	   	     F_FileMultiUpload(files, obj);  
	    	
	    });		
});          

//파일 멀티 업로드 (2)
function F_FileMultiUpload(files, obj) {
		 //파일크기를 넣어줄 배열생성
	 	 var fileSize = new Array();
		 //첨부파일목록 header 생성
         var codeHeader = "";
		 codeHeader += "<div style='text-align: center; color:darkcyan; border:dotted 2px; margin-bottom:5px;'>첨부파일목록</div>";
       	 $("#dropHeader").html(codeHeader);
       	 
    	 if(confirm(files.length + "개의 파일을 업로드 하시겠습니까?") ) {
	         var data = new FormData();
	         var codeHTML = "";
	         for (var i = 0; i < files.length; i++) {
	        	//콘솔에 파일이름과 크기를 출력
	        	console.log(files[i].name + " - " + files[i].size);
	        	//파일의 개수만큼 배열에 넣음
        	  	fileSize[i] = files[i].size;
	        	//각각 파일의 크기를 구함
	        	iSize = fileSize[i] / 1024
      			if (iSize / 1024 > 1) {
      				if (((iSize / 1024) / 1024) > 1) {
      					iSize = (Math.round(((iSize / 1024) / 1024) * 100) / 100);
      					iSize2 = "GB";
      				}else{
      					iSize = (Math.round((iSize / 1024) * 100) / 100);
      					iSize2 = "MB";
      				}
      			}else{
      				iSize = (Math.round(iSize * 100) / 100);
      				iSize2 = "KB";
      			}
	        	
	        	//화면에 보여질 div부분에 코드를만들어서 출력해줌
	        	codeHTML += "<table>"
	        	codeHTML += "<tr class='filelist' style='background-color:lightgoldenrodyellow;'>"
	            codeHTML += "<td style='margin-left:50px;width:60%;color:darkblue;'><font color='black'>[파일이름]</font>&nbsp;&nbsp;&nbsp;&nbsp;"+files[i].name+"</td>"
	            codeHTML += "<td style='margin-left:50px;width:300px;color:darkblue;'><font color='black'>[파일크기]</font>&nbsp;&nbsp;&nbsp;&nbsp;"+iSize+""+iSize2+"</td>"
	            codeHTML += "</tr>"
	            codeHTML += "</table>"
	        	$("#dropitem").html(codeHTML);
	            
	            //업로드를위해 배열에저장	            
	            fileCount = files;
	            //alert(fileCount[i]+" 저장");
	            
         }
        
     }
}


</script>
	<div class='section'>	
		<div class='container'>
			<div class='row'>
				<div class='col-md-12'>
					<div class='page-header text-center'>
						<!-- selectboard 컨트롤러에서 구분자로 넘겨받은 Attribute값으로 비교를한다. -->
						<c:set var="gubun" value="${gubun}"></c:set>
						<!-- if~else문 / 넘겨받은 구분페이지가 1번이라면 공지사항 그렇지않으면 자유게시판 -->
						<c:choose>
							<c:when test="${gubun eq '1'}">
								<h1 class='text-center text-primary'>
									NOTICE BOARD <i class='fa fa-fw fa-bullhorn'></i>
								</h1>
							</c:when>
							<c:when test="${gubun eq '2'}">
								<h1 class='text-center text-primary'>
									FREE BOARD <i class='fa fa-fw fa-child'></i>
								</h1>
							</c:when>
						</c:choose>
					</div>
				</div>
			</div>
		</div>
	</div>	
	<!-- section start -->
	<div class='section'>	
		<div class='container'>
			<div class='row'>
			<span style="text-align: center;">
		   	</span>
		   	
				<div id='table_view'>
					<div class='col-md-12' id='tableHeader'>
					
					<!-- table -->				
						<table class='table table-condensed table-hover'>
							<thead>
								<tr>
									<th>번호</th>
									<th>제목</th>
									<th>작성자</th>
									<th>조회</th>
									<th class="btitle">작성일</th>
								</tr>
							</thead>
							<!-- 여기서부터 반복문으로 list 뽑아온다. BRD_PIDX=0 과같은것들만 (원본글) -->
						    <c:forEach var="x" items="${list}">
						    <c:set var="seq" value="${x.seq}"/>
						    <!-- 댓글이 아닌 글들만 출력 -->
						    <c:if test="${seq eq '0'}">
						    <!-- 게시글 상세보기 파라미터전송 / 댓글리스트까지 필요함 / 해당글의 객체의 정보를 넘겨줘야한다. -->
							<c:url var="detail" value="detailboard">
							 <c:param name="idx" 	 value="${x.idx}"/>							
							 <c:param name="gubun"   value="${gubun}"/>
							 <c:param name="page"    value="${page}"/>
							</c:url>
							<tbody>
								<!-- sysdate 출력형태변경 -->
								<fmt:formatDate var="date" value="${x.date}" pattern="yy-MM-dd HH:24"/>
									<tr class='active' style="text-align:left;">
										<td>${x.idx}</td>
										<td>
											<!-- 게시글 상세보기 -->
											<a href="${detail}"><c:out value="${x.title}"/></a>
										</td>
										<td>${x.writer}</td>
										<td>${x.hit}</td>
										<td class="date_size">${date}</td>
									</tr>
							</tbody>
							</c:if>
							</c:forEach>
							<!-- 반복문 종료 -->
						</table>
					<!-- table end -->
					
					</div>
				</div>
			</div>

			<div class='row'>
				<div class='col-md-4 text-left'>
					<a class='btn btn-default btn-sm' onClick="history.back();">돌아가기
					<i class='-o fa fa-fw fa-lg fa-rotate-180 fa-sign-out'></i></a> 
				</div>
				<!-- 로그인여부확인 후 글쓰기가능 -->				
				<div class='col-md-8 text-right' style='padding-bottom: 10px;'>
					<a class='btn btn-default btn-sm' data-toggle='modal'  data-backdrop="static"  data-keyboard="false"
						data-target='#writemodal' id='write'>글쓰기<i
						class='-square fa fa-fw fa-lg fa-pencil'></i></a>
				</div>
			</div>
			<!-- 페이징 구분 -->
					<div class='row'>
						<div class='col-md-12 text-center'>
							<ul class='pagination'>
							 	<li>${pagenavi}</li>
							</ul>
						</div>
					</div>
				</div>
			<!-- 페이징 구분 -->
			<div class='row'>
				<div class='col-md-12'>	
					<hr>
				</div>
			</div>
			<!-- 검색 form start -->
			 <form name="bform" id='seachAll' method="post">
				<div class='section'>
					<div class='container'>
						<div class='row'>
							<div class='col-md-4 text-right'>
								<div class='btn-group'>
									<div class='form-group'>
										<select class='form-control' id='selectname' name='stype'>
											<option value='title'>글제목</option>
											<option value='cont'>글내용</option>
											<option value='name'>작성자</option>
										</select>
									</div>
								</div>
							</div>
							<div class='col-md-8'>
								<div class='row'>
									<div class='col-md-7 col-sm-4 form-group text-center'>
										<div class='input-group'>
											<input type="hidden" name="brd_gubun" value="${gubun}">
											<input type="hidden" name="page" value="${page}">
											<input id='seachform' name='sword' type='text' class='form-control'> 
											<span class='input-group-btn'>
											<a class='btn btn-default' onclick='check(this.form)' type='button'>&nbsp;<i class='fa fa-fw fa-lg fa-spin text-success -o-notch fa-asterisk'></i></a>
											</span>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</form>
			<!-- 검색 form end -->
			
			<!-- modal body -->
			<div class='fade modal text-left' id='writemodal'>
				<div class='modal-dialog'>
					<div class='modal-content' id='writemodal2'>
					
						<!-- 게시글 작성 form start -->
						<form name='insertBoard' enctype="multipart/form-data">
							<div class='modal-header'>
								<div class='input-group'>
									<span class='input-group-addon'> <i
										class='-square fa fa-lg -square-o fa-pencil'></i>
									</span> 
									<!-- 제목입력 brd_title -->
									<input id='brd_title' type='text' class='form-control' name='brd_title' placeholder='제목 입력' >
									<!-- 작성자 session/hidden -->
									<input type='hidden' id="brd_writer" name='brd_writer' value="<%=value%>">									
									<!-- 게시글 구분 1 / 공지사항 게시판 -->
									<input type='hidden' id="brd_gubun" name='brd_gubun' value="${gubun}"> 
								</div>
							</div>
							<div class='modal-body'>
								<!-- 멀티 파일업로드 -->
								<div class='form-group'>
    								<!-- <div class="col-sm-2" style="margin-bottom:10px;">
							          <input type="file" name="file0" multiple/>
							        </div> -->
							       <!-- 드래그 박스 -->				
							       <div id="dropzone">Drag & Drop Files Here</div>
							       <!-- 파일 목록 헤더부분 표시 -->
							       <div id="dropHeader"></div> 			    
							       <!-- 파일 목록이 표시될 영역 --> 			    
							       <div id="dropitem"></div> 			    
									<!-- 내용입력 brd_content -->
									<textarea class='form-control' rows='10' name='brd_content' id="brd_content" style="margin-top:5px;"></textarea>
								</div>
							</div>
						</form>
						<!-- 게시글 작성 form end -->
						
						<!-- from 전송 -->
						<!-- data-dismiss='modal' -->
						<div class='modal-footer'>
							<button type='button' class='btn btn-primary' aria-hidden='true' id='writeBoard' onclick="fileCheck()">
								Save <i class='fa fa-fw -square fa-check'></i>
							</button>
							<button type='button' class='btn btn-danger' data-dismiss='modal' id="close"
								aria-hidden='true'>Close <i class='fa fa-fw fa-close'></i>
							</button>
						</div>
						<!-- from 전송 end -->
					</div>
				</div>
			</div>
			<!-- modal body end -->
	</div>
	<!-- section end -->