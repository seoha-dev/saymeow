<!-- 이 페이지의 경로는 cartList.jsp -> cartProc.jsp 결제버튼 클릭 -> orderProc.jsp 입니다.
주문이 성공적으로 된다면 state가 디폴트 2로 petOrder테이블에 insert 됩니다. 
-->
<!-- 주문과정 처리페이지 -->
<%@page import="saymeow.UtilMgr"%>
<%@page import="saymeow.CartBean"%>
<%@page import="saymeow.OrderBean"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="cMgr" class="saymeow.CartMgr"/>
<jsp:useBean id="oMgr" class="saymeow.OrderMgr"/>
<jsp:useBean id="pMgr" class="saymeow.ProductMgr"/>
<%
	String oid = (String)session.getAttribute("idKey");
	String flag = request.getParameter("flag");

	String msg = "결제가 완료되었습니다.";
	String url = "cartList.jsp";
	
	String address = request.getParameter("address");
	
	if(flag.equals("order")){
		String snum[] = null;
		snum = request.getParameterValues("cch");
		OrderBean order = new OrderBean();
		CartBean cart = new CartBean();
		
		if(snum.length>0){
			for(int i=0;i<snum.length;i++){
				cart = cMgr.checkCart(Integer.parseInt(snum[i]));
				order.setOaddress(address);
				order.setPnum(cart.getPnum());
				order.setPrice1(cart.getPrice1());
				order.setQty(cart.getQty());
				order.setPname(cart.getPname());
				order.setOid(cart.getOid());
				oMgr.insertOrder(order); 
			} // -- for문 끝
		} // -- 중간 if문 끝
	} else if(flag.equals("cart")){ // 장바구니에서 주문하면 -> order테이블에 바로 state=2(결제완료)로 insert되는거나 마찬가지
		String snum[] = null;
		snum = request.getParameterValues("cch");
		OrderBean order = new OrderBean();
		CartBean cart = new CartBean();		
		
		if(snum.length>0){
			for(int i=0;i<snum.length;i++){
				cart = cMgr.checkCart(Integer.parseInt(snum[i]));
				order.setOaddress(address);
				order.setPnum(cart.getPnum());
				order.setPrice1(cart.getPrice1());
				order.setQty(cart.getQty());
				order.setPname(cart.getPname());
				order.setOid(cart.getOid());
				oMgr.insertOrderFromCart(order); // 업데이트로바꾸기
				
				OrderBean oBean = oMgr.getDirectOrderList(oid);
				int onum = oBean.getOnum();
				// System.out.println("[orderProc flag=cart] onum:"+onum);
				pMgr.stockMinus(onum); // 구매수량만큼 재고빠지기
				cMgr.deleteCart(Integer.parseInt(snum[i]));// 장바구니에서 삭제
				
			} // -- for문 끝
		} // -- 중간 if문 끝
	} else { // 어디서 오는거임?
		int onum = UtilMgr.parseInt(request, "onum"); //onum 받아오기 
		oMgr.updateOrder(onum); // 결제완료했으니 상태 2로 바꾸기
		pMgr.stockMinus(onum);
	 } // -- 최종 if문 끝
%>
<script>
	alert("<%=msg%>");
	location.href = "<%=url%>";
</script>