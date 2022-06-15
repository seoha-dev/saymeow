<%@page import="saymeow.UtilMgr"%>
<%@page import="saymeow.ProductBean"%>
<%@page import="saymeow.AdminProductMgr"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
request.setCharacterEncoding("EUC-KR");
String keyWord = request.getParameter("keyWord"); // �˻��� ��ǰ�̸�
Vector<ProductBean> pvlist = new Vector<ProductBean>();
AdminProductMgr mgr = new AdminProductMgr();

if(keyWord==null || keyWord.isEmpty()) {
	pvlist = mgr.getAllP();
	// System.out.println("[adminProduct.jsp] ��ü ��ǰ ���");
}else {
	pvlist = mgr.getPList(keyWord);
	// System.out.println("[adminProduct.jsp] �˻� ��ǰ ���");
}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <title>adminProduct</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <link rel='stylesheet' type='text/css' media='screen' href='../css/adminProduct.css'>	
<!-- ��Ʈ��Ʈ�� CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<%@ include file="../top2.jsp" %>
</head>
<script>
function send_form(frmId) { // form ����
	document.getElementById(frmId).submit();
}
</script>
<body>
<!-- ���̵�� 40%, â 60% -->
<div class="d-flex align-items-start">
	<div class="nav flex-column nav-pills me-3" id="v-pills-tab" role="tablist" aria-orientation="vertical">
		<a href="adminOrder.jsp"><button class="nav-link" id="v-pills-home-tab" data-bs-toggle="pill" data-bs-target="#v-pills-home" type="button" role="tab" aria-controls="v-pills-home" aria-selected="true">�ֹ�����</button></a>
		<a href="adminMember.jsp"><button class="nav-link" id="v-pills-profile-tab" data-bs-toggle="pill" data-bs-target="#v-pills-profile" type="button" role="tab" aria-controls="v-pills-profile" aria-selected="false">ȸ������</button></a>
		<a href="adminReviewBoard.jsp"><button class="nav-link" id="v-pills-messages-tab" data-bs-toggle="pill" data-bs-target="#v-pills-messages" type="button" role="tab" aria-controls="v-pills-messages" aria-selected="false">�������</button></a>
		<a href="adminProduct.jsp"><button class="nav-link active" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">��ǰ����</button></a>
		<a href="sellHistory.jsp"><button class="nav-link" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">�������</button></a>
		<a href="adminSales.jsp"><button class="nav-link" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">�Ǹŵ�����</button></a>
	</div>
	<div class="tab-content" id="v-pills-tabContent" align="center" style="margin:0 auto;">
		<!-- ���� -->
<section class="contents">
	<div style="margin-top:2vh;">
		<h3 style="text-align: center; margin: 1.5vw; margin-bottom: 2vw;">��ǰ����</h3>
		<table class="table" style="border: 1px solid #eee;">
		<tr style="height:6vh; vertical-align:middle; background-color:#eee; text-align:center; border-style: hidden;">
		<th style="border-right:0.3px solid #FAF0E6;">��ǰ��ȣ</th>
		<th style="border-right:0.3px solid #FAF0E6;">��ǰ�̸�</th>
		<th style="border-right:0.3px solid #FAF0E6;">��з�</th>
		<th style="border-right:0.3px solid #FAF0E6;">�ߺз�</th>
		<th style="border-right:0.3px solid #FAF0E6;">��ǰ����</th>
		<th style="border-right:0.3px solid #FAF0E6;">�ǸŻ���</th>
		<th style="border-right:0.3px solid #FAF0E6;">��ǰ���</th>
		<th style="border-right:0.3px solid #FAF0E6;">��ǰ����</th>
		<th style="border-right:0.3px solid #FAF0E6;">��ǰ����</th>
		</tr>
		<tbody>
<%		
		for (int i=0; i < pvlist.size(); i++) {
		ProductBean pbean = pvlist.get(i);
%>
		<tr>
		<td style="border-right:0.3px solid #FAF0E6;"><%=pbean.getPnum()%></td>
		<td style="border-right:0.3px solid #FAF0E6;"><a href="../product/productDetail.jsp?pnum=<%=pbean.getPnum()%>"><%=pbean.getPname()%></a></td>
		<td style="border-right:0.3px solid #FAF0E6;"><%=pbean.getMclass()%></td>
		<td style="border-right:0.3px solid #FAF0E6;"><%=pbean.getSclass()%></td>
		<td style="border-right:0.3px solid #FAF0E6;"><%=UtilMgr.monFormat(pbean.getPrice1())%></td>
		<td style="border-right:0.3px solid #FAF0E6;"><%=pbean.getPstat()%></td>
		<td style="border-right:0.3px solid #FAF0E6;"><%=pbean.getStock()%></td>
		<td><a href="adminProductUpdate.jsp?pnum=<%=pbean.getPnum()%>">����</a></td>
		<td>
		<form method="post" action="adminProductProc.jsp?flag=delete">
		<input type=hidden name="pnum" value="<%=pbean.getPnum()%>">
		<button type=submit style="background-color:#eee;border:1px solid #eee;color:black; width: 70px; height: 40px;">����</button>
		</form></td> 
		</tr>
		<% } //-for %>		
		</tbody>
		</table><br>
  	</div>
 </section>
 <section> 	
  	<div class="productSearch">
  	<form method="post" action="adminProductProc.jsp?flag=search">
  	<input type="search"  style="text-align: center;" placeholder="��ǰ������ �˻�" name="keyWord">
	<button type="submit" style="background-color:#eee;border:1px solid #eee;color:black; width: 70px; height: 30px;">�˻�</button><br><br>
	<button style="background-color:#eee;border:1px solid #eee;color:black; width: 130px; height: 40px;" onClick="location.href='adminProduct.jsp'">��ü����</button>
	<button style="background-color:#eee;border:1px solid #eee;color:black; width: 130px; height: 40px;" onclick="window.open('adminProductInsert.jsp')">��ǰ���</button ><br><br><br>
	</form>
	</div>
 
</section>
  	</div>
</div>

</body>
</html>