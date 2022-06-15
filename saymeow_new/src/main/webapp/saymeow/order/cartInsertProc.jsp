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
	/*�� �޾ƿ���*/
	// �ֹ��� id <= �α����� id �޾ƿ���
	String oid = null; 
	if(session.getAttribute("idKey")!=null){
		oid = (String)session.getAttribute("idKey");
	}
	
	// �ֹ� ����
	int qty = UtilMgr.parseInt(request, "qty");
	
	
	// �ֹ� ��ǰ ��ȣ
	int pnum = UtilMgr.parseInt(request, "pnum");
	
	// �ֹ� ��ǰ��
	String pname = request.getParameter("pname");
	// System.out.println("pname : " + pname);
	
	// �ֹ� ��ǰ�̹���
	String image = ProductMgr.getPImage(pnum);
	// System.out.println("[insert]image : " + image);
	
	// ���� �ǸŰ�
	int price1 = ProductMgr.getPrice(pnum);
	
	// flag��
	String flag = request.getParameter("flag");
	// System.out.println("flag : " + flag);
	
	
	if(flag.equals("insert") || flag=="insert"){ // ��ٱ��� �߰������ٸ�
		cart.setOid(oid); // �Ʒ� �޼ҵ� ������ ���� �޾ƿ� �ֹ��� id�� ��� �ֱ�
		cart.setPnum(pnum);
		cart.setPname(pname);
		cart.setPrice1(price1);
		cart.setQty(qty);
		cart.setImage(image);
		//System.out.println("oid : " + oid);
		
		
		Vector<CartBean> vlist = cMgr.getCartList(oid);
		
		/*��ٱ��Ͽ� �����ϸ� ����, ������ �߰�*/
		if(cMgr.searchCartList(oid, pnum)){ // ����
			cMgr.updateCart(qty, pnum);// ��ٱ��� ����
			%>
			<script>
				alert("���� ��ǰ�� ��ٱ��Ͽ� �����Ƿ� ������ �߰��Ǿ����ϴ�.");
				location.href = "cartList.jsp";
			</script>
		<%}else{ // ������
			cMgr.insertCart(cart);// ��ٱ��� �߰�
			%>
			<script>
				alert("��ٱ��Ͽ� �߰��Ǿ����ϴ�.");
				location.href = "cartList.jsp";
			</script>
			<%
			}
		}else if(flag.equals("direct")|| flag=="direct"){ // ��ǰ�󼼿��� �ٷ� �ֹ��ϱ� �����ٸ�
			// productDetail.jsp���� cartInsertProc�� �̵��� �� (=������� ���� ��)���� ���� �� �ִ� ��� �� �����صα�
			oBean.setPnum(pnum);
			oBean.setQty(qty);
			oBean.setPrice1(price1);
			oBean.setPname(pname);
			oBean.setOid(oid);
			
			oMgr.insertDirectOrder(oBean); // state=1 ���������·� �ϴ� �ֹ������� ����. 
		%>
		<script>
			alert("�ֹ���Ͽ� �߰��Ǿ����ϴ�. ������ �������ּ���.");
			location.href = "direct.jsp";
		</script>
	<%}%>