<!-- �����ڿ� ȸ���������� ������-->
<%@page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%> 
<%@ page import="java.util.*,saymeow.*"%>
<%request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="mMgr" class="saymeow.MemberMgr" /> 
<html>
<head>
<title>ȸ������</title>
<link href="../css/styleTW.css" rel="stylesheet" type="text/css">
<script src="../script.js"></script>
</head>					
<!-- ��Ʈ��Ʈ�� CSS -->						
<link						
href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"						
rel="stylesheet"						
integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"						
crossorigin="anonymous">
<%@ include file="../top2.jsp"%>
<body>
<div class="d-flex align-items-start">
		<div class="nav flex-column nav-pills me-3" id="v-pills-tab" role="tablist" aria-orientation="vertical">
			<a href="adminOrder.jsp"><button class="nav-link" id="v-pills-home-tab" data-bs-toggle="pill" data-bs-target="#v-pills-home" type="button" role="tab" aria-controls="v-pills-home" aria-selected="true">�ֹ�����</button></a>
			<a href="adminMember.jsp"><button class="nav-link active" id="v-pills-profile-tab" data-bs-toggle="pill" data-bs-target="#v-pills-profile" type="button" role="tab" aria-controls="v-pills-profile" aria-selected="false">ȸ������</button></a>
			<a href="adminReviewBoard.jsp"><button class="nav-link" id="v-pills-messages-tab" data-bs-toggle="pill" data-bs-target="#v-pills-messages" type="button" role="tab" aria-controls="v-pills-messages" aria-selected="false">�������</button></a>
			<a href="adminProduct.jsp"><button class="nav-link" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">��ǰ����</button></a>
			<a href="adminSales.jsp"><button class="nav-link" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">�������</button></a>
			<a href="sellHistory.jsp"><button class="nav-link" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">�Ǹŵ�����</button></a>
		</div>	
	<div class="tab-content" id="v-pills-tabContent" align="center" style="margin:0 auto;">
	<%
		String selectedId = request.getParameter("selectedId");
		MemberBean mBean = mMgr.getMember(selectedId);
	%>
	<form name="regForm" method="post" action="adminMemberUpdateProc.jsp" >
	<br>
	<h2 style="text-align:center;">ȸ������ ����</h2>
		<table id="level">
			<tr>
				<td id="level2">
					<table id="level3">
						<tr>
							<td>���̵�</td>
							<td><input name="id" value="<%=mBean.getId()%>"></td>
						</tr>
						<tr>
							<td>�н�����</td>
							<td><input name="pwd" value="<%=mBean.getPwd()%>" size="17"></td>
						</tr>
						<tr>
							<td>�̸�</td>
							<td><input name="name" value="<%=mBean.getName()%>" size="17"></td>
						</tr>
						<tr>
							<td>�������</td>
							<td><input name="birthday" size="6"
								value="<%=mBean.getBirthday()%>"> ex)830815</td>
						</tr>
						<tr>
							<td>��ȭ��ȣ</td>
							<td><input name="phone" value="<%=mBean.getPhone()%>" size="17"></td>
						</tr>
						<tr>
							<td>�̸���</td>
							<td><input name="email" size="17"value="<%=mBean.getEmail()%>"></td>
						</tr>
						<tr>
							<td>�ּ�</td>
							<td><input name="address" size="17"
								value="<%=mBean.getAddress()%>"></td>
						</tr>
						<tr>
							<td>������̸�</td>
							<td><input name="petName" value="<%=mBean.getPetName()%>" size="17"></td>
						</tr>
						<tr>
							<td>����̳���</td>
							<td><input name="petAge" value="<%=mBean.getPetAge()%>" size="6">ex)xxxx-xx-xx</td>
						</tr>
						<tr>
							<td>����̼���</td>
							<td>
								��<input type="radio" name="petGender" value="0"
								<%=mBean.getPetGender()==0 ? "checked" : ""%>> 
								��<input type="radio" name="petGender" value="1"
								<%=mBean.getPetGender()==1 ? "checked" : ""%>>
							</td>
						</tr>
						<tr>
							<td>�����ǰ��</td>
							<td><input name="petBreed" value="<%=mBean.getPetBreed()%>" size="17"></td>
						</tr>
						
						
					</table>
					
						<input type="submit" value="�����Ϸ�" class="lbtn">
					<input type="reset" value="�ٽþ���" class="lbtn">
					<input type="button" value="ȸ��Ż��" onclick="location.href='deleteMember.jsp'" class="lbtn">
					
				</td>
			</tr>
		</table>
	</form>
  	</div>
</div>
</body>
</html>