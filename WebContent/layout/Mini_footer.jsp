 <%--==============================================================
 * index 메인 footer화면
 * @author 문성철
 * @since  2017.02.22
 * @version 1.0
 * 
===============================================================--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<footer id="footer">
	<div class="container">
		<div class="row">
			<div class="col-sm-6">
				<h1>
					Created by Moon <i class="fa fa-2x fa-bomb fa-fw"></i>
				</h1>
				<p>
					회사소개 <br>대덕인재개발원 207호 <br>대표번호 ☎ : 042-666-5555
				</p>
			</div>
			<!-- 구글 지도들어올부분 -->
			<div class="col-sm-6">
			 	 <jsp:include page="../contact.html"/>
			</div>
		</div>
	</div>
</footer>