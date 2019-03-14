<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function result() {
		// 해당 ID 사용하기
		// join페이지 id값을 joinIdCheck 페이지의 id값으로 저장
		opener.document.fr.id.value=document.wfr.userid.value;
		//joinIDCheck.jsp를 연 페이지의 document.fr.id.value 와 비교
		
		// 창 닫기
		window.close();
		
	}
</script>
</head>
<body>
<h1>WebContent/member/JoinIDCheck</h1>
<%
// 전달해주는 userid값 받아서 출력(콘솔)
	String id = request.getParameter("userid");
	// System.out.println(id);
	
	// DB에 해당 값이 있는지 없는지 판단
	// MemberDAO 객체생성
	MemberDAO mdao = new MemberDAO();
	
	int check = mdao.joinIdCheck(id);	//0 또는 1 넘어옴
	
	// check = 1 일때 중복 "사용중인 아이디 입니다."
	// check = 0 일때 중복x "사용가능한 아이디 입니다."
	if(check == 1){
		out.print("사용중인 아이디 입니다.");
	}else{
		out.print("사용가능한 아이디 입니다.");
		%>
			<input type="button" value="해당 아이디 사용" onclick="result()">
		<%
	}
%>
<br>
<form action="joinIDCheck.jsp" method="post" name="wfr">
	<input type="text" name="userid" value="<%=id%>">
	<input type="submit" value="중복확인">
	
</form>
</body>
</html>