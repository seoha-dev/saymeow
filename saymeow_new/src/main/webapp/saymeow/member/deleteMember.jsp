<%@page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>  
<jsp:useBean id="mMgr" class="saymeow.MemberMgr" />
<jsp:useBean id="mBean" class="saymeow.MemberBean" /> 
<jsp:setProperty name="mBean" property="*" />
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="EUC-KR">
<title>회원탈퇴</title>
    <!-- 부트스트랩 CSS -->
	<link
		href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
		rel="stylesheet"
		integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
		crossorigin="anonymous">    
<%@ include file="../top2.jsp" %>
</head> 
<body> 
<div class="d-flex align-items-start">
	<div class="nav flex-column nav-pills me-3" id="v-pills-tab" role="tablist" aria-orientation="vertical">
		<a href="orderList.jsp"><button class="nav-link" id="v-pills-home-tab" data-bs-toggle="pill" data-bs-target="#v-pills-home" type="button" role="tab" aria-controls="v-pills-home" aria-selected="true">주문내역조회</button></a>
		<a href="memberUpdate.jsp"><button class="nav-link" id="v-pills-profile-tab" data-bs-toggle="pill" data-bs-target="#v-pills-profile" type="button" role="tab" aria-controls="v-pills-profile" aria-selected="false">회원정보수정</button></a>
		<a href="readMyReview.jsp"><button class="nav-link" id="v-pills-messages-tab" data-bs-toggle="pill" data-bs-target="#v-pills-messages" type="button" role="tab" aria-controls="v-pills-messages" aria-selected="false">내 리뷰 목록</button></a>
		<a href="deleteMember.jsp"><button class="nav-link active" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">회원탈퇴</button></a>
	</div>
	<div class="tab-content" id="v-pills-tabContent" align="center" style="margin:0 auto;">








	<div align="center"><br><br>
	<h4>회원탈퇴</h4>
	<br>
	<form method="psot" action="deleteMemberProc.jsp">
	비밀번호 <input type="password"name="pwd">
	<input type="hidden" name="id" value="<%=id%>">
	<input type="submit" value="회원탈퇴" class="btn btn-primary" style="font-size:0.7em; margin:0.1vw;">
	</form><br>
	*회원탈퇴를 위해서 비밀번호를 입력하세요.
	</div>
	
	
	</div>
</body> 
</html>