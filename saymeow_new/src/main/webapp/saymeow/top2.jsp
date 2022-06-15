<!-- ���տϷ� -->
<%@page contentType="text/html; charset=EUC-KR"%>
<%
	//�ѱ۱��� ����
	request.setCharacterEncoding("EUC-KR"); 
	
	// id�� �޾ƿ��� 
	String id = request.getParameter("id");
	if(session.getAttribute("idKey")!=null){
			id = (String) session.getAttribute("idKey");
	} 
	
	// top2.jsp ��� �˻��� �޾ƿ���
	String pKeyWord = null; // ����Ʈ
	pKeyWord = request.getParameter("pKeyWord");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset='EUC-KR'>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <link rel='stylesheet' type='text/css' media='screen' href='/saymeow_new/saymeow/css/top2.css'>
<script>
	 function btn(btnId) { // ��ưȰ��/��Ȱ��ȭ
	var btn = document.getElementById(btnId);
	if (btn.style.display == "none" ) {
		btn.style.display = "flex";
	}else {
		btn.style.display = "none";
	}
}  
</script>
</head>
	<body>
		<!-- �ΰ� / �˻�â / �α��� ��ư -->
		<section class = "ssection">
			<div>
    			<a href="/saymeow_new/saymeow/index.jsp"><img class="logo" src="/saymeow_new/saymeow/image/saymeow_logo_dark.png"></a>
    		</div>
    		<!-- �˻�â -->
    		<div class="search d-flex">
    			<form method="post" action="/saymeow_new/saymeow/product/productSearch.jsp">
					<input class="sTf form-control me-2" name="pKeyWord" type="search" placeholder="���ϴ� ��ǰ�� �ִٸ� �˻��غ�����!" aria-label="Search">
					<button class="searchBtn btn btn-primary" type="submit" style="cursor: grab;">Search</button>
				</form>
			</div>
			<!-- �α��� -->
			<div class="btns">
				<a href="/saymeow_new/saymeow/member/login.jsp"><input id="login" type="button" value="�α���" style="cursor: grab;" class="btn btn-primary"></a>&nbsp;
				<a href="/saymeow_new/saymeow/member/logout.jsp"><input id="logout" type="button" value="�α׾ƿ�" style="cursor: grab;" class="btn btn-primary"></a>&nbsp;
				<a href="/saymeow_new/saymeow/member/member2.jsp"><input id="join" type="button" value="ȸ������" style="cursor: grab;" class="btn btn-primary"></a>&nbsp;
				<a href="/saymeow_new/saymeow/member/myPageMain.jsp"><input id="my" type="button" value="����������" style="cursor: grab;" class="btn btn-primary"></a>&nbsp;
				<a href="/saymeow_new/saymeow/admin/adminMain.jsp"><input id="admin" type="button" value="�����ڸ޴�" style="cursor: grab;" class="btn btn-primary"></a>&nbsp;
				<a href="/saymeow_new/saymeow/cartList.jsp"><input id="cart" type="button" value="��ٱ���" style="cursor: grab;" class="btn btn-primary"></a>&nbsp;
			</div>
		
			<% if(id==null || id.equals("null")) { %>
			<script>
				btn('logout');
				btn('my');
				btn('cart');
				btn('admin');
			</script>
			<%}else if(id.equals("admin")) { %>
			<script>
				btn('login');
				btn('join');
				btn('my');
				btn('cart');
			</script>
			<%}else { %>
			<script>
				btn('login');
				btn('join');
				btn('admin');
			</script>	
			<%} %>
		</section>
		<!-- ī�װ� -->
		<section class="csection">&nbsp; &nbsp; 
			<a href="/saymeow_new/saymeow/product/food.jsp">����� ���</a>&nbsp; 
			<a href="/saymeow_new/saymeow/product/treat.jsp">����� ����</a>&nbsp;
			<a href="/saymeow_new/saymeow/product/toy.jsp">����� �峭��</a>&nbsp; 
			<a href="/saymeow_new/saymeow/product/litter.jsp">����� �躯��ǰ</a>&nbsp; 
		</section>
    </body>
</html>