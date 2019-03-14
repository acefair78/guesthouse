<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>WebContent/board/fwritePro.jsp</h1>
<%
	// 파일 업로드 프로그램 설치=> cos.jar(WEB-INF/lib 저장) 
	//	=> MultipartRequest 객체 생성 => 파일 정보를 전달
	
	// request, 업로드 파일위치, 크기, 한글처리방식, 동일한 이름 처리객체
	
	// upload 폴더를 생성
	
	String realPath = request.getRealPath("/upload");
	System.out.println("realPath : "+realPath);
	
	// 파일 저장 크기
	int max = 10*1024*1024;	//10MB
	
	MultipartRequest multi = new MultipartRequest(
								request,
								realPath,
								max,
								"UTF-8",
								new DefaultFileRenamePolicy()
								);
	
	// 글쓰기 + 파일업로드
	BoardBean bb = new BoardBean();
	
	bb.setName(multi.getParameter("name"));
	bb.setPass(multi.getParameter("pass"));
	bb.setSubject(multi.getParameter("subject"));
	bb.setContent(multi.getParameter("content"));
	
	// 파일정보 저장
	bb.setFile(multi.getFilesystemName("file"));
	
	System.out.println("클라이언트가 업로드한 파일 원본이름 : "+ multi.getOriginalFileName("file"));
	System.out.println("서버에 업로드된 파일 이름 : "+ multi.getFilesystemName("file"));
	
	bb.setIp(request.getRemoteAddr());
	
	BoardDAO bdao = new BoardDAO();
	bdao.insertBoard(bb);
	
	response.sendRedirect("boardList.jsp");
%>
</body>
</html>