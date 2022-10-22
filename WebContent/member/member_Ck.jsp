<%--==============================================================
 * @기능    index - JoinUs - member_Ck - 회원아이디 중복검사 
 * @author 문성철
 * @since  2017.03.06
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
MemberVo vo = service.selectMember(id, pass);

if(vo==null){
	String ok = null;
	System.out.println("회원가입성공 : 가입 가능한 아이디");
%>	
		{
			"mid" : "<%=ok%>"
		}
<%
	
}else{
	System.out.println("회원가입실패 : 이미 가입된 회원 ");
%>
		{
			"mid" : "<%=vo.getMem_id() %>"
		}	
<%
}
%>
