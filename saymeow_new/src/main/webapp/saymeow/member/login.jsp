<!-- �α��ξ��ϸ� ���ٺҰ��� ����ǰ�� �α������� �̵��ȴ�. �׷��Ƿ� ������� ���Ǽ��� ���ؼ��� �����ִ� �������� �̵��� �� �ְ� �ϴ� ���� ����.
�׷��� ����������� �����־����� ������ �޾Ƽ� if���� �����ؾ��ϴµ�, �̰� ���Ŀ� �ð� ������ �����ϸ� ���� �� ����.-->
<!-- ���տϷ� -->
<%@page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<jsp:useBean id="mBean" class="saymeow.MemberBean" />
<jsp:useBean id="mMgr" class="saymeow.MemberMgr" />                                      
<%
	//<input type="button" value="ȸ����������" onclick="location.href='memberUpdate.jsp';"><<ȸ���������� ��ư
	String cookie = "";
	Cookie[] cookies = request.getCookies(); // ����� ��Ű���� ������� �迭
	for(int i=0; i<cookies.length; i++){
		if(cookies[i].getName().equals("userId"))
			cookie = cookies[i].getValue();
			// System.out.println("��Ű�� ����� ID : " + cookie);
	}
	
%>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<!-- �ܺ� CSS -->				
					
<!-- ��Ʈ��Ʈ�� CSS -->						
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
					<h3>�α���</h3>
				</td>
			</tr>
			<tr align="center" class="idPwdTr">
				<td colspan="2">
					<input class="idTf" name="id" value="<%=cookie%>" placeholder=" ���̵�">
					<input class="pwdTf" name="pwd" type='password' placeholder=" ��й�ȣ">
				</td>	
			</tr>
			<tr align="left"> 
				<td class="rememberTd">
					<span class="remember">
						���̵� ����&nbsp;
						<input type="checkbox" name="checkbox" value="<%=cookie%>">
					</span>
				</td>
			</tr>
			<tr align="center">
				<td>
					<span>
						<button type="submit" class="loginBtn">�α���</button>
					</span>
				</td>
				<td>
					<span>
						<input type="button" class="joinBtn" value="ȸ������" onclick="location.href='member2.jsp'">
					</span>			
				</td>
			</tr>
		</table>
		<table id="findTbl">
			<tr align="center">
				<td>
					<input type="button" class="findIdBtn" value="���̵�ã��" onclick="location.href='findid.jsp'">
					<lable style="color:#a0a0a0; font-size:0.7em;">|</lable>
					<input type="button" class="findPwdBtn" value="��й�ȣã��" onclick="location.href='findPw.jsp'">
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
					<lable style="color:#a0a0a0; font-size:0.7em;">�̿���</lable> 
					<lable style="color:#a0a0a0; font-size:0.7em;">|</lable>
					<lable style="color:#a0a0a0; font-size:0.7em;">��������ó����ħ</lable>
					<lable style="color:#a0a0a0; font-size:0.7em;">|</lable>
					<lable style="color:#a0a0a0; font-size:0.7em;">å���� �Ѱ�� ��������</lable>
					<lable style="color:#a0a0a0; font-size:0.7em;">|</lable>
					<lable style="color:#a0a0a0; font-size:0.7em;">ȸ������ ������</lable>
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