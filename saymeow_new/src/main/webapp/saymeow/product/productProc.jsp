<%@page import="saymeow.UtilMgr"%>
<%@page contentType="text/html; charset=EUC-KR"%>

<%
String mClass = request.getParameter("mClass");
String sClass = request.getParameter("sClass");
String sort = request.getParameter("sort");


if (sClass!=null) { // �ߺз� ���� %>
	<form method="post" id="frm" action="<%=mClass%>.jsp">
		<input type=hidden name="mClass" value="<%=mClass%>">
		<input type=hidden name="sClass" value="<%=sClass%>">
		<input type=hidden name="sort" value="<%=sort%>">
	</form> 
	<script>
		document.getElementById('frm').submit();
	</script> 
<% }else { // �ߺз� �̼��� %>
	<form  method="post" id="frm" action="<%=mClass%>.jsp">
		<input type=hidden name="mClass" value="<%=mClass%>">
		<input type=hidden name="sort" value="<%=sort%>">
	</form> 
	<script>
		document.getElementById('frm').submit();
	</script>
	<% 	}	
	// System.out.println("[proProc]mClass:" + mClass + " /sClass:" + sClass + " /sort:" + sort); 
%>

