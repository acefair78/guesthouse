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
<h1> WebContent/member/updatePro.jsp </h1>
<%

// 세션값 확인(id)
	String id = (String)session.getAttribute("id");
// 세션값 없을경우 로그인 페이지로 이동
	if(id==null){
		response.sendRedirect("loginForm.jsp");
	}

// 한글처리
	request.setCharacterEncoding("UTF-8");
// 수정 정보를 저장 객체 생성(액션태그)
// 수정정보를 저장(액션태그)
%>
	<jsp:useBean id="mb" class="member.MemberBean"/>
	<jsp:setProperty property="*" name="mb"/>
<%
// MemberDAO 객체 생성
MemberDAO mdao = new MemberDAO();
// updataMember(수정할 회원정보);
int check = mdao.updateMember(mb);
// 수정 결과에 따라서 처리 동작을 구분
//System.out.println(check);

// check = 1
// check = 0
// check = -1

// 수정 결과에 따라서 처리 동작을 구분
if(check == 1){
	%>
	<script type="text/javascript">
		alert("수정 완료");
		location.href="main.jsp";
	</script>
	<%
}else if(check == 0){
	%>
	<script type="text/javascript">
		alert("비밀번호 오류!!");
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

// 정상수정-> main 페이지 이동

// 아이디, 비밀번호 틀린경우 -> 페이지 뒤로이동
%>

</body>
</html>