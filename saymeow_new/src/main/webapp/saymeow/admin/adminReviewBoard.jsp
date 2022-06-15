<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="saymeow.RCommentBean"%>
<%@page import="saymeow.ReviewBean"%>
<%@page import="java.util.Vector"%>
<%@page import="saymeow.UtilMgr"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- ����� ��� mgr ��ü���� -->
<jsp:useBean id="rMgr" class="saymeow.ReviewMgr" />
<jsp:useBean id="cMgr" class="saymeow.RCommentMgr" />
<jsp:useBean id="rcBean" class="saymeow.RCommentBean"/>

<% // ����¡ ó���� �ʿ��� ���� ����
int totalRecord = 0; // �� �Խù� �� (���� 0��)
int numPerPage = 10; // �� �������� �ҷ��� ���ڵ� ���� (����Ʈ 10��)
int pagePerBlock = 15; // �� ���� �� 15�� ������ �ҷ�����
int totalPage = 0; // �� ������ ���� (���� 0��)
int totalBlock = 0; // �� �� ����
int nowPage = 1; // ���� ������ (���� 1������)
int nowBlock = 1; // ���� �� (���� 1������ -> 1���� ��ġ)

if (request.getParameter("numPerPage") != null) { // x�������� �ɼ� �ٲٸ� ���ȣ��Ǹ鼭 �ٽ� numPerPage ����
	numPerPage = UtilMgr.parseInt(request, "numPerPage"); // ���޹��� numPerPage ���� int����ȯ
}

// �˻� �� and ������ �̵� �� ���ȣ��ǹǷ� �����Ǿ�����
String keyField = "", keyWord = ""; // �˻� �� ����Ʈ
if (request.getParameter("keyWord") != null) { // �˻��ߴٸ�
	keyField = request.getParameter("keyField");
	keyWord = request.getParameter("keyWord");
}

// �˻� �� 'ó������' ��ư �����߸� reload���� ���޵Ǹ鼭 �˻� �ʱ�ȭ�� ���·� ���ȣ��
if (request.getParameter("reload") != null && request.getParameter("reload").equals("true")) {
	keyField = "";
	keyWord = "";
}

// ���� ��ü ���� �� 
totalRecord = rMgr.getTotalCount(keyField, keyWord); // �˻��� ���� keyField, keyWord �� �����Ǿ� �ְ�, �ƴ� ���� "" �� ����

// ������ Ŭ��(list()�Լ�) OR �Խñ� �а� '����Ʈ��' Ŭ�� -> GET������� ��ġ���ִ� nowPage ����
if (request.getParameter("nowPage") != null) {
	nowPage = UtilMgr.parseInt(request, "nowPage");
}

// sql�� LIMIT�� ���� ���� ���� 
int start = (nowPage * numPerPage) - numPerPage; // 1�������϶� 0, 2�������϶� 10, 3�������϶� 20, ...
int cnt = numPerPage; // ����Ʈ 10�� (�� �������� �������� ���ڵ� ����)

// ��ü ������ ����
totalPage = (int) Math.ceil((double) totalRecord / numPerPage); // Ex. �Խù� 663�� -> ���ڵ尳��/10(66������) + 1(�ø� : �������������� 10���� ���� �� ������ �Խñ� ��(3��) ���� �ϹǷ�)

// ��ü �� ����
totalBlock = (int) Math.ceil((double) totalPage / pagePerBlock); // Ex. �� 67������ / �� ���� 15������ = 4.47 -> +1 (�ø�) �ؼ� 5��

// ���� ���° ������ 
nowBlock = (int) Math.ceil((double) nowPage / pagePerBlock); // Ex. ���� 1������ / �� ���� 15������

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>������ �������</title>
<script type="text/javascript">
// ����¡ ó��
function pageing(page) {
	document.readFrm.nowPage.value /*value ����������*/= page; // �Ű������� ���� page�� nowPage�� ������ ��û
	document.readFrm.submit();
}

// �� �̵�
function block(block) {
	document.readFrm.nowPage.value = <%=pagePerBlock%> * (block - 1) + 1;
	// block=1 -> nowPage=0, block=2 -> nowPage=16, ...
	document.readFrm.submit();
}

