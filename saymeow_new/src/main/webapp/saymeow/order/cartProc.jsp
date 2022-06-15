<!-- ����ó�������� -->
<%@page import="saymeow.ProductBean"%>
<%@page import="saymeow.OrderBean"%>
<%@page import="saymeow.UtilMgr"%>
<%@page import="saymeow.CartBean"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="cart" class="saymeow.CartBean" />
<jsp:useBean id="cMgr" class="saymeow.CartMgr" />
<jsp:useBean id="oMgr" class="saymeow.OrderMgr" />
<jsp:useBean id="pdMgr" class="saymeow.ProductDetailMgr"/>

<%
String pname = null;
pname = request.getParameter("pname");
String flag = request.getParameter("flag");
String snum[] = null;
snum = request.getParameterValues("cch");
String msg = "";
String soldout = "";

for(int j=1;j<snum.length;j++){
	CartBean cart2 = cMgr.checkCart(Integer.parseInt(snum[j]));
	ProductBean pbean2 = pdMgr.getProduct(cart2.getPnum());
	if(pbean2.getStock()<cart2.getQty()){
		soldout = "true";
	}
}

int allTotal = 0;
String uAllTotal = "";

if (flag.equals("delete")) {
	for (int i = 0; i < snum.length; i++) {
		cMgr.deleteCart(Integer.parseInt(snum[i]));
	}
%>
<script>
	alert("��ٱ��Ͽ��� �����Ǿ����ϴ�.");
	location.href = "cartList.jsp";
</script>
<%
} else if (soldout!="") {
%>
<script>
	alert("������ ��ǰ �� ��� ���ų� �ֹ� �� �������� �۽��ϴ�.");
	location.href = "cartList.jsp";
</script>
<%
} else if (flag.equals("order")) {
%>
<!DOCTYPE html>
<html>
<head>
<link rel='stylesheet' type='text/css' media='screen' href='../css/cart.css'>
<title>�����ϱ�</title>
<script src="../saymeowScript.js"></script>
<!-- ��Ʈ��Ʈ�� CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<%@ include file="../top2.jsp"%>
</head>
<body>
	<section class="contents"><br><br>
		<h2 style="margin:3vh auto;">����</h2><br>
		<form method="post" name="chFrm" action="orderProc.jsp" style="border:1px solid #a0a0a0; width:50vw; margin: 0 auto;">
			<h5 style="margin:3vh;">[����� �Է�]</h5><br>
				<input type="checkbox" name="loadAddressBtn" onchange="loadAddress()" style="transform:translateX(-10vw)">
				<label style="transform:translateX(-10vw); margin-bottom:2vh;">�ֱ� ����� ��������</label><br>
				<input name="address" size="60" style="width:30vw; border:1px solid #a0a0a0; height:5vh; margin-bottom:3vh;">
				<input type="hidden" name="flag" value="cart"><br><br>
			<h5>[�ֹ�����]</h5><br>
			<table>
				<thead>
					<tr style="height:5vh;">
						<th>NO</th>
						<th>��ǰ��</th>
						<th>�ǸŰ�</th>
						<th>����</th>
						<th>�ݾ�</th>
					</tr>
				</thead>
				<%
				for (int i = 1; i < snum.length; i++) {
					cart = cMgr.checkCart(Integer.parseInt(snum[i]));
					int price = cart.getPrice1();
					int quantity = cart.getQty();
					int total = price * quantity;
					allTotal += total;
					uAllTotal = UtilMgr.monFormat(allTotal);
				%>
					<tr>
						<td><%=i%></td>
						<td><%=cart.getPname()%></td>
						<td><%=UtilMgr.monFormat(cart.getPrice1())%>��</td>
						<td><%=cart.getQty()%></td>
						<td><%=UtilMgr.monFormat(total)%>��</td>
						<input type="hidden" name="cch" value="<%=Integer.parseInt(snum[i])%>">
						<input type="hidden" name="cnum" value="<%=cart.getCnum()%>">
					</tr>
				<%
				} // --- for�� ��
				%>
			</table><br><br>
			<label style="font-size:1.2em;">�� �����ݾ��� </label> 
			<label style="font-size:1.8em;"><b><%=uAllTotal %></b></label>
			<label style="font-size:1.2em;">�� �Դϴ�.</label><br>
			<div style="margin:3vh;">
				<input type="button" value="���" onclick="history.back()" style="color: #eee; border:1px solid #9598ca; width:7vw; font-size:1.4em; height:5vh; background-color: #9598ca;"> 
				<input type="submit" value="����" style="color: #eee; border:1px solid #9598ca; width:7vw; font-size:1.4em; height:5vh; background-color: #9598ca;">
			</div>
		</form>
	</section>
<script>
	function loadAddress(){
		f = document.chFrm;
		var address = '<%=oMgr.getNewestAddress(id)%>';
		
		if(address!=null && address!='null'){ // �ֹ����� �ִٸ�
			if(f.loadAddressBtn.checked){ // üũ�Ѵٸ�
				f.address.value = '<%=oMgr.getNewestAddress(id)%>';
			} else { // üũ �����Ѵٸ�
				f.address.value = '';
			}
			
		} else { // �ֹ����� ���ٸ�
			alert('���� �ֱ� �ֹ������� �����ϴ�!');
			f.loadAddressBtn.checked = false; // üũ������Ŵ
		}
		
	}
</script>
</body>
</html>
<%
} // -- if�� ��
%>