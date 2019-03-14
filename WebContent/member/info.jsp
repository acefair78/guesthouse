<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1> WebContent/member/info.jsp </h1>

<%
	// 세션값이 있는지 없는지를 판단
	String id = (String)session.getAttribute("id");

	if(id==null){
		response.sendRedirect("loginForm.jsp");
	}
	
	// 디비 연결 처리 객체 생성
	MemberDAO mdao = new MemberDAO();
	
	// 회원정보(MemberBean)를 가져오는 메서드 getMember(id);
	MemberBean mb = mdao.getMember(id);
	
	
	// 한글처리
		request.setCharacterEncoding("UTF-8");

		// 디비 연결 & 데이터 저장
			final String DRIVER = "com.mysql.jdbc.Driver";
			final String URL = "jdbc:mysql://localhost:3306/jspdb";
			final String ID = "root";
			final String PW = "1234";
			// 1. jdbc 드라이버연결
			Class.forName(DRIVER);
			// 2. DB연결
			Connection con = DriverManager.getConnection(URL, ID, PW);
			// 3. sql작성 & pstmt 객체생성
			String sql="select * from member where id=?";

			PreparedStatement pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, id);
			// 여기서 id 는 세션에서 가지고온 id값
			
			// 4. 실행
			ResultSet rs = pstmt.executeQuery();
			
			//String id;
			String pw="";
			String name="";
			int age =0;
			String gender="";
			int zonecode=0;
			String address="";
			String detailaddress="";
			String extraaddress="";
			String email="";
			String jumin="";
			Timestamp reg_date =null;
			
			
			if(rs.next()){
				pw = rs.getString("pw");
				name = rs.getString("name");
				age = rs.getInt("age");
				gender = rs.getString("gender");
				zonecode = rs.getInt("zonecode");
				address = rs.getString("address");
				detailaddress = rs.getString("detailaddress");
				extraaddress = rs.getString("extraaddress");
				email = rs.getString("email");
				jumin = rs.getString("jumin");
				reg_date = rs.getTimestamp("reg_date");
				
				
			}
%>

<table border="1">
	<tr>
		<th>아이디</th>
		<th>비밀번호</th>
		<th>이름</th>
		<th>나이</th>
		<th>성별</th>
		<th>주소</th>
		<th>이메일</th>	
		<th>회원가입일</th>
	</tr>
	<tr>
		<td><%=mb.getId() %></td>
		<td><%=mb.getPass() %></td>
		<td><%=mb.getName() %></td>
		<td><%=mb.getAge() %></td>
		<td><%=mb.getGender() %></td>
		<td><%=rs.getInt("zonecode")+" "+rs.getString("address")+" "+rs.getString("detailaddress")+" "+rs.getString("extraaddress")%></td>
		<td><%=mb.getEmail() %></td>
		<td><%=mb.getReg_date() %></td>
		
	</tr>

</table>
<br><br><br>

<h2><a href="main.jsp">main 으로 이동</a></h2>
</body>
</html>