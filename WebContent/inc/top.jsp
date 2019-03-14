<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<header>
<%
	// 로그인 성공시 (세션 id값이 있을경우)
	// ㅇㅇ님 | logout(링크)
	
	String id= (String)session.getAttribute("id");

		if(id != null){
			// 로그인 상태
			%>
			<div id="login"><%=id %>님</a> | <a href="../member/logout.jsp">logout</a>
			</div>
			<%
		}else{
%>
<div id="login"><a href="../member/login.jsp">login</a> | <a href="../member/join.jsp">join</a></div>
<%
		}
%>
<div class="clear"></div>
<!-- 헤더파일들어가는 곳 -->
<div id="logo"><img src="../images/logo.gif" width="265" height="62" alt="Fun Web"></div>
<!-- 헤더파일들어가는 곳 -->
<nav id="top_menu">
<ul>
	<li><a href="#">HOME</a></li>
	<li><a href="../company/welcome.html">COMPANY</a></li>
	<li><a href="#">SOLUTIONS</a></li>
	<li><a href="../center/notice.html">CUSTOMER CENTER</a></li>
	<li><a href="#">CONTACT US</a></li>
</ul>
</nav>
</header>
</body>
</html>