<!-- �� �������� ��δ� cartList.jsp -> cartProc.jsp ������ư Ŭ�� -> orderProc.jsp �Դϴ�.
�ֹ��� ���������� �ȴٸ� state�� ����Ʈ 2�� petOrder���̺� insert �˴ϴ�. 
-->
<!-- �ֹ����� ó�������� -->
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

	String msg = "������ �Ϸ�Ǿ����ϴ�.";
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
			} // -- for�� ��
		} // -- �߰� if�� ��
	} else if(flag.equals("cart")){ // ��ٱ��Ͽ��� �ֹ��ϸ� -> order���̺� �ٷ� state=2(�����Ϸ�)�� insert�Ǵ°ų� ��������
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
				oMgr.insertOrderFromCart(order); // ������Ʈ�ιٲٱ�
				
				OrderBean oBean = oMgr.getDirectOrderList(oid);
				int onum = oBean.getOnum();
				// System.out.println("[orderProc flag=cart] onum:"+onum);
				pMgr.stockMinus(onum); // ���ż�����ŭ ��������
				cMgr.deleteCart(Integer.parseInt(snum[i]));// ��ٱ��Ͽ��� ����
				
			} // -- for�� ��
		} // -- �߰� if�� ��
	} else { // ��� ���°���?
		int onum = UtilMgr.parseInt(request, "onum"); //onum �޾ƿ��� 
		oMgr.updateOrder(onum); // �����Ϸ������� ���� 2�� �ٲٱ�
		pMgr.stockMinus(onum);
	 } // -- ���� if�� ��
%>
<script>
	alert("<%=msg%>");
	location.href = "<%=url%>";
</script>