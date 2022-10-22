<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
#back {
	width:8%;
	/* height:89px; */	
	padding-left:80%;
}

#backimg {
	width:100%;
}

#error {
	text-align:center;
	margin:0px;
	padding:0px;
	width:100%;
}

</style>
</head>
<body>
<div id="error">
<img alt="" src="./images/error/405error.png">
</div>
<div id="back">
		<a onclick="window.location='/moyeo/main/home'"><img src="./images/error/back.png" id="backimg" style="cursor:pointer;"></a>
</div>
</body>
</html>