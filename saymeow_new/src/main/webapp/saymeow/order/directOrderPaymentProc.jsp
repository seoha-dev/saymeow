<!-- �ٷ��ֹ��� ���� ó�������� -->
<%@page import="saymeow.ProductMgr"%>
<%@page import="saymeow.UtilMgr"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:useBean id="oMgr" class="saymeow.OrderMgr"/>
<jsp:useBean id="pMgr" class="saymeow.ProductMgr"/>
<%
	int onum = UtilMgr.parseInt(request, "onum");
	String oaddress = request.getParameter("oaddress");
	String state = request.getParameter("state");

	if(state=="1" || state.equals("1")){ // ������ ���¶��
		oMgr.updateDirectOrder(onum, oaddress); // ������� state ������Ʈ �޼ҵ�
		pMgr.stockMinus(onum); // state ���� �� �ֹ��� qty��ŭ product stock���� ����
	}
	
%>
<script>
	alert('���� �Ϸ�Ǿ����ϴ�!');
	location.href = "../member/orderList.jsp";
</script>