<!-- 바로주문하기 처리페이지 -->
<%@page import="saymeow.UtilMgr"%>
<%@page import="saymeow.DirectOrderBean"%>
<%@page import="saymeow.OrderBean"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="oMgr" class="saymeow.OrderMgr"/>
<jsp:useBean id="cMgr" class="saymeow.CartMgr"/>

<%
	String msg = "결제창으로 이동합니다.";
	// direct.jsp에서 값 받아오기
	int onum = UtilMgr.parseInt(request, "onum");
	String oid = request.getParameter("oid");
	String state = request.getParameter("state");
	
	oMgr.updateDirectOrder(oid, state); // order 테이블에 추가
%>
<form name="movePaymentFrm">
	<input type="hidden" name="onum" value="<%=onum%>">
</form>
<script>
	alert("<%=msg%>");
	document.movePaymentFrm.action="directOrder.jsp"; // 바로주문내역 결제하는 페이지
	document.movePaymentFrm.submit();
</script>