
<!-- �ٷ��ֹ����� ���������� -->
<%@page import="saymeow.UtilMgr"%>
<%@page import="saymeow.OrderBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<jsp:useBean id="oMgr" class="saymeow.OrderMgr" />
<%
int onum = UtilMgr.parseInt(request, "onum");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�����ϱ�</title>
<!-- ��Ʈ��Ʈ�� CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<%@ include file="../top2.jsp"%>
    <link rel='stylesheet' type='text/css' media='screen' href='../css/directOrder.css'>
</head>
<body style="background-color: #eee;">
	<div class="title">
		<h2 style="margin:5vh auto;">����</h2>
	</div>
	<section class="contents">
		<form name="paymentFrm" action="directOrderPaymentProc.jsp" method="post" style="border:1px solid #a0a0a0; width:50vw; height: 70vh; margin: 0 auto;">
			<h5 style="margin:3vh;">[����� �Է�]</h5><br>
			<input type="checkbox" name="loadAddressBtn" onchange="loadAddress()" style="transform:translateX(-7vw)">
			<label style="transform:translateX(-7vw); margin-bottom:2vh;">�ֱ� ����� ��������</label><br>
			<input name="oaddress" size="100px" style="width:25vw; background-color:#eee; border:1px solid #a0a0a0; height:5vh; margin-bottom:3vh;">
			<h5>[�ֹ�����]</h5><br>
			<table>
					<%
					OrderBean oBean = oMgr.getOrderDetail(onum);// �ֹ����� ��������
					
					int price1 = oBean.getPrice1();
					int qty = oBean.getQty();
					String uPrice1 = UtilMgr.monFormat(price1);
					String total = UtilMgr.monFormat(price1*qty);
					%>
					<thead style="background-color: #9598ca">
						<tr style="height:5vh;">
							<th width="200">��ǰ��</th>
							<th width="200">����</th>
							<th width="200">�� ������ �ݾ�</th>
						</tr>
					</thead>
					<tr style="background-color: white; height:7vh;">
						<td><%=oBean.getPname()%></td>
						<td><%=oBean.getQty()%>��</td>
						<td><%=total%>��</td>
					</tr>
					<tr>
						<td><br><br></td>
					</tr>
					<tr>
						<td colspan="3">
							<input type="hidden" name="onum" value="<%=oBean.getOnum()%>"> 
							<input type="hidden" name="state" value="<%=oBean.getState()%>">
						
							<label style="font-size:1.2em;">�� �����ݾ��� </label> 
							<label style="font-size:1.8em;"><b><%=total%></b></label>
							<label style="font-size:1.2em;">�� �Դϴ�.</label><br>
							
							<div style="margin:3vh;">
								<input type="button" value="���" onclick="history.back()" style="color: #eee; border:1px solid #9598ca; width:7vw; font-size:1.4em; height:5vh; background-color: #9598ca;">
								<input type="submit" value="����" style="color: #eee; border:1px solid #9598ca; width:7vw; font-size:1.4em; height:5vh; background-color: #9598ca;">
							</div>
						</td>
					</tr>
				</table>
			</form><br><br>
		</section>
<script>
	function loadAddress(){
		f = document.paymentFrm;
		var oaddress = '<%=oMgr.getNewestAddress(id)%>';
		
		if(oaddress!=null && oaddress!='null'){ // �ֹ����� �ִٸ�
			if(f.loadAddressBtn.checked){ // üũ�Ѵٸ�
				f.oaddress.value = '<%=oMgr.getNewestAddress(id)%>';
			} else { // üũ �����Ѵٸ�
				f.oaddress.value = '';
			}
			
		} else { // �ֹ����� ���ٸ�
			alert('���� �ֱ� �ֹ������� �����ϴ�!');
			f.loadAddressBtn.checked = false; // üũ������Ŵ
		}
		
	}
</script>
</body>
</html>