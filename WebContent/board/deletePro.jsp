<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>WebContent/board/deletePro.jsp</h1>
	<%
		// 한글처리
		request.setCharacterEncoding("UTF-8");
		// num / pageNum
		int num = Integer.parseInt(request.getParameter("num"));
		String pageNum = request.getParameter("pageNum");
		String pass = request.getParameter("pass");

		// BoardDAO 객체 생성
		BoardDAO bdao = new BoardDAO();
		int check = bdao.deleteBoard(num, pass);

		if (check == 1) {
	%>
	<script type="text/javascript">
	   alert("삭제 완료");
	   location.href="list.jsp?pageNum=<%=pageNum%>";
	</script>
	<% 
		} else if (check == 0) {
	%>
	<script type="text/javascript">
		alert("비밀번호 오류");
		history.back();
	</script>
	<%
		} else { // check == -1
	%>
	<script type="text/javascript">
		alert("글번호 오류");
		history.back();
	</script>
	<%
		}
	%>









</body>
</html>