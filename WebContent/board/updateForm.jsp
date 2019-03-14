<%@page import="board.BoardBean"%>
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
<h1>WebContent/board/updateForm.jsp</h1>
<%
// num, pageNum 두개의 정보를 저장 (파라미터)
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");
// DB에서 정보를 가져오기
// BoardDAO 객체 생성
BoardDAO bdao = new BoardDAO();
// 글번호에 해당하는 정보를 모두 가져오기 
BoardBean bb = bdao.getBoard(num);
// 글수정 양식에 출력
%>
<script>
/* function check(){
	if(document.fr.pass.value == false){
		alert('비밀번호를 입력해주세요.');
		return false;
		}
} */
</script>

<fieldset>
  <legend>게시판 글수정</legend>
  
  <form action="updatePro.jsp?pageNum=<%=pageNum %>" method="post">
    <input type="hidden" name="num" value="<%=num%>">
     글쓴이 : <input type="text" name="name" value="<%=bb.getName()%>"><br>
     비밀번호 : <input type="password" name="pass"><br>
     제목 : <input type="text" name="subject" value="<%=bb.getSubject()%>"><br>     
     내용 : <br>
     <textarea rows="10" cols="20" name="content"><%=bb.getContent() %></textarea>
     <br><br>
    <input type="submit" value="글수정">    
  
  </form>
</fieldset>









</body>
</html>