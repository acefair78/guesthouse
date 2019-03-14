<%@page import="board.BoardBean"%>
<%@page import="java.util.List"%>
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
<h1>WebContent/board/boardList.jsp</h1>

<%
// DB에 있는 글정보를 가져와서 처리 
// DB 처리 객체 생성
BoardDAO bdao = new BoardDAO();

// DB에 저장되어있는 글 개수를 계산 
int count = bdao.getBoardCount();

// 페이징처리 
// 한페이지에 보여줄 글의 개수를 설정
int pageSize=10;
// 현재위치한 페이지의 위치를 가져오기 
String pageNum = request.getParameter("pageNum");
// pageNum값이 없을경우 항상 1페이지
if( pageNum == null ){
	pageNum="1"; 
}

//  시작행 계산하기   1 ~ 11 ~ 21 ~ 31 ~ ....
int currentPage=Integer.parseInt(pageNum);
int startRow = (currentPage-1)*pageSize + 1;

// 끝행 계산하기  10~ 20~ 30~ 40~ ....
int endRow = currentPage * pageSize;

// DB에 글이 있을경우에만 글정보를 모두 가져오기
List boardList = null;
if( count != 0){
	//boardList = bdao.getBoardList();
	boardList = bdao.getBoardList(startRow, pageSize);
}
 
%>
<h1>게시판 글목록 [전체 글의 개수 : <%=count %>]</h1>

<a href="writeForm.jsp"><h3> 글쓰기 </h3></a>


<table border="1">
 <tr>
   <td>번호</td> 
   <td>제목</td>
   <td>작성자</td>
   <td>날짜</td>
   <td>조회수</td>
   <td>IP</td>
 </tr>
 <% for(int i=0;i<boardList.size();i++){ 
        BoardBean bb = (BoardBean)boardList.get(i);
 %>
	<tr>
	   <td><%=bb.getNum() %></td> 
	   <td>
	   <%
	   	// 답글 들여쓰기
	   	int wid = 0;	// 답글에 답글을 밀기위한 변수
	   	if(bb.getRe_lev() > 0){
	   		wid = 10 * bb.getRe_lev();
	   %>
		<img src = "level.gif" height = "15" width = "<%=wid%>">
		<img src = "re.gif">
		<%
	   	}
	   %>
	     <a href="content.jsp?num=<%=bb.getNum()%>&pageNum=<%=pageNum%>"><%=bb.getSubject() %></a>	     
	   </td>
	   <td><%=bb.getName() %></td>
	   <td><%=bb.getDate() %></td>
	   <td><%=bb.getReadcount() %></td>
	   <td><%=bb.getIp() %></td>
	 </tr>
 <% }%>

</table>
<%
  // 페이징 처리 출력
  if(count != 0){
	  // 전체 페이지수 계산 
	  // 글 : 50개 -> 한 화면 : 10개 출력 / 5개 페이지
	  // 글 : 56개 ->  "    : 10개 출력 / 6개 페이지 
	  // 전체 글개수 / 페이지크기 (나머지 있을때 + 1,없으면 +0)
	  
	  int pageCount = count / pageSize +(count % pageSize==0? 0:1 );
	  // 한 화면에 보여줄 페이지 번호의 개수 
	  int pageBlock=10;
	  
	  // 시작 페이지 번호 계산
	  //  1~10 => 1 , 11~20 =>11 , 21~30 => 21
	  int startPage=((currentPage-1)/pageBlock)*pageBlock+1;
	  
	  // 끝 페이지 번호 계산
	  int endPage=startPage + pageBlock -1;
	  if(endPage > pageCount){
		  endPage = pageCount;				  
	  }
	  
	  
	  // 이전
	  if(startPage > pageBlock){
		  %>
		    <a href="list.jsp?pageNum=<%=startPage-pageBlock%>">[이전]</a>
		  <%
	  }
	  
	  // 1...10  11...20  21...30
	  for(int i=startPage;i<=endPage;i++){
		  %>
		    <a href="list.jsp?pageNum=<%=i%>">[<%=i %>]</a>
		  <%
	  }
	  // 다음
	  if(endPage < pageCount){
		  %>
		    <a href="list.jsp?pageNum=<%=startPage+pageBlock%>">[다음]</a>
		  <%
	  }
	  
	  
	  
  }


%>








</body>
</html>