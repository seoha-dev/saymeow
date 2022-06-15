<!-- 취합완료했으나, 일부 상품 텍스트컬러 검정색으로 뜹니다. -->

<!-- 장난감 카테고리 (메인에서 눌러서 들어옴) -->
<%@page import="saymeow.UtilMgr"%>
<%@page import="saymeow.ProductBean"%>
<%@page import="java.util.Vector"%>
<%@page import="saymeow.ProductMgr"%>
<%@page contentType="text/html; charset=EUC-KR"%>

<%
ProductMgr mgr = new ProductMgr();

String mClass = request.getParameter("mClass");
String sClass = request.getParameter("sClass");
String sort = request.getParameter("sort");

if (sort==null||sort.equals("")) sort="0";
if(mClass==null) mClass="toy";

// System.out.println("[catfood] mClass:"+ mClass + " /sClass:"+sClass + " /sort:" + sort);
Vector<ProductBean> pvlist = mgr.getP2(mClass, sClass, sort); 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>toy</title>
<meta name='viewport' content='width=device-width, initial-scale=1'>
<link rel='stylesheet' type='text/css' media='screen'href='../css/plist.css'>
    <!-- 부트스트랩 CSS -->
	<link
		href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
		rel="stylesheet"
		integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
		crossorigin="anonymous">    
<%@ include file="../top2.jsp" %>
</head>
<script>
function send_form(frmId) { // form 제출
	document.getElementById(frmId).submit();
}
</script>
<body>
	<div id="container">
	<!-- 카테고리(sidebar) -->
		<section class="category">
		<h5>카테고리</h5><br><br>
		<ul>
			<li>
			<a href="#" onclick="return send_form('frmFo')">고양이 사료</a>
			<form method="post" id="frmFo" action="productProc.jsp">
				<input type=hidden name="mClass" value="food">
			</form>
				<ol>
					<li>
					<a href="#" onclick="return send_form('frmDr')">건식사료</a>
						<form method="post" id="frmDr" action="productProc.jsp">
							<input type=hidden name="mClass" value="food"> 
							<input type=hidden name="sClass" value="dry">
						</form>
					</li>
					<li>
						<a href="#" onclick="return send_form('frmWe')">습식사료</a>
						<form method="post" id="frmWe" action="productProc.jsp">
							<input type=hidden name="mClass" value="food">
							<input type=hidden name="sClass" value="wet">
						</form>
					</li>
				</ol>
			</li>
			<li>
			<a href="#" onclick="return send_form('frmTr')">고양이 간식</a>
			<form method="post" id="frmTr" action="productProc.jsp">
				<input type=hidden name="mClass" value="treat">
			</form>
				<ol>
					<li>
					<a href="#" onclick="return send_form('frmSn')">스낵</a>
					<form method="post" id="frmSn" action="productProc.jsp">
						<input type=hidden name="mClass" value="treat">
						<input type=hidden name="sClass" value="snack">
					</form>
					</li>
					<li>
					<a href="#" onclick="return send_form('frmSt')">스틱</a>
					<form method="post" id="frmSt" action="productProc.jsp">
						<input type=hidden name="mClass" value="treat">
						<input type=hidden name="sClass" value="stick">
					</form>
					</li>
				</ol>
			</li>
			<li>
			<a href="#" onclick="return send_form('frmTo')">고양이 장난감</a>
			<form method="post" id="frmTo" action="productProc.jsp">
				<input type=hidden name="mClass" value="toy">
			</form>
				<ol>
					<li>
					<a href="#" onclick="return send_form('frmPo')">막대/낚싯대</a>
					<form method="post" id="frmPo" action="productProc.jsp">
						<input type=hidden name="mClass" value="toy">
						<input type=hidden name="sClass" value="pole">
					</form>
					</li>
					<li>
					<a href="#" onclick="return send_form('frmPl')">인형</a>
					<form method="post" id="frmPl" action="productProc.jsp">
						<input type=hidden name="mClass" value="toy">
						<input type=hidden name="sClass" value="plush">
					</form>
					</li>
				</ol>
			</li>
			<li>
			<a href="#" onclick="return send_form('frmLi')">고양이 배변용품</a>
			<form method="post" id="frmLi" action="productProc.jsp">
				<input type=hidden name="mClass" value="litter">
			</form>
				<ol>
					<li>
					<a href="#" onclick="return send_form('frmSa')">모래</a>
						<form method="post" id="frmSa" action="productProc.jsp">
							<input type=hidden name="mClass" value="litter">
							<input type=hidden name="sClass" value="sand">
						</form>
					</li>
					<li>
					<a href="#" onclick="return send_form('frmBo')">화장실</a>
					<form method="post" id="frmBo" action="productProc.jsp">
						<input type=hidden name="mClass" value="litter">
						<input type=hidden name="sClass" value="box">
					</form>
					</li>
				</ol>
			</li>
		</ul>
		</section>
		<!-- 상품 섹션 -->		
		<section class="plist">
			<div class="ptop">
				<p>현재 카테고리: <b>고양이 장난감</b>
					<div class="array">
					<p><b><%=pvlist.size()%></b>개의 상품이 있습니다.
					<form action="productProc.jsp">
					<b>정렬방식</b>
						<select name="sort" onchange="this.form.submit()">
							<option value="0" <%=sort.equals("0")?"selected":""%>>최신순</option>
							<option value="1" <%=sort.equals("1")?"selected":""%>>높은가격순</option> 
 							<option value="2" <%=sort.equals("2")?"selected":""%>>낮은가격순</option> 
 							<option value="3" <%=sort.equals("3")?"selected":""%>>리뷰많은순</option> 
 							<option value="4" <%=sort.equals("4")?"selected":""%>>리뷰높은순</option> 
 							<option value="5" <%=sort.equals("5")?"selected":""%>>판매량순</option>
						</select> 
						<input type=hidden name="mClass" value="<%=mClass%>">
						<input type=hidden name="sClass" value="<%=sClass%>">
					
					</form>
					</div>
			</div>
			<div class="product_list" id="product_list">
				<ul class="product_row">
					<% for (int i=0; i<pvlist.size(); i++) {
						ProductBean pbean = pvlist.get(i); %>
						<li>
							<a href="productDetail.jsp?pnum=<%=pbean.getPnum()%>">
							<br><img src="../image/<%=pbean.getImage()%>" height="180" width="180">
							<br><%=pbean.getPname()%></a>
							<br><b><%=UtilMgr.monFormat(pbean.getPrice1())%>원</b><br>
						</li>
					<%} //--for%>
				</ul>
			</div>
		</section>
	</div>
</body>
</html>
