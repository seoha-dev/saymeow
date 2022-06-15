<!-- 바로주문의 결제 처리페이지 -->
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

	if(state=="1" || state.equals("1")){ // 결제전 상태라면
		oMgr.updateDirectOrder(onum, oaddress); // 배송지와 state 업데이트 메소드
		pMgr.stockMinus(onum); // state 변경 후 주문한 qty만큼 product stock에서 빼기
	}
	
%>
<script>
	alert('결제 완료되었습니다!');
	location.href = "../member/orderList.jsp";
</script>