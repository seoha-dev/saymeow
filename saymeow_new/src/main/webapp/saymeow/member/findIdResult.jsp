<%@page import="saymeow.MemberMgr"%>
<%@page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>                                      
<jsp:useBean id="mMgr" class="saymeow.MemberMgr" />
<%
	request.setCharacterEncoding("EUC-KR"); // �ѱ�ó��

	String name = null;
	if(request.getParameter("name")!=null){
		name = request.getParameter("name");
	}
	
	String email = null;
	if(request.getParameter("email")!=null){
		email = request.getParameter("email");
	}
	
	String mid = mMgr.findId(name, email);
 
%>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="EUC-KR">
<link rel="stylesheet" href="../css/styleTW.css">
<!-- ��Ʈ��Ʈ�� CSS -->						
<link						
href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"						
rel="stylesheet"						
integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"						
crossorigin="anonymous">
<%@ include file="../top2.jsp"%>
</head>
<body id="findIdResultBd"> 
	<form name="idsearch" method="post">
	<%
		if (mid != null) {
	%>
			<div class="searchRs">
				<div class="lbDiv">
					<label class="lb">ȸ������ ���̵��</label> 
					<label class="mid">'<%=mid%>'</label>
					<label class="lb inlineLb">�Դϴ�.</label>
				</div>
				<div class="btns">
			 		<input type="button" value="�α���" class="loginBtn" onClick ="location.href='login.jsp'"/>
			 		<input type="button" value="��й�ȣ ã��" class="findPwdBtn" onClick ="location.href='findPw.jsp'"/>
			 	</div>
		 	</div>
	<%
		} else {
	%>
			<div class="searchRs">
				<h3>��ϵ� ȸ�� ������ �����ϴ�.</h3>
				<div class="btns">
					<input type="button" value="�ٽ� ã��" onClick="history.back()"/>
					<input type="button" value="ȸ������" onClick="location.href='member.jsp'"/>
				</div>
			</div>
	<%
  		}
	%> 
      </form>
</body> 
</html>