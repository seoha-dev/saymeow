<%@page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>  
<jsp:useBean id="mMgr" class="saymeow.MemberMgr" />
<jsp:useBean id="mBean" class="saymeow.MemberBean" /> 
<jsp:setProperty name="mBean" property="*" />
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="EUC-KR">
<title>ȸ��Ż��</title>
    <!-- ��Ʈ��Ʈ�� CSS -->
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
		<a href="orderList.jsp"><button class="nav-link" id="v-pills-home-tab" data-bs-toggle="pill" data-bs-target="#v-pills-home" type="button" role="tab" aria-controls="v-pills-home" aria-selected="true">�ֹ�������ȸ</button></a>
		<a href="memberUpdate.jsp"><button class="nav-link" id="v-pills-profile-tab" data-bs-toggle="pill" data-bs-target="#v-pills-profile" type="button" role="tab" aria-controls="v-pills-profile" aria-selected="false">ȸ����������</button></a>
		<a href="readMyReview.jsp"><button class="nav-link" id="v-pills-messages-tab" data-bs-toggle="pill" data-bs-target="#v-pills-messages" type="button" role="tab" aria-controls="v-pills-messages" aria-selected="false">�� ���� ���</button></a>
		<a href="deleteMember.jsp"><button class="nav-link active" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">ȸ��Ż��</button></a>
	</div>
	<div class="tab-content" id="v-pills-tabContent" align="center" style="margin:0 auto;">








	<div align="center"><br><br>
	<h4>ȸ��Ż��</h4>
	<br>
	<form method="psot" action="deleteMemberProc.jsp">
	��й�ȣ <input type="password"name="pwd">
	<input type="hidden" name="id" value="<%=id%>">
	<input type="submit" value="ȸ��Ż��" class="btn btn-primary" style="font-size:0.7em; margin:0.1vw;">
	</form><br>
	*ȸ��Ż�� ���ؼ� ��й�ȣ�� �Է��ϼ���.
	</div>
	
	
	</div>
</body> 
</html>