<%@page import="saymeow.UtilMgr"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="rMgr" class="saymeow.ReviewMgr"/>
<jsp:useBean id="rBean" class="saymeow.ReviewBean"/>
<jsp:setProperty property="*" name="rBean"/>
<%
	int rnum = UtilMgr.parseInt(request, "rnum");
	rBean = rMgr.getReview(rnum);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Review Update</title>
<!-- ���� CSS -->
<link rel="stylesheet" href="../css/styleHB.css">
<!-- ���� JS -->
<script src="../scriptHB.js"></script>
<script>
	function updateFile(){
		document.getElementsByClassName('fileInsertForm')[0].style.display = "block";
	}
</script>
<!-- ��Ʈ��Ʈ�� CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<%@ include file="../top2.jsp" %>
</head>
<body>
	<div id="review-board-container" style="text-align:center;">
		<div class="review-section">
			<h3 class="title">���� �����ϱ�</h3>
			<!-- ���� �ۼ� �� -->
			<!-- GET��İ� multipart ���� ��� -->
			<form class="review-form" action="reviewUpdateProc.jsp?rnum=<%=rnum%>" method="post" 
			enctype="multipart/form-data"> <!-- ���Ͼ��ε� �� ���� �����Ƿ� post�� ������ -->
				<div class="mb-3">
  					<label for="exampleFormControlInput1" class="form-label">����</label>
  					<input class="form-control" id="exampleFormControlInput1" name="subject" placeholder="������ �Է��ϼ���."
  					value="<%=rBean.getSubject()%>" style="width: 20vw; margin: 0 auto;">
				</div>
				<div class="mb-3">
  					<label for="exampleFormControlTextarea1" class="form-label">����</label>
  					<textarea class="form-control review-content" style="width: 20vw; margin: 0 auto;" id="exampleFormControlTextarea1" name="content" maxlength="500"><%=rBean.getContent() %></textarea>
				</div>
				
				<!-- ���� �������ϰų�, �����Ѵٸ� ���ǵ���-->
				<%if(rBean.getFilename()!=null && !rBean.getFilename().equals("")){// ���� ���� ���ε� �߾��ٸ� %>
				<div class="mb-3">
 					<label for="exampleFormControlTextarea1" class="form-label">��������</label><br>
					<input type="image" onclick="return false;" src="../storage/<%=rBean.getFilename()%>" width="400vw" height="200vw" style="display:block; margin: 0 auto; object-fit: cover; cursor:Default;" >
				</div>
				<%}%>
				
				<div>
					<label for="exampleFormControlTextarea1" class="form-label">��� ���Ϻ����� ���ϸ� �Ʒ� ��ư�� Ŭ���ϼ���. ���</label><br>
					<input type="button" class="btn btn-primary" value="change" onclick="updateFile()">
				</div>
				<div class="mb-3 fileInsertForm" style="display:none;">
 					<br><input type="file" class="form-control" id="formFile" name="filename" value="<%=rBean.getFilename()%>">
				</div>
				<div>
					<%out.println("���� ���� : " + rBean.getScore());%>
				</div>
				<span class="star">
  					�ڡڡڡڡ� <!-- �� �� -->
  					<span>�ڡڡڡڡ�</span> <!-- ���� �ִ� �� -->
  					<!-- DB insert�Ҷ��� /2 �ؼ� insert -->
  					<input type="range" oninput="star(this)" value="0" step="1" min="0" max="10" name="score"> <!-- ���¼ҽ� ���� -->
				</span>
				<input type="hidden" name="rnum" value="<%=rBean.getRnum()%>">
				<input type="hidden" name="onum" value="<%=rBean.getOnum()%>">
				<input type="hidden" name="rid" value="<%=rBean.getRid()%>">
				<input type="hidden" name="pnum" value="<%=rBean.getPnum()%>">
				<input type="hidden" name="date" value="<%=rBean.getDate()%>">
				<div class="d-grid gap-2 d-md-block">
  					<input type="submit" class="btn btn-primary submitBtn" value="�����ϱ�">
				</div>
			</form>
		</div>
	</div>
</body>
</html>