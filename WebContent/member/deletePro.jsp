<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1> WebContent/member/deletePro.jsp </h1>
<%
// 세션값X -> 로그인 페이지
String id= (String)session.getAttribute("id");

if (id == null) {
	response.sendRedirect("loginForm.jsp");
}
// 한글처리
request.setCharacterEncoding("UTF-8");
// id, pass값 저장
// String id;  
String pass = request.getParameter("pass");

// MemberDAO 객체 생성
MemberDAO mdao = new MemberDAO();

// 삭제 처리 메서드(id, pass)
// deleteMember(id, pass)
int check = mdao.deleteMember(id, pass);

// 삭제 완료 = 1, 비밀번호 오류 = 0, 아이디가 없을경우 = -1

if(check == 1){
	session.invalidate();
	// main.jsp 이동전에 세션삭제
	%>
	<script type="text/javascript">
		alert("삭제 완료");
		location.href="main.jsp";
	</script>
	<%
}else if(check == 0){
	%>
	<script type="text/javascript">
		alert("삭제 오류!!");
		history.back();
	</script>
	<%
}else{
	%>
	<script type="text/javascript">
		alert("아이디 오류!!");
		history.back();
	</script>
	<%
}


%>

</body>
</html>