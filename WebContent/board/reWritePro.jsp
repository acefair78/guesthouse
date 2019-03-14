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
<h1>WebContent/board/reWritePro.jsp</h1>
<%
// 한글처리
request.setCharacterEncoding("utf-8");

// 액션태그 사용
// BoardBean 객체 생성,파라미터값 저장
%>
<jsp:useBean id="bb" class="board.BoardBean"/>
<jsp:setProperty property="*" name="bb"/>
<%
// ip (request.getRemoteAddr())추가 저장
bb.setIp(request.getRemoteAddr());

// BoardDAO 객체 생성
BoardDAO bdao = new BoardDAO();

// reInsertBoard(bb);
bdao.reInsertBoard(bb);
// list.jsp 페이지이동 
response.sendRedirect("boardList.jsp");
%>








</body>
</html>