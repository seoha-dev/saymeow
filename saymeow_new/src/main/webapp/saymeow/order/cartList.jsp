<%@page import="saymeow.ProductBean"%>
<%@page import="saymeow.ProductMgr"%>
<%@page import="saymeow.UtilMgr"%>
<%@page import="saymeow.CartBean"%>
<%@page import="java.util.Vector"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="cMgr" class="saymeow.CartMgr"/>
<jsp:useBean id="pdMgr" class="saymeow.ProductDetailMgr"/>
<%
	int allTotal = 0;
    String uAllTotal = "";
    
    int checkedTotalPrice = 0; // ��ٱ��Ͽ��� ������ ��ǰ(üũ�ڽ� üũ)�� �� �����ݾ�
    String oid = null;
    int index = 0;
%>
<!DOCTYPE html>
<html>
<head>
<title>��ٱ���</title>
<script>
function cartDelete(form){
	form.flag.value="delete";
	form.submit();
}

function cartOrder(form){
	 var check = null;
	 for(i=0; i<form.cch.length; i++){
		if(form.cch[i].checked){
			check++; // ��ǰ üũ�ڽ� �����ϸ� check +1�� ����
		}
	}
		
	if(check==null){ // �ƹ� üũ�ڽ��� ���� ������ ��
		alert('�ּ� 1�� �̻��� ��ǰ�� �������ּ���.');
	} else { // �ּ� 1���� üũ�ڽ��� �������� �� 
		console.log(check);
		form.flag.value="order";
		form.submit();	
	}
}
 
 function cartInsert(form){
	form.flag.value="insert";
	form.submit();
}
 
 function directOrder(form){
	form.flag.value="direct";
	form.submit();
}

function allChk() {
	c = document.cfrm;
	if(c.allCh.checked/*üũ�̺�Ʈ*/){
		for(i=1;i<c.cch.length;i++){
			c.cch[i].checked = true;
			if(c.cch[i].disabled)
				c.cch[i].checked = false;
		}
	} else {
		for(i=1;i<c.cch.length;i++){
			c.cch[i].checked = false;
		}
	}
}
</script>
<!-- ��Ʈ��Ʈ�� CSS -->
<link
href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
rel="stylesheet"
integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
crossorigin="anonymous">   
<link rel='stylesheet' type='text/css' media='screen' href='../css/cart.css'>		 
<%@ include file="../top2.jsp" %>
</head>
<body>
	<section class="contents">
		<form method="post" name="cfrm" action="cartProc.jsp">
			<input type="hidden" name="cch" value="0">
			<h3 class="heading">�� ��ٱ���</h3>
			<table id="carttb">
				<thead>
					<tr class="th">
						<th width="50"><input type="checkbox" name="allCh" onclick="javascript:allChk()"></th>
						<th width="100">NO</th>
						<th width="200">��ǰ�̹���</th>
						<th width="200">��ǰ��</th>
						<th width="200">�ǸŰ�</th>
						<th width="100">����</th>
						<th width="200">�ݾ�</th>
					</tr>
				</thead>
				<tbody>
				<%
				Vector<CartBean> vlist = cMgr.getCartList(id);
				if(vlist.isEmpty()){
				%>
					<tr>
						<td colspan="6">��ٱ��Ͽ� �߰��� ��ǰ�� �����ϴ�.</td>
					</tr>
	
				<%
				}else{
					for(int i=0;i<vlist.size();i++){
						CartBean cart = vlist.get(i);
						int pnum = cart.getPnum();
						String image = ProductMgr.getPImage(pnum);
						int price = ProductMgr.getPrice(pnum);
						int quantity = cart.getQty();
						int total = price*quantity;
						allTotal += total;
						uAllTotal = UtilMgr.monFormat(allTotal);
						ProductBean pbean = pdMgr.getProduct(pnum);
				%>
						<tr style="border-bottom:2px solid #eee">
							<td><input type="checkbox" name="cch" value="<%=cart.getCnum()%>" onchange="chk(this, this.form, '<%=id%>', <%=total%>)"></td>
							<td><%=i+1%></td>
							<td> 
							<a href="../product/productDetail.jsp?pnum=<%=cart.getPnum()%>">
							<img src="../image/<%=image%>" height="80" width="80">
							</a>
							</td>
							<%if(pbean.getStock()==0){%>
								<td><a href="../product/productDetail.jsp?pnum=<%=cart.getPnum()%>"><%=cart.getPname()%>&nbsp;[ǰ��]</a></td>
								<%}else if(pbean.getStock()<quantity){%>
								<td><a href="../product/productDetail.jsp?pnum=<%=cart.getPnum()%>"><%=cart.getPname()%>&nbsp;[������]</a></td>
								<%}else{%>
								<td><a href="../product/productDetail.jsp?pnum=<%=cart.getPnum()%>"><%=cart.getPname()%></a></td>
							<%}%>
							<td><%=UtilMgr.monFormat(price)%>��</td>
							<td><%=quantity%></td>
							<td><%=UtilMgr.monFormat(total)%>��</td>
						</tr>
				<%
					} // -- for�� ��
				}//-- if-else�� ��
				%>
				</tbody>
			</table>
			<div class="total">
				<label class="lb1">��ٱ����� �� �ݾ��� <input type="text" name= "cartAllpriceTxt" class="cartAllpriceTxt" value="<%=uAllTotal%>" disabled>�� �Դϴ�.</label>
				<label class="lb2">������ ��ǰ�� �� �ݾ��� <input type="text" name="checkedPriceTxt" class="checkedPriceTxt" value="<%=checkedTotalPrice%>" disabled>�� �Դϴ�.</label>
			</div>
			<div class="button">
				<input type="button" class="cartbtn" value="����" onclick="javascript:cartDelete(this.form)">
				<input type="button" class="cartbtn" value="�ֹ��ϱ�" onclick="javascript:cartOrder(this.form)">
				<input type="hidden" name="flag" value="order">
			</div>
		</form>
		<br><br><br>
	</section>
<script>
function chk(ccb, form, oid, total) {
	var totalPrice = parseInt(form.checkedPriceTxt.value);
	if(ccb.checked == true){
		totalPrice += total;
	}
	if(ccb.checked == false){
		totalPrice -= total;
	}
	form.checkedPriceTxt.value = totalPrice;
}
</script>
</body>				
</html>