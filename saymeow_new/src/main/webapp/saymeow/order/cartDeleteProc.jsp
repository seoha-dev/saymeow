<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="cbean" class="saymeow.CartBean"/>
<jsp:useBean id="cMgr" class="saymeow.CartMgr"/>
<%
	String snum[] = request.getParameterValues("cch");
	String msg = "��ٱ��Ͽ��� �����Ǿ����ϴ�.";
	for(int i=0;i<snum.length;i++){
		cMgr.deleteCart(Integer.parseInt(snum[i]));
	}
%>
<script>
	alert("<%=msg%>");
	location.href = "cartList.jsp";
</script>