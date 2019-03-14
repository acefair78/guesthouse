<%@page import="member.MemberBean"%>
<%@page import="java.util.List"%>
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
<h1> WebContent/member/memberList.jsp </h1>
<%
	// 세션값 -> 로그인
	// 로그인 x, 관리자가 아닐경우에 페이지이동

	String id = (String)session.getAttribute("id");
	if(id == null || !id.equals("admin")){
		response.sendRedirect("main.jsp");
	}
	
	// memberDAO 객체 생성
	MemberDAO mdao = new MemberDAO();
	
	// 모든 회원정보를 저장
	List<MemberBean> memberList = mdao.getMememberList();
	
	// 표에서 출력
%>
<table border="1">
	<tr>
		<th>아이디</th>
		<th>비밀번호</th>
		<th>이름</th>
		<th>나이</th>
		<th>성별</th>
		<th>이메일</th>
		<th>회원가입일</th>
	</tr>
	<%
	for(int i=0;i<memberList.size();i++){
		//MemberBean mb = (MemberBean)memberList.get(i);
		MemberBean mb = memberList.get(i);
	%>
	<tr>
		<td><%=mb.getId() %></td>
		<td><%=mb.getPass() %></td>
		<td><%=mb.getName() %></td>
		<td><%=mb.getAge() %></td>
		<td><%=mb.getGender() %></td>
		<td><%=mb.getEmail() %></td>
		<td><%=mb.getReg_date() %></td>
	</tr>
	<%
	}
	%>
</table>

</body>
</html>