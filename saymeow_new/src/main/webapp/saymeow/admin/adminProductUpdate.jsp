<%@page import="saymeow.UtilMgr"%>
<%@page import="saymeow.ProductBean"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="pMgr" class="saymeow.AdminProductMgr"/>
<%
	int pnum = Integer.parseInt(request.getParameter("pnum"));
	ProductBean pbean = pMgr.getProduct(pnum);	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>adminProductUpdate</title>
<link rel='stylesheet' type='text/css' media='screen' href='../css/adminProduct.css'>	
</head>
<body>
<section class="contents">
	<div class="plist">
		<h1>��ǰ����</h1><br>
		<form method="post" action="adminProductProc.jsp?flag=update" enctype="multipart/form-data">
<table border="1" class="table" style="border: 1px solid #eee; width: 600px">
<tr>
<td>��ǰ��ȣ</td>
<td><%=pbean.getPnum()%></td>
</tr>
<tr>
<td>��ǰ�̸�</td>
<td><input name="pname" value="<%=pbean.getPname()%>"></td>
</tr>
<tr>
<td>��ǰ��з�</td>
		<td>
		<select name="mclass" onchange="sel('mclass')" style="width:100px">
		<option value="<%=pbean.getMclass()%>">���簪:<%=pbean.getMclass()%></option>
		<option value="food">���(food)</option>
		<option value="treat">����(treat)</option>
		<option value="toy">�峭��(toy)</option>
		<option value="litter">�躯��ǰ(litter)</option>
		</select>
		</td>
</tr>
<tr>
<td>��ǰ�ߺз�</td>
		<td>
		<select name="sclass" onchange="sel('sclass')" style="width:100px">
		<option value="<%=pbean.getSclass()%>">���簪:<%=pbean.getSclass()%></option>
		<option value="dry">�ǽĻ��(dry)</option>
		<option value="wet">���Ļ��(wet)</option>
		<option value="snack">����(snack)</option>
		<option value="stick">��ƽ(stick)</option>
		<option value="pole">����/���˴�(pole)</option>
		<option value="plush">����(plush)</option>
		<option value="sand">��(sand)</option>
		<option value="box">ȭ���(box)</option>
		</select>
		</td>
</tr>
<tr>
<td>��ǰ����</td>
<td><input name="price1" value="<%=pbean.getPrice1()%>"></td>
</tr>
<tr>
<td>��ǰ����</td>
<td><input name="price2" value="<%=pbean.getPrice2()%>"></td>
</tr>
<tr>
<td>��ǰ����</td>
<td><input name="price3" value="<%=pbean.getPrice3()%>"></td>
</tr>
<tr>
<td>��ǰ�̹���</td>
<td><img src="../image/<%=pbean.getImage()%>"height="150" width="150"><br>
<input type="file" name="image"></td>
</tr>
<tr>
<td>��ǰ���̹���</td>
<td><img src="../image/<%=pbean.getDetail()%>" height="800"><br>
<input type="file" name="detail"></td>
</tr>
<tr>
<td>�ǸŻ���</td>
<td><input name="pstat" value="<%=pbean.getPstat()%>"></td>
</tr>
<tr>
<td>��ǰ���</td>
<td><input name="stock" value="<%=pbean.getStock()%>"></td>
</tr>
</table><br>
 <button type="submit" style="background-color:#eee;border:1px solid #eee;color:black; width: 80px; height: 40px;">��ǰ����</button><br><br>
 <input type=hidden name=pnum value="<%=pbean.getPnum()%>">
  	</form>
  	 </div>
</section>
</body>
</html>