// �� �������� �Խñ� ����
function numPerFn(numPerPage) {
	document.readFrm.numPerPage.value = numPerPage;
	document.readFrm.submit(); // ���ȣ�� �� ����� numPerPage ����
}

// (ó������ ��ư �����߸� ����Ǵ� �޼ҵ�) ��� �̵�
function list() {
	document.listFrm.action = "adminReviewBoard.jsp";
	document.listFrm.submit(); // reload�� nowPage VALUE�� POST������� �����Ͽ� ���ȣ��
}

// �˻�
function check() {
	if (document.searchReviewFrm.keyWord.value == "") {
		alert("�˻�� �Է��ϼ���.");
		document.searchReviewFrm.keyWord.focus();
		return;
	}
	document.searchReviewFrm.submit(); // action �����Ƿ� ���ȣ��
}

// �Խñ� �б�
function read(i) { // ���
	if(document.getElementsByClassName('reviewDetail')[i].style.display == 'none'){
		document.getElementsByClassName('reviewDetail')[i].setAttribute("style","display:table-row"); // block ��� table-row�ؾ� colspan ����
	} else if(document.getElementsByClassName('reviewDetail')[i].style.display == 'table-row'){
		document.getElementsByClassName('reviewDetail')[i].style.display = 'none';
	}
}

// �˻�
	function search(){
		if (document.searchReviewFrm.keyWord.value == "") {
			alert("�˻�� �Է��ϼ���.");
			document.searchReviewFrm.keyWord.focus();
			return;
		}
		document.searchReviewFrm.submit();
	}

