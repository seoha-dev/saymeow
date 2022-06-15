<%@page import="saymeow.UtilMgr"%>
<%@page contentType="text/html; charset=EUC-KR"%>

<%
String id = request.getParameter("id");
response.sendRedirect("adminMember.jsp?id="+id);
%>

