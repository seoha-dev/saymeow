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
		<h1>상품수정</h1><br>
		<form method="post" action="adminProductProc.jsp?flag=update" enctype="multipart/form-data">
<table border="1" class="table" style="border: 1px solid #eee; width: 600px">
<tr>
<td>상품번호</td>
<td><%=pbean.getPnum()%></td>
</tr>
<tr>
<td>상품이름</td>
<td><input name="pname" value="<%=pbean.getPname()%>"></td>
</tr>
<tr>
<td>상품대분류</td>
		<td>
		<select name="mclass" onchange="sel('mclass')" style="width:100px">
		<option value="<%=pbean.getMclass()%>">현재값:<%=pbean.getMclass()%></option>
		<option value="food">사료(food)</option>
		<option value="treat">간식(treat)</option>
		<option value="toy">장난감(toy)</option>
		<option value="litter">배변용품(litter)</option>
		</select>
		</td>
</tr>
<tr>
<td>상품중분류</td>
		<td>
		<select name="sclass" onchange="sel('sclass')" style="width:100px">
		<option value="<%=pbean.getSclass()%>">현재값:<%=pbean.getSclass()%></option>
		<option value="dry">건식사료(dry)</option>
		<option value="wet">습식사료(wet)</option>
		<option value="snack">스낵(snack)</option>
		<option value="stick">스틱(stick)</option>
		<option value="pole">막대/낚싯대(pole)</option>
		<option value="plush">인형(plush)</option>
		<option value="sand">모래(sand)</option>
		<option value="box">화장실(box)</option>
		</select>
		</td>
</tr>
<tr>
<td>상품가격</td>
<td><input name="price1" value="<%=pbean.getPrice1()%>"></td>
</tr>
<tr>
<td>상품원가</td>
<td><input name="price2" value="<%=pbean.getPrice2()%>"></td>
</tr>
<tr>
<td>상품마진</td>
<td><input name="price3" value="<%=pbean.getPrice3()%>"></td>
</tr>
<tr>
<td>상품이미지</td>
<td><img src="../image/<%=pbean.getImage()%>"height="150" width="150"><br>
<input type="file" name="image"></td>
</tr>
<tr>
<td>상품상세이미지</td>
<td><img src="../image/<%=pbean.getDetail()%>" height="800"><br>
<input type="file" name="detail"></td>
</tr>
<tr>
<td>판매상태</td>
<td><input name="pstat" value="<%=pbean.getPstat()%>"></td>
</tr>
<tr>
<td>상품재고</td>
<td><input name="stock" value="<%=pbean.getStock()%>"></td>
</tr>
</table><br>
 <button type="submit" style="background-color:#eee;border:1px solid #eee;color:black; width: 80px; height: 40px;">상품수정</button><br><br>
 <input type=hidden name=pnum value="<%=pbean.getPnum()%>">
  	</form>
  	 </div>
</section>
</body>
</html>