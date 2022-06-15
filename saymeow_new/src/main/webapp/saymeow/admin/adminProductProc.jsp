<%@page import="saymeow.UtilMgr"%>
<%@page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<jsp:useBean id="pMgr" class="saymeow.AdminProductMgr"/>
<%
request.setCharacterEncoding("EUC-KR");
//상품관리: 상품 등록, 수정, 삭제, 검색
String flag = request.getParameter("flag");
String keyWord = request.getParameter("keyWord");
String msg = "오류가 발생하였습니다.";

if(flag.equals("insert")){
	if(pMgr.insertProduct(request))
		msg = "상품을 등록하였습니다.";
}else if(flag.equals("update")){
	if(pMgr.updateProduct(request))
		msg = "상품을 수정하였습니다.";
}else if(flag.equals("delete")){
	if(pMgr.deleteProduct(UtilMgr.parseInt(request, "pnum")))
		msg = "상품을 삭제하였습니다.";
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