<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
 
<script type="text/javascript">
	function winopen(){
		//alert("버튼클릭");
		if(document.fr.id.value==""){
			alert("ID 값을 입력하세요");
			document.fr.id.focus();
			return;
		}
		// 폼태그에 있는 ID 값을 가져오기
		var fid = document.fr.id.value;
		//alert("입력된 아이디 : "+fid);
		//window.open("페이지 주소","창이름(생략가능)","창크기...옵션")
		window.open("joinIDCheck.jsp?userid="+fid,"","width=400,height=200");
	}
</script>

</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
	<jsp:include page="../inc/top.jsp"/>
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 본문메인이미지 -->
<div id="sub_img_member"></div>
<!-- 본문메인이미지 -->
<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="#">Join us</a></li>
<li><a href="#">Privacy policy</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->
<article>
<h1>Join Us</h1>
<form action="joinPro.jsp" method="post" id="join" name="fr">
<fieldset>
	<legend>Basic Info</legend>
		<label>User ID</label>
		<input type="text" name="id" class="id">
		<input type="button" value="dup. check" class="dup" onclick="winopen()"><br>
		<label>Password</label>
		<input type="password" name="pass"><br>
		<label>Retype Password</label>
		<input type="password" name="pass2"><br>
		<label>Name</label>
		<input type="text" name="name"><br>
		<label>E-Mail</label>
		<input type="email" name="email"><br>
		<label>Retype E-Mail</label>
		<input type="email" name="email2"><br>
	</fieldset>

<fieldset>
<legend>Optional</legend>
<label>Address</label>
<input type="text" name="address"><br>
<label>Phone Number</label>
<input type="text" name="phone"><br>
<label>Mobile Phone Number</label>
<input type="text" name="mobile"><br>
</fieldset>
<div class="clear"></div>
<div id="buttons">
<input type="submit" value="Submit" class="submit">
<input type="reset" value="Cancel" class="cancel">
</div>
</form>
</article>
<!-- 본문내용 -->
<!-- 본문들어가는 곳 -->

<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
	<jsp:include page="../inc/bottom.jsp"></jsp:include>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>