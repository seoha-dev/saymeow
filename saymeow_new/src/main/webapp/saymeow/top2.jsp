<!-- 취합완료 -->
<%@page contentType="text/html; charset=EUC-KR"%>
<%
	//한글깨짐 방지
	request.setCharacterEncoding("EUC-KR"); 
	
	// id값 받아오기 
	String id = request.getParameter("id");
	if(session.getAttribute("idKey")!=null){
			id = (String) session.getAttribute("idKey");
	} 
	
	// top2.jsp 상단 검색어 받아오기
	String pKeyWord = null; // 디폴트
	pKeyWord = request.getParameter("pKeyWord");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset='EUC-KR'>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <link rel='stylesheet' type='text/css' media='screen' href='/saymeow_new/saymeow/css/top2.css'>
<script>
	 function btn(btnId) { // 버튼활성/비활성화
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
		<!-- 로고 / 검색창 / 로그인 버튼 -->
		<section class = "ssection">
			<div>
    			<a href="/saymeow_new/saymeow/index.jsp"><img class="logo" src="/saymeow_new/saymeow/image/saymeow_logo_dark.png"></a>
    		</div>
    		<!-- 검색창 -->
    		<div class="search d-flex">
    			<form method="post" action="/saymeow_new/saymeow/product/productSearch.jsp">
					<input class="sTf form-control me-2" name="pKeyWord" type="search" placeholder="원하는 상품이 있다면 검색해보세요!" aria-label="Search">
					<button class="searchBtn btn btn-primary" type="submit" style="cursor: grab;">Search</button>
				</form>
			</div>
			<!-- 로그인 -->
			<div class="btns">
				<a href="/saymeow_new/saymeow/member/login.jsp"><input id="login" type="button" value="로그인" style="cursor: grab;" class="btn btn-primary"></a>&nbsp;
				<a href="/saymeow_new/saymeow/member/logout.jsp"><input id="logout" type="button" value="로그아웃" style="cursor: grab;" class="btn btn-primary"></a>&nbsp;
				<a href="/saymeow_new/saymeow/member/member2.jsp"><input id="join" type="button" value="회원가입" style="cursor: grab;" class="btn btn-primary"></a>&nbsp;
				<a href="/saymeow_new/saymeow/member/myPageMain.jsp"><input id="my" type="button" value="마이페이지" style="cursor: grab;" class="btn btn-primary"></a>&nbsp;
				<a href="/saymeow_new/saymeow/admin/adminMain.jsp"><input id="admin" type="button" value="관리자메뉴" style="cursor: grab;" class="btn btn-primary"></a>&nbsp;
				<a href="/saymeow_new/saymeow/cartList.jsp"><input id="cart" type="button" value="장바구니" style="cursor: grab;" class="btn btn-primary"></a>&nbsp;
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
		<!-- 카테고리 -->
		<section class="csection">&nbsp; &nbsp; 
			<a href="/saymeow_new/saymeow/product/food.jsp">고양이 사료</a>&nbsp; 
			<a href="/saymeow_new/saymeow/product/treat.jsp">고양이 간식</a>&nbsp;
			<a href="/saymeow_new/saymeow/product/toy.jsp">고양이 장난감</a>&nbsp; 
			<a href="/saymeow_new/saymeow/product/litter.jsp">고양이 배변용품</a>&nbsp; 
		</section>
    </body>
</html>