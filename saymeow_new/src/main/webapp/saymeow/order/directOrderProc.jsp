<!-- �ٷ��ֹ��ϱ� ó�������� -->
<%@page import="saymeow.UtilMgr"%>
<%@page import="saymeow.DirectOrderBean"%>
<%@page import="saymeow.OrderBean"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="oMgr" class="saymeow.OrderMgr"/>
<jsp:useBean id="cMgr" class="saymeow.CartMgr"/>

<%
	String msg = "����â���� �̵��մϴ�.";
	// direct.jsp���� �� �޾ƿ���
	int onum = UtilMgr.parseInt(request, "onum");
	String oid = request.getParameter("oid");
	String state = request.getParameter("state");
	
	oMgr.updateDirectOrder(oid, state); // order ���̺� �߰�
%>
<form name="movePaymentFrm">
	<input type="hidden" name="onum" value="<%=onum%>">
</form>
<script>
	alert("<%=msg%>");
	document.movePaymentFrm.action="directOrder.jsp"; // �ٷ��ֹ����� �����ϴ� ������
	document.movePaymentFrm.submit();
</script>