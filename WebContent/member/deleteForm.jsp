<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1> WebContent/member/deleteForm.jsp </h1>
<h2> @@ 회원 탈퇴 @@</h2>
<%
	request.setCharacterEncoding("UTF-8");
	//로그인 여부를 판단
	String id= (String)session.getAttribute("id");
	if(id == null){
		response.sendRedirect("loginForm.jsp");
}
	// form 태그에 id, pass 처리페이지로 전달
	// session -> id (수정x), pass -> 사용자 입력
	// deletePro.jsp 페이지로 이동
	
%>
<fieldset>
	<form action="deletePro.jsp" method="post">
	아이디 : <input type="text" name="id" value="<%=id%>" readonly><br>
	비밀번호 : <input type="password" name="pass"><br>
	<input type="submit" value="삭제">
	</form>
</fieldset>
</body>
</html>