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
	<h1>WebContent/board/updatePro.jsp</h1>
	<%
		// 한글처리
		request.setCharacterEncoding("UTF-8");

		// pageNum 파라미터 저장
		String pageNum = request.getParameter("pageNum");

		// form 태그에서 전달한 정보를 저장 (BoardBean)
		// => 액션태그 (객체 생성, 값저장)
	%>
	<jsp:useBean id="bb" class="board.BoardBean" />
	<jsp:setProperty property="*" name="bb" />
	<%
		// BoardDAO 객체 생성후 처리 메서드 생성
		// updateBoard(bb)
		BoardDAO bdao = new BoardDAO();
		int check = bdao.updateBoard(bb);

		if (check == 1) {
			%>
			 <script type="text/javascript">
			   alert("수정 완료");
			   location.href="list.jsp?pageNum=<%=pageNum%>";
			 </script>
			<%
		}else if(check ==0 ){
			%>
			<script type="text/javascript">
			   alert("비밀번호를 다시 입력하세요");
			   history.back();
			</script>
			<%
		}else { // check == -1
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