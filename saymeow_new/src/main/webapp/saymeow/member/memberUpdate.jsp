<!-- 취합완료했으나 회원가입 시 고양이 정보 입력안했으면 에러남. -->
<%@page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%> 
<%@ page import="java.util.*,saymeow.*"%>
<%request.setCharacterEncoding("EUC-KR");
String mid = null;
if(request.getParameter("mid")!=null){
	mid = request.getParameter("mid");
}
%>
<jsp:useBean id="mMgr" class="saymeow.MemberMgr" /> 
<html>
<head>
<title>회원수정</title>
<link href="../css/styleTW.css" rel="stylesheet" type="text/css">
<script src="script.js"></script>
</head>				
<!-- 부트스트랩 CSS -->						
<link						
href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"						
rel="stylesheet"						
integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"						
crossorigin="anonymous">
<%@ include file="../top2.jsp"%>
<body>
	<div class="d-flex align-items-start">
		<div class="nav flex-column nav-pills me-3" id="v-pills-tab" role="tablist" aria-orientation="vertical">
			<a href="orderList.jsp"><button class="nav-link" id="v-pills-home-tab" data-bs-toggle="pill" data-bs-target="#v-pills-home" type="button" role="tab" aria-controls="v-pills-home" aria-selected="true">주문내역조회</button></a>
			<a href="memberUpdate.jsp"><button class="nav-link active" id="v-pills-profile-tab" data-bs-toggle="pill" data-bs-target="#v-pills-profile" type="button" role="tab" aria-controls="v-pills-profile" aria-selected="false">회원정보수정</button></a>
			<a href="readMyReview.jsp"><button class="nav-link" id="v-pills-messages-tab" data-bs-toggle="pill" data-bs-target="#v-pills-messages" type="button" role="tab" aria-controls="v-pills-messages" aria-selected="false">내 리뷰 목록</button></a>
			<a href="deleteMember.jsp"><button class="nav-link" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">회원탈퇴</button></a>
		</div>
		<div class="tab-content" id="v-pills-tabContent" align="center" style="margin:0 auto;">
			<%
			MemberBean mBean;
			if(request.getParameter("mid")!=null){
				mBean = mMgr.getMember(mid);
			} else {
				mBean = mMgr.getMember(id);
			}
			%>
			<form name="regForm" method="post" action="memberUpdateProc.jsp">
				<h3 style="margin:5vh auto;">회원정보 수정</h3>
				<table class="table" style="border:1px solid #eee;">
					<tr>
						<td>아이디</td>
						<td><%=mBean.getId()%></td>
					</tr>
					<tr>
						<td>패스워드</td>
						<td><input name="pwd" value="<%=mBean.getPwd()%>" size="17"></td>
					</tr>
					<tr>
						<td>이름</td>
						<td><input name="name" value="<%=mBean.getName()%>" size="17"></td>
					</tr>
					<tr>
						<td>생년월일</td>
						<td><input name="birthday" size="6" value="<%=mBean.getBirthday()%>" style="width:9.2vw;">&nbsp;ex)830815</td>
					</tr>
					<tr>
						<td>전화번호</td>
						<td><input name="phone" value="<%=mBean.getPhone()%>" size="17"></td>
					</tr>
					<tr>
						<td>이메일</td>
						<td><input name="email" size="17"value="<%=mBean.getEmail()%>"></td>
					</tr>
					<tr>
						<td>주소</td>
						<td><input name="address" size="17" value="<%=mBean.getAddress()%>"></td>
					</tr>
					<tr>
						<td>고양이이름</td>
						<td><input name="petName" value="<%=mBean.getPetName()%>" size="17"></td>
					</tr>
					<tr>
						<td>고양이나이</td>
						<td><input name="petAge" value="<%=mBean.getPetAge()%>" size="6" style="width:9.2vw;">&nbsp;ex)xxxx-xx-xx</td>
					</tr>
					<tr>
						<td>고양이성별</td>
						<td>
							남<input type="radio" name="petGender" value="0"
							<%=mBean.getPetGender()==0 ? "checked" : ""%>>&nbsp;
							여<input type="radio" name="petGender" value="1"
							<%=mBean.getPetGender()==1 ? "checked" : ""%>>
						</td>
					</tr>
					<tr>
						<td>고양이품종</td>
						<td><input name="petBreed" value="<%=mBean.getPetBreed()%>" size="17"></td>
					</tr>
				</table>
				<div style="margin-bottom:3vh;">
					<input type="submit" value="수정완료" style="width:5vw; height: 5vh; border:1px solid #eee;">
					<input type="reset" value="다시쓰기" class="lbtn" style="width:5vw; height: 5vh; border:1px solid #eee;">
					<input type="button" value="회원탈퇴" onclick="location.href='deleteMember.jsp'" class="lbtn" style="width:5vw; height: 5vh; border:1px solid #eee;">	
				</div>
				<input type="hidden" name="id" value="<%=id%>">
			</form>
  		</div>
	</div>
</body>
</html>