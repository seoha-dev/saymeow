<%@page import="saymeow.UtilMgr"%>
<%@page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<jsp:useBean id="pMgr" class="saymeow.AdminProductMgr"/>
<%
request.setCharacterEncoding("EUC-KR");
//��ǰ����: ��ǰ ���, ����, ����, �˻�
String flag = request.getParameter("flag");
String keyWord = request.getParameter("keyWord");
String msg = "������ �߻��Ͽ����ϴ�.";

if(flag.equals("insert")){
	if(pMgr.insertProduct(request))
		msg = "��ǰ�� ����Ͽ����ϴ�.";
}else if(flag.equals("update")){
	if(pMgr.updateProduct(request))
		msg = "��ǰ�� �����Ͽ����ϴ�.";
}else if(flag.equals("delete")){
	if(pMgr.deleteProduct(UtilMgr.parseInt(request, "pnum")))
		msg = "��ǰ�� �����Ͽ����ϴ�.";
}else if(flag.equals("search")) {
	System.out.println("keyword="+keyWord); %>
	<form  method="post" id="frm" action="adminProduct.jsp">
		<input type=hidden name="keyWord" value="<%=keyWord%>">
	</form> 
	<script>
		document.getElementById('frm').submit();
	</script>
<%}%>
<script>
	alert("<%=msg%>");
	location.href = "adminProduct.jsp";
</script>	