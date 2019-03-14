<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1> WebContent/member/main.jsp </h1>
<h1> @@ 메인 페이지 @@</h1>

<%
	request.setCharacterEncoding("UTF-8");
	// 로그인 -> 세션 id 값 존재	
	String id = (String)session.getAttribute("id");
	// 다운캐스팅 Object->String
	// id 님이 로그인 하셨습니다.(페이지 출력)
	
	if(id == null){
		//로그인 성공하면 session 값존재, 로그인 실패시 null값임
		response.sendRedirect("loginForm.jsp");
		// 로그인 x, 잘못된 경로 접근 -> 다시 로그인 입력창으로 이동
	}
	
%>

<h2><%=id %>님이 로그인하셨습니다.</h2>
<!-- 로그아웃 버튼 -- 로그아웃 처리 페이지로 이동(logout.jsp) -->
<input type="button" value="로그아웃" onclick="location.href='logout.jsp'">

<br><br><br>


<a href="info.jsp">회원정보 조회</a>
<br><br><br>

<a href="updateForm.jsp">회원정보 수정</a>
<br><br><br>

<a href="deleteForm.jsp">회원정보 삭제</a>
<br><br><br>

<%
if(id != null){
	if (id.equals("admin")){ %>
	<a href="memberList.jsp">관리자 : 회원목록 보기</a>
<%
	}
} %>
</body>
</html>