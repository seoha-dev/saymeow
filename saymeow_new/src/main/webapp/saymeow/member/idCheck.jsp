<%@page contentType="text/html;charset=EUC-KR"%>
<%@page import="saymeow.MemberMgr" %>
<jsp:useBean id="mMgr" class="saymeow.MemberMgr" />
<%
   		request.setCharacterEncoding("EUC-KR");
   		String id = request.getParameter("id");
   		boolean check = mMgr.checkId(id);
%> 
<html>
<head>
<title>ID�ߺ�üũ</title>
<link href="../css/styleTW.css" rel="stylesheet" type="text/css">
<script src="../script.js"></script>
</head>
<body>
<br>
<div align="center">
<b><%=id%></b>
<%
	  if(check){
	     out.println("�� �̹� �����ϴ� ID�Դϴ�.<p/>");%>    
<%	}else{    
	     out.println("�� ��� ���� �մϴ�.<p/>");
	}
%>
<a href="javascript:this.close();">�ݱ�</a>
</div>
</body>
</html>