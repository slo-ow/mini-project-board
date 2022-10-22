<%--==============================================================
 * @기능    index - header - login - 로그인체크 페이지
 * @author 문성철
 * @since  2017.03.05
 * @version 1.0
 * 
===============================================================--%>
<%@page import="kr.or.miniboard2.member.vo.MemberVo"%>
<%@page import="kr.or.miniboard2.member.service.MemberServiceImpl"%>
<%@page import="kr.or.miniboard2.member.service.MemberService"%>
<%@ page language="java" contentType="text/plan; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");%>

<%
// 회원 ID,PASS 검사
String id = request.getParameter("id");
String pass = request.getParameter("pass");

// service 호출
MemberService service = MemberServiceImpl.getService();
MemberVo vo = service.selectMember(id,pass);
if(vo==null){
	System.out.println("로그인 실패");
	
}else{
	System.out.println("성공");
	session.setAttribute("USEROK",vo.getMem_id());
}
%>
{

	"mid" : "<%=vo.getMem_id() %>",
	"mpass" : "<%=vo.getMem_pass() %>"

}