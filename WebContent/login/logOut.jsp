<%--==============================================================
 * @기능    index - header - logout - 로그아웃 페이지
 * @author 문성철
 * @since  2017.03.05
 * @version 1.0
 * 
===============================================================--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//로그아웃페이지
	session.removeAttribute("USEROK");
	System.out.println("로그아웃성공");
%>