</script>
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
</head>
<body id="adminReviewBoard">
	<div class="d-flex align-items-start">
		<div class="nav flex-column nav-pills me-3" id="v-pills-tab" role="tablist" aria-orientation="vertical">
			<a href="adminOrder.jsp"><button class="nav-link" id="v-pills-home-tab" data-bs-toggle="pill" data-bs-target="#v-pills-home" type="button" role="tab" aria-controls="v-pills-home" aria-selected="true">�ֹ�����</button></a>
    		<a href="adminMember.jsp"><button class="nav-link" id="v-pills-profile-tab" data-bs-toggle="pill" data-bs-target="#v-pills-profile" type="button" role="tab" aria-controls="v-pills-profile" aria-selected="false">ȸ������</button></a>
    		<a href="adminReviewBoard.jsp"><button class="nav-link active" id="v-pills-messages-tab" data-bs-toggle="pill" data-bs-target="#v-pills-messages" type="button" role="tab" aria-controls="v-pills-messages" aria-selected="false">�������</button></a>
    		<a href="adminProduct.jsp"><button class="nav-link" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">��ǰ����</button></a>
    		<a href="sellHistory.jsp"><button class="nav-link" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">�������</button></a>
    		<a href="adminSales.jsp"><button class="nav-link" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">�Ǹŵ�����</button></a>
		</div>
    	<div align="center" class="review-contents">
			<h3 class="heading">�������</h3>
			<table>
				<tr>
					<td>
						<!-- action �����̹Ƿ� ���ȣ�� -->
						<form name="npFrm" method="post">
							<!-- select�±��� size�Ӽ� : �ѹ��� ���� �ɼ��� ����, onchange() : ������ �ٲ� ������ -->
							<select name="numPerPage" size="1" onchange="numPerFn(this.form.numPerPage.value)" class="form-select npFrm-td">
								<!-- 5,10,15,20 �� �ϳ� -->
								<option value="5">5���� ����</option>
								<option value="10" selected>10���� ����</option>
								<option value="15">15���� ����</option>
								<option value="30">30���� ����</option>
							</select>
						</form> 
						<script>
							<!-- if) '20�� ����' ���� ��, �Խñ� �а� ����Ʈ�� ���ƿ͵� ���� numPerPage ������ ���·� list.jsp ȣ���ϱ� ����-->
							document.npFrm.numPerPage.value = <%=numPerPage%>;
						</script>
					</td>
					<td width="600" align="right" class="npFrm-td">
						���������� : <%=nowPage%> / ��ü ������ : <%=totalPage%>
					</td>
				</tr>
			</table>
			<!-- �Խù� ����Ʈ Start -->
			<table>
				<tr>
					<td align="center" colspan="2">
						<%
						Vector<ReviewBean> vlist = rMgr.getReviewList(keyField, keyWord, start, cnt);
						int listSize = vlist.size(); // �� �������� ��� �� ���ڵ尹�� (�ִ� 10��, ������ �������� 10 ������ ���� ���� ���� ����)
						if (vlist.isEmpty()) {
							out.println("��ϵ� �Խù��� �����ϴ�.");
						} else {
						%>
							<table cellspacing="0" class="table">
								<tr align="center" class="table-column">
									<th width="100">�� ��</td>
									<th width="100">��ǰ��ȣ</td>
									<th width="100">�� ��</td>
									<th width="200">�� ��</td>
									<th width="100">���̵�</td>
									<th width="150">�� ¥</td>
									<th width="100">&nbsp;</td>
								</tr>
							<%
							/* for�� if���� ������ i==listSize�� listSize�� LIMIT �Լ��� �Խñ��� �ҷ��ͼ� ���� Vector�� ũ���̸�,
							(������������ ����) �� �������� listSize=10�̹Ƿ� ���� if�� ���ǿ� ������ ���� �� ������(i�� �ִ� 9��),
							�������������� 10�̸��� ���ڵ尳���� ���� �� �����Ƿ�, �׸�ŭ�� �ݺ��� ������ ���������ٴ� �ǹ� */
								for (int i = 0; i < numPerPage; /*10��*/ i++) {
									if (i == listSize)
										break;

									// vlist���� ���������� �����ͼ� bean ��ü ���� �� ��´�.
									ReviewBean bean = vlist.get(i);
	
									// bean���� �� get
									int rnum = bean.getRnum();
									int onum = bean.getOnum();
									String rid = bean.getRid();
									int pnum = bean.getPnum();
									String date = bean.getDate();
									String subject = bean.getSubject();
									String content = bean.getContent();
									double score = bean.getScore();
									String filename = bean.getFilename(); // ���� ���ε� �� ��� ���� �� ������ �߰�
									int filesize = bean.getFilesize();
	
									// ���� ��� �� count
									int rCount = cMgr.getRCommentCount(rnum);
							%>
							<!-- �� ��(����)�� �´� �� �ݺ������� ���� -->
								<tr align="center" class="table-data">
									<td><%=totalRecord - start - i%></td><!-- ������� : ���� �ֽű��� ���� ���� ���� -->
									<td><%=pnum %></td>
									<td><%=score%></td>
									<td align="left">
										<a href="javascript:read('<%=i%>')" class="review-board-aTag"><%=subject%></a> <!-- �������� --> 
										<%if (filename != null) {%>
											<img src="../img/file_icon1.png" width="15px" height="15px" align="middle"> <!-- ���������� �̸�Ƽ�� ���� -->
										<%}%>
										<%if (rCount > 0) {%> <!-- ����ִٸ� --> 
											<font color="black">(<%=rCount%>)</font> <!-- ���������� (��ۼ�) ���� --> 
										<%}%>
									</td>
									<td><%=rid%></td><!-- �����ۼ��� -->
									<td><%=date%></td><!-- �����ۼ���¥ -->
									<td>
										<%if(id.equals(rid) || id==rid || id=="admin" || id.equals("admin")){%>
											<form name="deleteReviewFrm" action="adminReviewDeleteProc.jsp" method="post">
												<input type="hidden" name="rnum" value="<%=rnum%>">
												<input type="hidden" name="filename" value="<%=filename%>">
												<input type="submit" name="deleteBtn" value="����" class="btn btn-primary deleteBtn">
											</form>
										<%}%>
									</td>
								</tr>
								<!-- ���䴩���� ������ �̵����� �Ʒ��� �ߵ��� -->
								<tr style="display:none; text-align:left" class="reviewDetail">
									<td colspan="7" align="left" >
										<form name="reviewDetailFrm" action="reviewUpdate.jsp?rnum=<%=rnum%>" method="POST" class="reviewDetailFrm">
											<input type="hidden" name="rnum" value="<%=rnum%>">
											<input type="hidden" name="onum" value="<%=onum%>">
											<input type="hidden" name="rid" value="<%=rid%>">
											<input type="hidden" name="pnum" value="<%=pnum%>">
											<input type="hidden" name="date" value="<%=date%>">
											<input type="hidden" name="subject" value="<%=subject%>">
											<input type="hidden" name="content" value="<%=content%>">
											<input type="hidden" name="score" value="<%=score%>">
											<%if(score%1.0!=0 /*�Ǽ���*/){
												int share = (int)(score / 1.0); // ��
												int remainder = (int)(Math.ceil(score % 1.0)); // ������

												for(int j=0; j<share; j++){%>
													<img src="../img/full-star-score.png" width="30vw" height="30vh">
													  
												<%}
												for(int j=0; j<remainder; j++){%>
													<img src="../img/half-star-score.png" width="30vw" height="30vh">
												<%}
												for(int j=0; j<5-share-remainder; j++){%>
													<img src="../img/blank-star-score.png" width="30vw" height="30vh">
												<%}
											}else if(score%1.0==0 /*������*/){
												int share = (int)(score / 1.0); // ��
												
												for(int j=0; j<share; j++){%>
													<img src="../img/full-star-score.png" width="30vw" height="30vh">
												<%}
												for(int j=0; j<5-share; j++){%>
												<img src="../img/blank-star-score.png" width="30vw" height="30vh">
												<%}
											}// -- if-else�� ��%>
											&nbsp;&nbsp;&nbsp;<label class="reviewInfo"><%=rid%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=date%><br></label>
											<br><br>
											<h4><%=subject%></h4>
											<h6><%=content%></h6>
											<%if(filename!=null){ %>
												<img src="../storage/<%=filename%>" width="800vw" height="400vw" style="display:block; margin: 0 auto; object-fit: cover;"><br>
												<input type="hidden" name="filename" value="<%=filename%>">
											<%} %>
											<%if(id.equals(rid) || id==rid) { /*���θ����� ������ư Ȱ��ȭ*/%>
												<input type="submit" class="btn btn-primary submitBtn" value="����">
											<%}%>
										</form>
										<br>
										<%
										Vector<RCommentBean> cvlist = cMgr.listRComment(rnum);%>
										<h6>�ش� ����� �� <%=cvlist.size()%>���� ����� �޷Ƚ��ϴ�!</h6>
										<%for(int j=0; j<cvlist.size(); j++){
											rcBean = cvlist.get(j);
											
											int rcNum = rcBean.getRcNum();
											String cid = rcBean.getCid();
											String rcDate = rcBean.getRcDate();
											String comment = rcBean.getComment();
											
											if(!cvlist.isEmpty()) {
										%>
												<form name="commentListFrm" action="commentDeleteProc.jsp" method="POST">
													<%=j+1%>) <%=cid %> : <%=comment%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[<%=rcDate%>�� �ۼ��� ����Դϴ�.]
													<%if(id=="admin" || id.equals("admin")){%> <!-- �����ڸ� ��� ��� ���� ���� -->
													<input type="hidden" name="rcNum" value="<%=rcNum%>">
													<input type="hidden" name="pnum" value="<%=pnum%>">
													<input type="hidden" name="flag" value="">
													<input type="submit" class="btn btn-primary commentDeleteBtn" value="����">
													<%}%>
												</form>
											<%} %>
										<%} %>
										<br>
										<%if(id=="admin"||id.equals("admin")) {%>
											<form name="commentFrm" action="CommentInsertProc.jsp" method="post">
												<input type="hidden" name="rnum" value="<%=rnum%>">
												<input type="hidden" name="cid" value="<%=id%>">
												<input type="hidden" name="pnum" value="<%=pnum%>">
												<input type="text" name="comment">
												<input type="submit" class="btn btn-primary submitBtn" value="�ۼ�">
											</form>
										<%}%>
									</td>
								</tr>
								<%} // --- for��%>
							</table> <%} // ---if-else��%>
						</td>
					</tr>
					<tr>
						<td align="center">
							<!-- ����¡ �� �� Start --> 
							<!-- ������ �̵�(ù�������� ����� ��)--> 
							<%if (nowBlock > 1) {%>
								<a href="javascript:block('<%=nowBlock - 1/*������*/%>')" class="review-board-block-aTag">&nbsp;�� ��&nbsp;</a> 
							<%}%> <!-- ����¡(Ư����) --> 
							<%// �Ʒ������� for�� ������ ���� 1~16 -> 1~15���� �ݺ�
							int pageStart = (nowBlock - 1) * pagePerBlock + 1; /*����1, 16, 31, ...*/
							/*������ ���� 15�������� �ȵ� �� �����Ƿ� ���׿����� ���*/
							int pageEnd = (pageStart + pagePerBlock /*15*/) < totalPage ? pageStart + pagePerBlock : totalPage + 1; 
	
	 						// �ݺ��� (15���� �ݺ�, ������ �������� 91~101������������ �ݺ���)
	 						for (; pageStart < pageEnd; pageStart++) { // ����� ���� �ʱ����? pageStart = 1;���� ����%> 
	 							<a href="javascript:pageing('<%=pageStart%>')"> 
									<%if(pageStart == nowPage){%>
										<font color="black">[<%=pageStart%>]</font>
									<%}else { %>
										<font color="#a0a0a0">[<%=pageStart%>]</font>
									<%} %>
								</a> 
							<%} // --- for%> 
							<!-- ������ �̵� ��� (���������� ���� ���)--> 
							<%if (totalBlock > nowBlock) {%>
								<a href="javascript:block('<%=nowBlock + 1%>')" class="review-board-block-aTag">&nbsp;�� ��&nbsp;</a> 
							<%}%> 
						<!-- ����¡ �� �� End -->
						</td>
					</tr>
					<tr>
						<td colspan="7">
							<div class="searchDiv">
								<!-- check() �޼ҵ� ȣ�� - �׼ǰ� �����Ƿ� ���ȣ��� -->
								<form name="searchReviewFrm" class="searchReviewFrm">
									<select name="keyField" size="1" class="form-select">
										<option value="pnum">��ǰ��ȣ</option>
										<option value="rid">�ۼ��� ID</option>
										<option value="subject">�� ��</option>
										<option value="content">�� ��</option>
									</select> <!-- ����Ʈ text type --> 
									<input name="keyWord" size="16" class="form-control review-keyword"> 
									<input type="hidden" name="nowPage" value="1"> <!-- �˻� �� �ʱ�ȭ : �˻� ����� 1���������� �������Ƿ�-->
									<input type="button" value="�˻�" onclick="search()" class="btn btn-primary reviewSearchBtn">
									<!-- 'ó������' ��ư ������ �� list()�Լ� ȣ�� -> listFrm submit -> reload = true ���� -> keyField, keyWord �ʱ�ȭ�� -->
									<a href="javascript:list()"><button type="button" class="btn btn-primary initBtn">ó������</button></a> 
								</form>
							</div>
						</td>
					</tr>
				</table>
				<!-- �Խù� ����Ʈ End -->
				


				<!-- ó������ ��ư ������ list() �޼ҵ带 ���� post������� ���� (�ʱ�ȭ)-->
				<form name="listFrm" method="post">
					<input type="hidden" name="reload" value="true"> 
					<input type="hidden" name="nowPage" value="1">
				</form>

				<!-- �Ʒ� ������ GET������� �����ϸ�, 10�� 15�� �� ������ �ٲܶ����� ���ȣ�� -->
				<form name="readFrm">
					<input type="hidden" name="nowPage" value="<%=nowPage%>"> 
					<input type="hidden" name="numPerPage" value="<%=numPerPage%>"> 
					<input type="hidden" name="keyField" value="<%=keyField%>"> 
					<input type="hidden" name="keyWord" value="<%=keyWord%>"> 
					<input type="hidden" name="rnum">
				</form>
			</div>
		</div>
</body>
</html>