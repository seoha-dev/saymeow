<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="cbean" class="saymeow.CartBean"/>
<jsp:useBean id="cMgr" class="saymeow.CartMgr"/>
<%
	String snum[] = request.getParameterValues("cch");
	String msg = "장바구니에서 삭제되었습니다.";
	for(int i=0;i<snum.length;i++){
		cMgr.deleteCart(Integer.parseInt(snum[i]));
	}
%>
<script>
	alert("<%=msg%>");
	location.href = "cartList.jsp";
</script>