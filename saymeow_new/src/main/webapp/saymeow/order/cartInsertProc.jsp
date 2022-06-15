<%@page import="saymeow.ProductMgr"%>
<%@page import="saymeow.UtilMgr"%>
<%@page import="saymeow.CartBean"%>
<%@page import="java.util.Vector"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="cMgr" class="saymeow.CartMgr"/>
<jsp:useBean id="cart" class="saymeow.CartBean"/>
<jsp:useBean id="oBean" class="saymeow.OrderBean"/>
<jsp:useBean id="oMgr" class="saymeow.OrderMgr"/>
<%	
	/*값 받아오기*/
	// 주문자 id <= 로그인한 id 받아오기
	String oid = null; 
	if(session.getAttribute("idKey")!=null){
		oid = (String)session.getAttribute("idKey");
	}
	
	// 주문 수량
	int qty = UtilMgr.parseInt(request, "qty");
	
	
	// 주문 상품 번호
	int pnum = UtilMgr.parseInt(request, "pnum");
	
	// 주문 상품명
	String pname = request.getParameter("pname");
	// System.out.println("pname : " + pname);
	
	// 주문 상품이미지
	String image = ProductMgr.getPImage(pnum);
	// System.out.println("[insert]image : " + image);
	
	// 개당 판매가
	int price1 = ProductMgr.getPrice(pnum);
	
	// flag값
	String flag = request.getParameter("flag");
	// System.out.println("flag : " + flag);
	
	
	if(flag.equals("insert") || flag=="insert"){ // 장바구니 추가눌렀다면
		cart.setOid(oid); // 아래 메소드 실행을 위해 받아온 주문자 id를 빈즈에 넣기
		cart.setPnum(pnum);
		cart.setPname(pname);
		cart.setPrice1(price1);
		cart.setQty(qty);
		cart.setImage(image);
		//System.out.println("oid : " + oid);
		
		
		Vector<CartBean> vlist = cMgr.getCartList(oid);
		
		/*장바구니에 존재하면 수정, 없으면 추가*/
		if(cMgr.searchCartList(oid, pnum)){ // 존재
			cMgr.updateCart(qty, pnum);// 장바구니 수정
			%>
			<script>
				alert("기존 제품이 장바구니에 있으므로 수량이 추가되었습니다.");
				location.href = "cartList.jsp";
			</script>
		<%}else{ // 미존재
			cMgr.insertCart(cart);// 장바구니 추가
			%>
			<script>
				alert("장바구니에 추가되었습니다.");
				location.href = "cartList.jsp";
			</script>
			<%
			}
		}else if(flag.equals("direct")|| flag=="direct"){ // 상품상세에서 바로 주문하기 눌렀다면
			// productDetail.jsp에서 cartInsertProc로 이동할 때 (=배송정보 적기 전)까지 받을 수 있는 모든 값 셋팅해두기
			oBean.setPnum(pnum);
			oBean.setQty(qty);
			oBean.setPrice1(price1);
			oBean.setPname(pname);
			oBean.setOid(oid);
			
			oMgr.insertDirectOrder(oBean); // state=1 결제전상태로 일단 주문내역에 담긴다. 
		%>
		<script>
			alert("주문목록에 추가되었습니다. 결제를 진행해주세요.");
			location.href = "direct.jsp";
		</script>
	<%}%>