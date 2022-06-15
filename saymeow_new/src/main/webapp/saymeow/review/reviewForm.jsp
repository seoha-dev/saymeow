<%@page import="saymeow.UtilMgr"%>
<%@page import="java.util.Vector"%>
<%@page import="saymeow.ReviewBean"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="rMgr" class="saymeow.ReviewMgr"/>
<!DOCTYPE html>
<html>
<head>
<title>SayMeow</title>
<!-- 혜빈 CSS -->
<link rel="stylesheet" href="../css/styleHB.css">
<!-- 혜빈 JS -->
<script src="../scriptHB.js"></script>
<!-- 부트스트랩 CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<%@ include file="../top2.jsp" %>
<%
	int onum = Integer.parseInt(request.getParameter("onum"));
	int pnum = Integer.parseInt(request.getParameter("pnum")); 
	String flag = request.getParameter("flag"); // value = flagForReview
	// 마이페이지의 주문내역조회에 리뷰쓰기 버튼 활성화시키고, 세션에 저장된 id값으로 리뷰 작성자 id 받아오기
	String rid = id;
%>
</head>
<body>
	<div id="review-board-container" style="text-align:center;">
		<div class="review-section">
			<h3 class="title">상품구매리뷰</h3>
			<!-- 리뷰 작성 폼 -->
			<!-- GET방식과 multipart 같이 사용 -->
			<form class="review-form" action="reviewFormProc.jsp?pnum=<%=pnum%>" method="post" 
			enctype="multipart/form-data"> <!-- 파일업로드 할 수도 있으므로 post로 보내기 -->
				<div class="mb-3">
  					<label for="exampleFormControlInput1" class="form-label">제목</label>
  					<input class="form-control" id="exampleFormControlInput1" name="subject" placeholder="제목을 입력하세요.">
				</div>
				<div class="mb-3">
  					<label for="exampleFormControlTextarea1" class="form-label">내용</label>
  					<textarea class="form-control review-content" id="exampleFormControlTextarea1" name="content" maxlength="500"></textarea>
				</div>
				<div class="mb-3">
 					<input type="file" class="form-control" id="formFile" name="filename">
				</div>
				<span class="star">
  					★★★★★ <!-- 빈 별 -->
  					<span>★★★★★</span> <!-- 배경색 있는 별 -->
  					<!-- DB insert할때는 /2 해서 insert -->
  					<input type="range" oninput="star(this)" value="0" step="1" min="0" max="10" name="score"> <!-- 오픈소스 참고 -->
				</span>
				<input type="hidden" name="onum" value="<%=onum%>"> 
				<input type="hidden" name="rid" value="<%=rid%>">
				<input type="hidden" name="pnum" value="<%=pnum%>">
				
				<div class="d-grid gap-2 d-md-block">
  					<input type="submit" class="btn btn-primary submitBtn" type="submit" value="글쓰기">
				</div>
			</form>
		</div>
	</div>

<!-- 부트스트랩 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" 
        integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
        crossorigin="anonymous">
</script>

</body>
</html>