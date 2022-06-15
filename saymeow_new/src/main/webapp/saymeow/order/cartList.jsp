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
    
    int checkedTotalPrice = 0; // 장바구니에서 선택한 상품(체크박스 체크)의 총 결제금액
    String oid = null;
    int index = 0;
%>
<!DOCTYPE html>
<html>
<head>
<title>장바구니</title>
<script>
function cartDelete(form){
	form.flag.value="delete";
	form.submit();
}

function cartOrder(form){
	 var check = null;
	 for(i=0; i<form.cch.length; i++){
		if(form.cch[i].checked){
			check++; // 상품 체크박스 선택하면 check +1씩 증가
		}
	}
		
	if(check==null){ // 아무 체크박스도 선택 안했을 때
		alert('최소 1개 이상의 상품을 선택해주세요.');
	} else { // 최소 1개의 체크박스라도 선택했을 때 
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
	if(c.allCh.checked/*체크이벤트*/){
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
<!-- 부트스트랩 CSS -->
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
			<h3 class="heading">내 장바구니</h3>
			<table id="carttb">
				<thead>
					<tr class="th">
						<th width="50"><input type="checkbox" name="allCh" onclick="javascript:allChk()"></th>
						<th width="100">NO</th>
						<th width="200">상품이미지</th>
						<th width="200">상품명</th>
						<th width="200">판매가</th>
						<th width="100">수량</th>
						<th width="200">금액</th>
					</tr>
				</thead>
				<tbody>
				<%
				Vector<CartBean> vlist = cMgr.getCartList(id);
				if(vlist.isEmpty()){
				%>
					<tr>
						<td colspan="6">장바구니에 추가한 상품이 없습니다.</td>
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
								<td><a href="../product/productDetail.jsp?pnum=<%=cart.getPnum()%>"><%=cart.getPname()%>&nbsp;[품절]</a></td>
								<%}else if(pbean.getStock()<quantity){%>
								<td><a href="../product/productDetail.jsp?pnum=<%=cart.getPnum()%>"><%=cart.getPname()%>&nbsp;[재고부족]</a></td>
								<%}else{%>
								<td><a href="../product/productDetail.jsp?pnum=<%=cart.getPnum()%>"><%=cart.getPname()%></a></td>
							<%}%>
							<td><%=UtilMgr.monFormat(price)%>원</td>
							<td><%=quantity%></td>
							<td><%=UtilMgr.monFormat(total)%>원</td>
						</tr>
				<%
					} // -- for문 끝
				}//-- if-else문 끝
				%>
				</tbody>
			</table>
			<div class="total">
				<label class="lb1">장바구니의 총 금액은 <input type="text" name= "cartAllpriceTxt" class="cartAllpriceTxt" value="<%=uAllTotal%>" disabled>원 입니다.</label>
				<label class="lb2">선택한 상품의 총 금액은 <input type="text" name="checkedPriceTxt" class="checkedPriceTxt" value="<%=checkedTotalPrice%>" disabled>원 입니다.</label>
			</div>
			<div class="button">
				<input type="button" class="cartbtn" value="삭제" onclick="javascript:cartDelete(this.form)">
				<input type="button" class="cartbtn" value="주문하기" onclick="javascript:cartOrder(this.form)">
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