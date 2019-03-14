<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1> WebContent/member/insertPro.jsp </h1>
<%
	// 한글처리
	request.setCharacterEncoding("UTF-8");

	// 파라미터값 가져오기
	// 나이(정수형), 날짜 정보(Timestamp)
/*	String id = request.getParameter("id");
	String pw = request.getParameter("pass");
	String name = request.getParameter("name");
	int age = Integer.parseInt(request.getParameter("age"));
	String gender = request.getParameter("gender");
	String email = request.getParameter("email");
	Timestamp reg_date = new Timestamp(System.currentTimeMillis());
	
	// Form 페이지에서 전달받은 정보를 저장
	// MemberBean 객체에 저장
/*	MemberBean mb = new MemberBean();
	mb.setId(id);
	mb.setName(name);
	mb.setPass(pw);
	mb.setAge(age);
	mb.setGender(gender);
	mb.setEmail(email);
	mb.setReg_date(reg_date); */
%>
	
	<!-- 액션태그 자바빈 객체 생성(m) -->
	<jsp:useBean id="m" class="member.MemberBean"/>
		<!-- 전달받은 파라미터값 저장 -->
	<jsp:setProperty property="*" name="m"/>
	<%
		// 날짜 정보를 저장 (Form태그에서 전달하지 않는 정보)
		m.setReg_date(new Timestamp(System.currentTimeMillis()));	
	%>
	
<%
	// 디비 연결 & 데이터 저장
	// DB 연결에 필요한 정보 저장
	
	MemberDAO mdao = new MemberDAO();
	
	// 메서드를 사용해서 회원 가입 처리
	// insertMember()
	mdao.insertMember(m);
	

		
%>

<script type="text/javascript">
//회원가입 성공 메세지(alert)
// 페이지 이동(loginForm.jsp)
alert("회원가입 성공!!");
location.href="loginForm.jsp";
</script>

</body>
</html>