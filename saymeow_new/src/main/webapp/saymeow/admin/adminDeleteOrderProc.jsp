<%@page import="saymeow.UtilMgr"%>
<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:useBean id="aoMgr" class="saymeow.AdminOrderMgr"/>
<%
	String strOnums = request.getParameter("onum");
   	System.out.println(strOnums);
   	
   	String[] strOnumsArr = strOnums.split(";");
   	for(int i=0; i<strOnumsArr.length; i++){
   		aoMgr.deleteOrder(strOnumsArr[i]);
   	}
   	
   	
%>
<script>
	alert('�����Ͻ� �ֹ������ �����Ǿ����ϴ�!');
	location.href = "adminOrder.jsp";
</script>