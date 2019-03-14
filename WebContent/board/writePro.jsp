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
<h1>WebContent/board/writePro.jsp</h1>
<%
  // 한글처리
  request.setCharacterEncoding("UTF-8");
  // writeForm.jsp 페이지에서 전달된 정보를 
  // 저장 
  // 자바빈 객체로 저장(BoardBean)
  %>
  <jsp:useBean id="bb" class="board.BoardBean"/>
  <jsp:setProperty property="*" name="bb"/>  
  <%
  // ip 주소 입력 
  bb.setIp(request.getRemoteAddr());
  System.out.println(bb.getIp());
  
  // BoardDAO 객체 생성 사용 (DB 연결, 메서드 생성)
  BoardDAO bdao = new BoardDAO();
  // insertBoard();
  bdao.insertBoard(bb);
  // DB에 저장 
  
  // 페이지 이동  boardList.jsp
  response.sendRedirect("boardList.jsp");

%>












</body>
</html>