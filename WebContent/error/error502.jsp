<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
body {
	margin:0px;
	padding:0px;
	width:100%;
}

#error {
	margin:0px;
	padding:0px;
	width:100%;
}

#errorimg {
	margin:0px;
	padding:0px;
	width:100%;
	border:0px;
	z-index:999;
}

#back {
	width:8%;
	/* height:89px; */	
	padding-left:80%;
}

#backimg {
	width:100%;
}
</style>
<div id="error">
	<img src="./images/error/502.png" id="errorimg">
	<div id="back">
		<a onclick="window.history.back();"><img src="./images/error/back.png" id="backimg" style="cursor:pointer;"></a>
	</div>
</div>