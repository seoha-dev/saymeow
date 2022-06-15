<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="oMgr" class="saymeow.OrderMgr"/>
<jsp:useBean id="obean" class="saymeow.OrderBean"/>
<%
	String snum[] = request.getParameterValues("och");
	for(int i=0;i<snum.length;i++){
		oMgr.cancleOrder(Integer.parseInt(snum[i]));
	}%>
	<%
	response.sendRedirect("orderList.jsp");
	%>