<!-- 취합완료 -->
<%@page import="saymeow.UtilMgr"%>
<%@page import="saymeow.OrderBean"%>
<%@page import="saymeow.DirectOrderBean"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="cMgr" class="saymeow.CartMgr"/>
<jsp:useBean id="oMgr" class="saymeow.OrderMgr"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
    <title>direct</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <!-- 부트스트랩 CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">    
    <link rel='stylesheet' type='text/css' media='screen' href='../css/direct.css'>	
<%@ include file="../top2.jsp" %>
</head>
<body>
<%
	OrderBean oBean = oMgr.getDirectOrderList(id); // 현재 로그인한 id의 가장 최근 주문내역(바로주문내역) 1개 보여주기 위한 빈즈
	int pnum = oBean.getPnum();
	int price1 = oBean.getPrice1();
	int qty = oBean.getQty();
	String regDate = oBean.getRegdate();
	String pname = oBean.getPname();
	int onum = oBean.getOnum();
	String oid = oBean.getOid();
	String state = oBean.getState();
	String uPrice1 = UtilMgr.monFormat(price1);
	String total = UtilMgr.monFormat(price1*qty);
%>
	<section class="contents">
		<form method="post" name="doFrm" action="directOrderProc.jsp" style="border: 1px solid #a0a0a0; width:70vw; height:50vh; margin: 0 auto;">
		<div>
			<img src="../img/list.png" style="width:50px; height:50px; display:inline; margin-bottom: 8vh; margin-top: 5vh;">
			<h3 style=" display:inline; margin-bottom: 8vh; margin-top: 5vh;">상품 바로 주문</h3>
		</div>
		<table style="margin-top:3vh;">
			<tr style="height:5vh;">
				<th width="200">NO</th>
				<th width="300">상품명</th>
				<th width="200">판매가</th>
				<th width="200">수량</th>
				<th width="250">총 결제금액</th>
				<th width="300">주문날짜</th>
				<th width="250">주문상태</th>
				<th width="200">결제</th>
			</tr>
			<tr>
				<td><%=onum %></td>
				<td><%=pname%></td>
				<td><%=uPrice1%>원</td>
				<td><%=qty %>개</td>
				<td><%=total%>원</td>
				<td><%=regDate%></td>
	
				<%if(state.equals("1")){%>
					<td>결제 전</td>
					<td><input type="submit" value="결제하기" style="background-color: #eee; border:1px solid #eee; width:5vw; height:5vh;"></td>
				<%} else if(state.equals("2")){ %>
					<td>결제완료(배송완료)</td>
					<td>완료</td>
				<%}%>
	
			</tr>
		</table>
		<input type="hidden" name="pname" value="<%=pname%>">
		<input type="hidden" name="price1" value="<%=price1%>">
		<input type="hidden" name="qty" value="<%=qty%>">
		<input type="hidden" name="oid" value="<%=oid%>">
		<input type="hidden" name="pnum" value="<%=pnum%>">
		<input type="hidden" name="state" value="<%=state%>">
		<input type="hidden" name="onum" value="<%=onum%>">
		</form>
	</section>
</body>				
</html>