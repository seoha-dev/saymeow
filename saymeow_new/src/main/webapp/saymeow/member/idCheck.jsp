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
<title>ID중복체크</title>
<link href="../css/styleTW.css" rel="stylesheet" type="text/css">
<script src="../script.js"></script>
</head>
<body>
<br>
<div align="center">
<b><%=id%></b>
<%
	  if(check){
	     out.println("는 이미 존재하는 ID입니다.<p/>");%>    
<%	}else{    
	     out.println("는 사용 가능 합니다.<p/>");
	}
%>
<a href="javascript:this.close();">닫기</a>
</div>
</body>
</html>