<%--==============================================================
 * index - header - board - boardView - 게시글 상세보기 페이지
 * @author 문성철
 * @since  2017.03.05
 * @version 1.0
 * 
===============================================================--%>
<%@page import="java.util.List"%>
<%@page import="kr.or.miniboard2.board.vo.BoardVO"%>
<%@page import="kr.or.miniboard2.board.service.BoardServiceImpl"%>
<%@page import="kr.or.miniboard2.board.service.BoardService"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//문자인코딩
request.setCharacterEncoding("UTF-8");
//로그인세션가져오기
String value = (String)session.getAttribute("USEROK");
%>
<script type="text/javascript">

$(function(){
	
	//close 모달초기화
	//취소버튼 누를시 모달폼 초기화
	$("#close").click(function(){
		//alert("close");
		$("#msg").val('');
		$("#upcomment").val('');
	});	
	
    
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	<%-- detailboard.java에서 넘겨받은 구분자를 그대로 가져와서 페이지 이동을 시킨다. --%>
	<c:set var='gu' value='${gubun}'/>
	<c:set var='page' value='${page}'/>
	//구분자 전역변수설정
	var gubun = ${gu};
	var page = ${page};
	//게시판으로 돌아가기
	 back_page = function(){
		 location.href="selectboard?gubun="+gubun+"&page="+page+"";
	}
	
	 <%-- detailboard.java에서 넘겨받은 ${v} 안에 해당글의 모든정보가 담겨있음. --%>
	 
	//게시글 수정권한확인
	$("#update").click(function(){
		//세션과 글쓴이의 아이디값을비교
		if("<%=value%>"==null||"<%=value%>"==""||"<%=value%>"!="${v.writer}"){
			alert("글수정 권한이없습니다.");
			return false;
		}	
	});
	
	//게시글 수정
	$('#updateBoard').click(function(){
		var msg = $("#msg").val();
		var upcom = $("#upcomment").val();
		if(msg==""){
			alert("제목을 입력해주세요");
			return;
		}
		if(upcom==""){
			alert("내용을 입력해주세요");
			return;
		}
	var params = $('#updateForm').serialize();
		 $.ajax({			                                                                                                            
			url  : "modifyboard",                                                                                                   
			type : 'post',                                                                                                              
			data : params,                                                                                  
			success : function(res){                                                                                                    
			alert('게시글 수정 완료');                                                                                                       
			//location.href="${pageContext.request.contextPath}/index.jsp?contentPage=board/Board.jsp?Pages="+gubun+"";
			//모달창 닫기
			$('#writemodal').modal('hide');			
			//새로고침
	   		location.reload();
			},                                                                                                                          
			dataType : 'text'                                                                                                           
		})                                                                                                    
	});              
	
	//게시글 삭제
	$("#delete").click(function(){
		//세션과 글쓴이의 아이디값을비교		
		if("<%=value%>"==null||"<%=value%>"==""||"<%=value%>"!="${v.writer}"){
			alert("게시글 삭제 권한이없습니다.");
			return false;
		}else{
			var idx = ${v.idx};
			if (confirm("정말 삭제하시겠습니까??") == true){    //확인
				$.ajax({			                                                                                                         
					url  : 'deleteboard',                                                                                                
					type : 'post',                                                                                                           
				    data:{                                                                                                                   
					 bno : idx                                                                                
					},                                                                                                                        
					success : function(){                                                                                                  
					alert('게시글 삭제완료');                                                                                                     
					location.href="selectboard?gubun="+gubun+"&page="+page+"";                                                                                 
					},                                                                                                                        
					dataType : 'text'                                                                                                         
				})          
			}else{   //취소
			    return;
			}			            
		}	
	});
	
	//댓글 입력 폼 체크
	$("#commentWrite").click(function(){
		//댓글입력하는 textarea 가 비어있고 로그인이 되어있지 않은상태라면
		if("<%=value%>"=="null"||"<%=value%>"==""){
			alert("댓글 쓰기 권한이 없습니다");
			return false;				
		}else if(replyfrm.content.value==""||replyfrm.content.value=="null"){
			alert("글을 입력해주세요");
			return false;
		}else{
			//댓글입력
			//댓글입력폼에있는 파라미터를 전부다 가져온다.
			var params = $('#addCommentForm').serialize();
			//alert(params);
			$.ajax({			                                                                                                         
				url  : 'insertReply',                                                                                                
				type : 'post',                                                                                                           
			    data : params ,                                                                                                                    
				success : function(){                                                                                                  
				//alert('댓글 완료');
				location.reload();				                                                                                 
				},                                                                                                                        
				dataType : 'text'                                                                                                         
			})            
		}
	});
	
	//댓댓글 입력
	$(".addReply").click(function(){
		//댓글작성자의 id정보를 읽어온다
		var comWriter = $(this).attr('id');
		var idx = $(this).parent().find(".getidx").val();
		alert(comWriter);
		alert(idx);
		//댓글입력하는 textarea 가 비어있고 로그인이 되어있지 않은상태라면
		if("<%=value%>"=="null"||"<%=value%>"==""){
			alert("댓글 쓰기 권한이 없습니다");
			return false;				
		}else{
			$('#commentVal').attr('placeholder',comWriter+'님에게 댓글작성하기');
			//댓댓글구분2로 value값변경
			$("#addRe2").attr('value','2');      
			$("#addindex").val(idx);
			$("#addPidx").val(idx);
			$("#commentDelete").show();
		}
	});
	
	//댓댓글 취소버튼 감추기
	$("#commentDelete").hide();
	
	//댓댓글 취소기능 (기존의 댓글기능으로 돌려놓는다)
	$("#commentDelete").click(function(){
		var idx = ${v.idx};
		//placeholder 공백처리
		$('#commentVal').attr('placeholder','');
		//댓댓글구분1로 value값변경
		$("#addRe2").val('1');
		$("#addindex").val(idx);
		$("#commentDelete").hide();
	});
	
	
	//댓글 삭제
	$(".deleteReply").click(function(){
		//댓글삭제
		var delNum = $(this).attr('id');
		alert(delNum);
		//댓글삭제 세션확인
		if("<%=value%>"=="null"||"<%=value%>"==""){
			alert("댓글 삭제 권한이 없습니다");
			return false;				
		}else{
			//댓글삭제
			$.ajax({			                                                                                                         
				url  : 'deleteReply',                                                                                                
				type : 'post',                                                                                                           
			    data : {
			    'delNum' : delNum
			    },                                                                                                                    
				success : function(){                                                                                                  
				//alert('댓글삭제 완료');
				location.reload();				                                                                                 
				},                                                                                                                        
				dataType : 'text'                                                                                                         
			})             
		}
	});
	
	// 댓글작성폼 글자수 입력제한
	$('#commentVal').on('keyup', function() {
        if($(this).val().length > 150) {
			alert("입력할수있는길이를 벗어났습니다");
            $(this).val($(this).val().substring(0, 150));
        }
    });

});
</script>
<style>                                                                                                                                                      
 #tableHeader th, td{text-align:center;}                                                                                                                    
 #writemodal2 {top:250px;}      
 #com_time {color : #9f9fa2 }       
 #item-list{ margin-top: 50px;}                                                                                                                  
 #item-list > li { font-size:11px;}      
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
     <div class="section">
      <div class="container">
        <div class="row">
          <div class="col-md-12">
            <div class="row">
              <div class="col-md-12 text-center">
                <h3>
                  <i class="fa fa-2x fa-fw fa-edit"></i>
                  <!-- ${v} 로 detailboard에서 선택된 글의 모든정보를 vo로 리턴해줌 -->
                  <span>글쓴이 / </span>
                  <span id="user"><c:out value="${v.writer}"/></span>
                </h3>
              </div>
            </div>
            <hr>
            <div class="page-header text-center">
              <h3>
              	<i class="fa fa-2x fa-connectdevelop fa-spin"></i>
              </h3>
              <h5>
                <span>TITLE</span>
              </h5>
              <h3>
                <c:out value="${v.title}"/>
              </h3>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-3">
            <h3 class="text-center text-muted">FILE LIST
              <i class="fa fa-fw fa-download"></i>
            </h3>
             <!-- 파일이 존재하지 않는다면 보여지는 부분 -->
            <c:set var="item" value="${v.filelist}"/>
            	<c:if test="${empty item}">
		            <div class="row" style="margin-top:50px;">
		              <div class="col-md-12 text-center">
		                <i class="fa fa-5x fa-ban fa-border text-danger"></i>
		              </div>
		            </div>
			        <div class="page-header text-center">
			           <h5>첨부된 파일이 없습니다</h5>
			        </div>
	       	 	</c:if>
            <ul class="list-group" id="item-list">
            	<!-- 게시물에 업로드파일이있을경우 개수만큼출력 / 최대5개까지업로드가능하게 제한해두었음 -->
	            <c:forEach var="list" items="${v.filelist}" varStatus="st">
	            	<!-- 파일이존재 한다면 존재하는 개수만큼 리스트 출력 -->	
	            	 <c:if test="${list ne null}">
		            	 <!-- 첨부파일 다운로드 -->
						<c:url var="down" value="filedown">
							<c:param name="filename" value="${list.filename}"/>
						</c:url>
	            		 <li class="list-group-item"><a href="${down}">${list.originalname}</a></li>
	            	 </c:if>	            	 
	            </c:forEach>
            </ul>
          </div>
          <div class="col-md-9">
            <div class="form-group">
              <div class="form-control" style="width:847px; height:335px;" id="comment"><c:out value="${v.content}"/></div>
            </div> 
          </div>
        </div>
      </div>
    </div>
      <div class="row">
        <div class="col-md-5 text-right">
          <a class="btn btn-default btn-sm" onclick="back_page();">돌아가기<i class="-o fa fa-fw fa-lg fa-rotate-180 fa-sign-out"></i></a>
        </div>
        <div class="col-md-2 text-center">
          <a class="btn btn-default btn-sm" id="delete">삭제<i class="fa fa-fw fa-lg fa-trash-o"></i></a>
        </div>
        <div class="col-md-5 text-left" style="padding-bottom: 10px;">
          <a class="btn btn-default btn-sm" data-backdrop="static"  data-keyboard="false" data-toggle="modal" data-target="#writemodal" id="update">수정<i class="-square fa fa-fw fa-lg fa-wrench"></i></a>
        </div>
      </div>
      <div class="section" id="commentLow1">
        <div class="container">
          <div class="row" id="commentLow2">
        <!-- 댓글 보여지는 부분 / 댓글리스트의 개수만큼 반복문 -->
        <c:forEach var="re" items="${reply}">
        <c:set var="delCk" value="${re.delck}"/>    
        <c:set var="writer" value="${re.writer}"/>    
        <c:set var="session" value="<%=value%>"/>
        
        <c:choose>    
        		<%-- 삭제된 글이라면 --%>
       			<c:when test="${delCk eq 'Y' }">
		        <div class="col-md-3">
		        </div>	
		        <div class='col-md-12 text-left' style='text-align:center;'>                                                                                         
		           <i class='fa fa-2x fa-fw fa-bullhorn'></i>                                                                                                            
		           <i class='fa fa-fw fa-quote-left'></i>                                                                                                       
		           	<span id='notComment' style='font-size:12px; color:red;'>삭제된 댓글입니다.</span>                                                
		           <i class='fa fa-fw fa-quote-right'></i>                                                                                                      
		        </div>      
		        </c:when>
		         
		         <%-- 삭제되지않은 글이라면 --%>
				<c:when test="${delCk eq 'N' }">
			 	<c:set var="spc" value="${re.lvl}"/>
			 	<c:set var="nbspc" value=""/>			 	
				<c:forEach var="k" begin="0" end="${spc}">
					<c:set var="nbspc" value="${nbspc}&nbsp;&nbsp;"/>
				</c:forEach>
				
				<div class="col-md-3">
		        </div>	
	            <div class="col-md-9 text-left" id="commentFrm">
	            <%-- LEVEL으로 들여쓰기 --%>
	            <c:if test="${spc gt '1' }">
	            	${nbspc}
	            </c:if>
	            <input type="hidden" class="getidx" value="${re.idx}">      
	              <span>└댓글</span>
	              <i class="fa fa-2x fa-fw fa-meh-o"></i>
	              <span class="getWriter">작성자/${re.writer}</span>
	              <i class="fa fa-fw fa-quote-left"></i>
	              <span id="comment"><c:out value="${re.content}"/></span>
	              <i class="fa fa-fw fa-quote-right"></i>
	              <i class="fa fa-fw fa-reply"></i>
	              <a class="addReply" style="cursor:pointer;" id="${re.writer}">댓글</a>
	               <fmt:formatDate var="date" value="${re.date}" pattern="yy-MM-dd HH:24"/>
	               <span id="com_time">${date}</span>
	               <%-- 본인글만 삭제가능 --%>
	              <c:if test="${writer eq session}">
	              <i class="fa fa-fw fa-lg -circle fa-trash"></i>
	              <a class="deleteReply" id="${re.idx}" style="cursor:pointer;">삭제</a>
	              </c:if>
	            </div>
	            </c:when>
	       		
	       </c:choose>
	  	  </c:forEach>
	  	  
         <!-- 댓글 보여지는 부분 끝// -->
            <div class="row">
              <div class="col-md-12">
                <hr style="width:600px;">
              </div>
              <!-- 댓글 입력하는 부분 -->
              <form name="replyfrm" id="addCommentForm" action="">
                <div class="row">
                  <div class="col-md-3"></div>
                  <div class="col-md-6">
                    <div class="input-group">
                      <span class="input-group-addon">
                        <i class="fa fa-fw fa-lg text-muted fa-comments"></i>
                      </span>
                      <div class="form-group">
                        <textarea placeholder="" class="form-control" rows="3" id="commentVal" name="content"></textarea>
                      </div>
                    </div>
                  </div>
                  <!-- 댓글전송 -->
                  <div class="col-md-1 text-center">
                    <a class="btn btn-default btn-lg" id="commentWrite"><i class="-square -square fa fa-3x -square fa-fw fa-chevron-circle-left"></i></a>
                  </div>
                   <!-- 댓 댓글 취소버튼 -->
                  <div class="col-md-1 text-center" style="margin-left:10px;">
                    <a class="btn btn-default btn-lg" id="commentDelete"><i class="-square -square fa fa-3x -square fa-fw fa-remove"></i></a>
                   </div>
                </div>
                <input type="hidden" name="gubun" value="${gubun}">
                <input type="hidden" id="addindex" name="idx" value="${v.idx}">
                <input type="hidden" id="addPidx" name="pidx" value="${v.idx}">
                <input type="hidden" name="title" value="REPLY">
                <input type="hidden" name="writer" value="<%=value%>">
                <input type="hidden" name="pidx" value="${v.idx}">                
                <input type="hidden" name="grp" value="${v.grp}">
                <input type="hidden" name="seq" value="${v.seq}">
                <input type="hidden" id="addRe2" name="addReply2" value="1">
              </form>
              <!-- 댓글 입력하는 부분 끝// -->
            </div>
          </div>
        </div>
        <div class="fade modal text-left" id="writemodal">
          <div class="modal-dialog">
            <div class="modal-content" id="writemodal2">
            
            <!-- 게시글 수정 form -->
              <form id="updateForm" enctype="multipart/form-data">
                <div class="modal-header">
                  <div class="input-group">
                    <span class="input-group-addon">
                      <i class="-square fa fa-lg -square-o fa-pencil"></i>
                    </span>
                    <input id="msg" type="text" class="form-control" name="uptitle" placeholder="수정글 제목 입력">
                    <input type="hidden" name="no" value="${v.idx}">
                  </div>
                </div>
                <!-- modal body -->
                <div class="modal-body">
                  <div class="form-group">
                    <textarea class="form-control" rows="10" id="upcomment" name="upcontent"></textarea>
                  </div>
                </div>
                <!-- modal end -->
              </form>
              <!-- 게시글 수정 form end -->
              
              <div class="modal-footer">
                <!-- <button type="button" class="btn btn-primary" data-dismiss="modal" aria-hidden="true" id="updateBoard">Save -->
                <button type="button" class="btn btn-primary" aria-hidden="false" id="updateBoard">Save
                  <i class="fa fa-fw -square fa-check"></i>
                </button>
                <button type="button" class="btn btn-danger" data-dismiss="modal" aria-hidden="true" id="close">Close
                  <i class="fa fa-fw fa-close"></i>
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>                                                                                                                                                  
