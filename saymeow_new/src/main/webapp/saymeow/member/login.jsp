<!-- 로그인안하면 접근불가한 기능의경우 로그인으로 이동된다. 그러므로 사용자의 편의성을 위해서는 보고있던 페이지로 이동할 수 있게 하는 것이 좋다.
그런데 어느페이지를 보고있었는지 변수를 받아서 if절로 구분해야하는데, 이건 차후에 시간 남으면 구현하면 좋을 것 같다.-->
<!-- 취합완료 -->
<%@page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<jsp:useBean id="mBean" class="saymeow.MemberBean" />
<jsp:useBean id="mMgr" class="saymeow.MemberMgr" />                                      
<%
	//<input type="button" value="회원정보수정" onclick="location.href='memberUpdate.jsp';"><<회원정보수정 버튼
	String cookie = "";
	Cookie[] cookies = request.getCookies(); // 저장된 쿠키들을 담기위한 배열
	for(int i=0; i<cookies.length; i++){
		if(cookies[i].getName().equals("userId"))
			cookie = cookies[i].getValue();
			// System.out.println("쿠키에 저장된 ID : " + cookie);
	}
	
%>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<!-- 외부 CSS -->				
					
<!-- 부트스트랩 CSS -->						
<link						
href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"						
rel="stylesheet"						
integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"						
crossorigin="anonymous">	
<link rel="stylesheet" href="../css/styleTW.css">						
<%@include file="../top2.jsp"%>
</head> 
<body> 
<section class="loginsection">
	<form method="post" action="loginProc.jsp">
		<table id="loginTbl">
			<tr align="center"> 
				<td colspan="2">
					<h3>로그인</h3>
				</td>
			</tr>
			<tr align="center" class="idPwdTr">
				<td colspan="2">
					<input class="idTf" name="id" value="<%=cookie%>" placeholder=" 아이디">
					<input class="pwdTf" name="pwd" type='password' placeholder=" 비밀번호">
				</td>	
			</tr>
			<tr align="left"> 
				<td class="rememberTd">
					<span class="remember">
						아이디 저장&nbsp;
						<input type="checkbox" name="checkbox" value="<%=cookie%>">
					</span>
				</td>
			</tr>
			<tr align="center">
				<td>
					<span>
						<button type="submit" class="loginBtn">로그인</button>
					</span>
				</td>
				<td>
					<span>
						<input type="button" class="joinBtn" value="회원가입" onclick="location.href='member2.jsp'">
					</span>			
				</td>
			</tr>
		</table>
		<table id="findTbl">
			<tr align="center">
				<td>
					<input type="button" class="findIdBtn" value="아이디찾기" onclick="location.href='findid.jsp'">
					<lable style="color:#a0a0a0; font-size:0.7em;">|</lable>
					<input type="button" class="findPwdBtn" value="비밀번호찾기" onclick="location.href='findPw.jsp'">
				</td>
			</tr>
			<tr align="center">
				<td>
					<img src="../image/banner.png" width="480vw" style="margin:4vh 0 1vh 0; object-fit: cover;">
				</td>
			</tr>
		</table>
		<table id="infoTbl">
			<tr align="center">
				<td>
					<lable style="color:#a0a0a0; font-size:0.7em;">이용약관</lable> 
					<lable style="color:#a0a0a0; font-size:0.7em;">|</lable>
					<lable style="color:#a0a0a0; font-size:0.7em;">개인정보처리방침</lable>
					<lable style="color:#a0a0a0; font-size:0.7em;">|</lable>
					<lable style="color:#a0a0a0; font-size:0.7em;">책임의 한계와 법적고지</lable>
					<lable style="color:#a0a0a0; font-size:0.7em;">|</lable>
					<lable style="color:#a0a0a0; font-size:0.7em;">회원정보 고객센터</lable>
				</td>
			</tr>
			<tr align="center">
				<td>
					<img src="../image/saymeow_logo_dark.png" width="40px" height="35px">
					<label style="color:#a0a0a0; font-size:0.7em;">Copyright SAYMEOW Corp. All Rights Reserved.</label>
				</td>
			</tr>
		</table>
	</form>	
</section>	
</body> 
</html>