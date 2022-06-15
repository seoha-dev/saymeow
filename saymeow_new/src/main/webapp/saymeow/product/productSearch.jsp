<!-- 취합완료 -->
<%@page import="saymeow.UtilMgr"%>
<%@page import="saymeow.ProductBean"%>
<%@page import="java.util.Vector"%>
<%@page import="saymeow.ProductMgr"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>productSearch</title>
<meta name='viewport' content='width=device-width, initial-scale=1'>
<link rel='stylesheet' type='text/css' media='screen'href='../css/plist.css'>
<link rel="stylesheet" href="../css/styleHB.css">

<!-- 부트스트랩 CSS -->
	<link
		href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
		rel="stylesheet"
		integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
		crossorigin="anonymous">  
		<%@ include file="../top2.jsp"%>
</head>
<script>
function send_form(frmId) { // form 제출
	document.getElementById(frmId).submit();
}


function sel(){ 
	var langSelect = document.getElementById("sort"); 
	// select element에서 선택된 option의 value가 저장된다. 
	var selectValue = langSelect.options[langSelect.selectedIndex].value; 
	// select element에서 선택된 option의 text가 저장된다. 
	var selectText = langSelect.options[langSelect.selectedIndex].text; 
}

</script>
<body>
<%
// 값 받아오기
String mClass = null;
String sClass = null;
pKeyWord = null;

mClass = request.getParameter("mClass");
sClass = request.getParameter("sClass");
pKeyWord = request.getParameter("pKeyWord"); // 검색할 상품이름

ProductMgr mgr = new ProductMgr();
Vector<ProductBean> pvlist = mgr.getPList(pKeyWord);
	
%>
	<div id="container">
		<!-- 카테고리(sidebar) -->
		<section class="category">
			<h5>카테고리</h5><br><br>
			<ul>
				<li><a href="#" onclick="return send_form('frmFo')">고양이 사료</a>
					<form method="post" id="frmFo" action="productProc.jsp">
						<input type=hidden name="mClass" value="food">
					</form>
					<ol>
						<li><a href="#" onclick="return send_form('frmDr')">건식사료</a>
							<form method="post" id="frmDr" action="productProc.jsp">
								<input type=hidden name="mClass" value="food"> <input
									type=hidden name="sClass" value="dry">
							</form></li>
						<li><a href="#" onclick="return send_form('frmWe')">습식사료</a>
							<form method="post" id="frmWe" action="productProc.jsp">
								<input type=hidden name="mClass" value="food"> <input
									type=hidden name="sClass" value="wet">
							</form></li>
					</ol></li>
				<li><a href="#" onclick="return send_form('frmTr')">고양이 간식</a>
					<form method="post" id="frmTr" action="productProc.jsp">
						<input type=hidden name="mClass" value="treat">
					</form>
					<ol>
						<li><a href="#" onclick="return send_form('frmSn')">스낵</a>
							<form method="post" id="frmSn" action="productProc.jsp">
								<input type=hidden name="mClass" value="treat"> <input
									type=hidden name="sClass" value="snack">
							</form></li>
						<li><a href="#" onclick="return send_form('frmSt')">스틱</a>
							<form method="post" id="frmSt" action="productProc.jsp">
								<input type=hidden name="mClass" value="treat"> <input
									type=hidden name="sClass" value="stick">
							</form></li>
					</ol></li>
				<li><a href="#" onclick="return send_form('frmTo')">고양이 장난감</a>
					<form method="post" id="frmTo" action="productProc.jsp">
						<input type=hidden name="mClass" value="toy">
					</form>
					<ol>
						<li><a href="#" onclick="return send_form('frmPo')">막대/낚싯대</a>
							<form method="post" id="frmPo" action="productProc.jsp">
								<input type=hidden name="mClass" value="toy"> <input
									type=hidden name="sClass" value="pole">
							</form></li>
						<li><a href="#" onclick="return send_form('frmPl')">인형</a>
							<form method="post" id="frmPl" action="productProc.jsp">
								<input type=hidden name="mClass" value="toy"> <input
									type=hidden name="sClass" value="plush">
							</form></li>
					</ol></li>
				<li><a href="#" onclick="return send_form('frmLi')">고양이
						배변용품</a>
					<form method="post" id="frmLi" action="productProc.jsp">
						<input type=hidden name="mClass" value="litter">
					</form>
					<ol>
						<li><a href="#" onclick="return send_form('frmSa')">모래</a>
							<form method="post" id="frmSa" action="productProc.jsp">
								<input type=hidden name="mClass" value="litter"> <input
									type=hidden name="sClass" value="sand">
							</form></li>
						<li><a href="#" onclick="return send_form('frmBo')">화장실</a>
							<form method="post" id="frmBo" action="productProc.jsp">
								<input type=hidden name="mClass" value="litter"> <input
									type=hidden name="sClass" value="box">
							</form></li>
					</ol></li>
			</ul>
		</section>
		<section class="plist">
			<div class="ptop">
				<p>검색어: <b><%=pKeyWord%></b>
				<div class="array">
				<p><b><%=pvlist.size()%></b>개의 상품이 있습니다. 
				</div>
				
			</div>
			<div class="product_list" id="product_list">
				<ul class="product_row">
					<%
							for (int i=0; i<pvlist.size(); i++) {
								ProductBean pbean = pvlist.get(i);
					%>
					<li>
					<a href="productDetail.jsp?pnum=<%=pbean.getPnum()%>">
					<img src="../image/<%=pbean.getImage()%>" height="180" width="180">
					<br><%=pbean.getPname()%></a>
					<br><%=UtilMgr.monFormat(pbean.getPrice1())%>원<br>
					</li>
					<%} //--for%>
				</ul>	
			</div>
		</section>
	</div>
</body>
</html>