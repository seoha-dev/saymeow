<%@page import="saymeow.UtilMgr"%>
<%@page import="java.util.Vector"%>
<%@page import="saymeow.ReviewBean"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="rMgr" class="saymeow.ReviewMgr"/>
<!DOCTYPE html>
<html>
<head>
<title>SayMeow</title>
<!-- ���� CSS -->
<link rel="stylesheet" href="../css/styleHB.css">
<!-- ���� JS -->
<script src="../scriptHB.js"></script>
<!-- ��Ʈ��Ʈ�� CSS -->
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
	// ������������ �ֹ�������ȸ�� ���侲�� ��ư Ȱ��ȭ��Ű��, ���ǿ� ����� id������ ���� �ۼ��� id �޾ƿ���
	String rid = id;
%>
</head>
<body>
	<div id="review-board-container" style="text-align:center;">
		<div class="review-section">
			<h3 class="title">��ǰ���Ÿ���</h3>
			<!-- ���� �ۼ� �� -->
			<!-- GET��İ� multipart ���� ��� -->
			<form class="review-form" action="reviewFormProc.jsp?pnum=<%=pnum%>" method="post" 
			enctype="multipart/form-data"> <!-- ���Ͼ��ε� �� ���� �����Ƿ� post�� ������ -->
				<div class="mb-3">
  					<label for="exampleFormControlInput1" class="form-label">����</label>
  					<input class="form-control" id="exampleFormControlInput1" name="subject" placeholder="������ �Է��ϼ���.">
				</div>
				<div class="mb-3">
  					<label for="exampleFormControlTextarea1" class="form-label">����</label>
  					<textarea class="form-control review-content" id="exampleFormControlTextarea1" name="content" maxlength="500"></textarea>
				</div>
				<div class="mb-3">
 					<input type="file" class="form-control" id="formFile" name="filename">
				</div>
				<span class="star">
  					�ڡڡڡڡ� <!-- �� �� -->
  					<span>�ڡڡڡڡ�</span> <!-- ���� �ִ� �� -->
  					<!-- DB insert�Ҷ��� /2 �ؼ� insert -->
  					<input type="range" oninput="star(this)" value="0" step="1" min="0" max="10" name="score"> <!-- ���¼ҽ� ���� -->
				</span>
				<input type="hidden" name="onum" value="<%=onum%>"> 
				<input type="hidden" name="rid" value="<%=rid%>">
				<input type="hidden" name="pnum" value="<%=pnum%>">
				
				<div class="d-grid gap-2 d-md-block">
  					<input type="submit" class="btn btn-primary submitBtn" type="submit" value="�۾���">
				</div>
			</form>
		</div>
	</div>

<!-- ��Ʈ��Ʈ�� JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" 
        integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
        crossorigin="anonymous">
</script>

</body>
</html>