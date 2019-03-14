<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@page import="java.sql.Timestamp"%>
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
<h1>WebContent/member/updateForm.jsp</h1>

<%
  // 로그인시 수정 처리 
  // 세션값이 없을경우에 loginForm.jsp 페이지로 이동
  String id = (String)session.getAttribute("id");
  if(id ==null){
	  response.sendRedirect("loginForm.jsp");
  }

  // 디비처리객체 MemberDAO 객체 생성
  MemberDAO mdao = new MemberDAO();
  // getMember(id); 메서드 호출 => 회원정보 저장 
  MemberBean mb = mdao.getMember(id);
  // 만약에 성별이 (gender) 없을 경우 "남"
  String gender=mb.getGender();
  if(gender == null){
	  gender="남";
  }

%>

<h1> @@ 회원 수정 @@ </h1>
<fieldset>
	<form action="updatePro.jsp" method="post">
		아이디 : <input type="text" name="id" value="<%=id %>" readonly><br>
		비밀번호 : <input type="password" name="pass"><br> 
		이름 : <input type="text" name="name" value="<%=mb.getName()%>"><br>
		나이 : <input type="text" name="age" value="<%=mb.getAge()%>"><br>
		성별 : <input type="radio" name="gender" value="남" 
		             <%if(gender.equals("남")){ %>
		             checked
		             <%} %>
		             >남
		     <input type="radio" name="gender" value="여"
		        <%if(gender.equals("여")){ %> checked <%} %>
		     >여<br>
		이메일 : <input type="text" name="email" value="<%=mb.getEmail()%>"><br>
		<input type="submit" value="회원 정보 수정">		
	</form>
</fieldset>

</body>
</html>