<!-- ���տϷ� -->

<!-- ����ȭ�� -->
<%@page import="saymeow.UtilMgr"%>
<%@page import="saymeow.ProductBean"%>
<%@page import="java.util.Vector"%>
<%@page import="saymeow.ProductMgr"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<% 
ProductMgr mgr = new ProductMgr();
Vector<ProductBean> pvlist = mgr.getP4(); // �α��ǰ 10�� ����Ʈ��
Vector<ProductBean> nvlist = mgr.getP3(); // �Ż�ǰ 10�� ����Ʈ��
%>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <title>Index</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <!-- ��Ʈ��Ʈ�� CSS -->
	<link
		href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
		rel="stylesheet"
		integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
		crossorigin="anonymous">    
	    <link rel='stylesheet' type='text/css' media='screen' href='css/index.css'>		
<%@ include file="top2.jsp" %>
</head>
<script>
function send_form(frmId) { // form ����
	document.getElementById(frmId).submit();
}
</script>
<body>
	<!-- ��� -->
    <section class="bsection">
	<img src="image/banner2.png" height="160em" width="1000em">
    </section>	
	<!-- ��ǰ����Ʈ�� -->
	<section class="psection">
	
	
	<div class="populartitle">
				<div class="popular">�ǽð� �α��ǰ</div>
				<div class="popualrmore"><a href="product/food.jsp?sort=5">������></a></div>
				</div>
			
			<div class="plist">
				<ul class="prow">
					<%
						for (int i=0; i<pvlist.size(); i++) {
						ProductBean pbean = pvlist.get(i);
					%>
					<li>
					<a href="product/productDetail.jsp?pnum=<%=pbean.getPnum()%>">
					<img src="image/<%=pbean.getImage()%>" height="200" width="200">
						<%=pbean.getPname()%></a>
						<form method="post" id="frmP" action="product/productDetail.jsp">
							<input type=hidden name="id" value="<%=id%>">
							<input type=hidden name="pnum" value="<%=pbean.getPnum()%>">
						</form>
						<%=UtilMgr.monFormat(pbean.getPrice1())%>��<br><br>
					</li>
					<%} //--for%>
				</ul>	
			</div>	
				<div class="newtitle">
				<div class="new">�Ż�ǰ</div>
				<div class="newmore"><a href="product/food.jsp?sort=0">������></a></div>	
				</div>
							
	<div class="plist">

				
				<ul class="prow">
					<%
						for (int i=0; i<pvlist.size(); i++) {
						ProductBean pbean = nvlist.get(i);
					%>
					<li>
					<a href="product/productDetail.jsp?pnum=<%=pbean.getPnum()%>">
					<img src="image/<%=pbean.getImage()%>" height="200" width="200">
						<%=pbean.getPname()%></a>
						<form method="post" id="frmP" action="product/productDetail.jsp">
							<input type=hidden name="id" value="<%=id%>">
							<input type=hidden name="pnum" value="<%=pbean.getPnum()%>">
						</form>
						<%=UtilMgr.monFormat(pbean.getPrice1())%>��<br><br>
					</li>
					<%} //--for%>
				</ul>
				
				
				
			</div>

		</section>
</body>				
</html>