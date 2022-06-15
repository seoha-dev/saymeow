<%@page import="saymeow.UtilMgr"%>
<%@page import="saymeow.ProductBean"%>
<%@page import="saymeow.RCommentBean"%>
<%@page import="saymeow.ReviewBean"%>
<%@page import="java.util.Vector"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="pdMgr" class="saymeow.ProductDetailMgr" />
<jsp:useBean id="rMgr" class="saymeow.ReviewMgr" />
<jsp:useBean id="cMgr" class="saymeow.RCommentMgr" />
<jsp:useBean id="rcBean" class="saymeow.RCommentBean" />

<%
request.setCharacterEncoding("EUC-KR");
// pnum �� �޾ƿ��� 
int pnum = UtilMgr.parseInt(request, "pnum");

ProductBean pbean = pdMgr.getProduct(pnum);

int price1 = pbean.getPrice1();
String image = pbean.getImage();
String detail = pbean.getDetail();
String mClass = pbean.getMclass();
String cClass = pbean.getSclass();
String pname = pbean.getPname();
int stock = pbean.getStock();
%>

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
totalRecord = rMgr.getTotalCountByPnum(keyField, keyWord, pnum); // �˻��� ���� keyField, keyWord �� �����Ǿ� �ְ�, �ƴ� ���� "" �� ����

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

<!doctype html>
<html>
<head>
<!-- ���� CSS -->

<script>
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
	document.listFrm.action = "productDetail.jsp";
	document.listFrm.submit(); // reload�� nowPage VALUE�� POST������� �����Ͽ� ���ȣ��
}

// �˻�
function check() {
	if (document.searchFrm.keyWord.value == "") {
		alert("�˻�� �Է��ϼ���.");
		document.searchFrm.keyWord.focus();
		return;
	}
	document.searchFrm.submit();
}

//�Խñ� �б�
function read(i) { // ���
	if(document.getElementsByClassName('reviewDetail')[i].style.display == 'none'){
		document.getElementsByClassName('reviewDetail')[i].setAttribute("style","display:table-row"); // block ��� table-row�ؾ� colspan ����
	} else if(document.getElementsByClassName('reviewDetail')[i].style.display == 'table-row'){
		document.getElementsByClassName('reviewDetail')[i].style.display = 'none';
	}
}
</script>
<!-- ��Ʈ��Ʈ�� CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<link rel="stylesheet" href="../css/productDetail.css">
<%@ include file="../top2.jsp"%>
</head>
<body id = "productDetail">
	
	<table>
		  <form method="post" name="frmC" action="../order/cartInsertProc.jsp">
			<tr>
				<td align="center">
					<div class="initialize" area="before">
						<span sp-font="13" style="color: #333; margin-bottom: 20px;">
						<b>��ǰ �� ������</b></span>
					</div>

					<div class="shop_info">
						<div class="img_area">
							<img src="../image/<%=image%>" alt="#">
						</div>
				
						<dl class="info_list">

							<div class="category">
								<dt>ī�װ�</dt>
								<dd><%=mClass%> > <%=cClass%></dd>
							</div>
							<div class="name">
								<dt>�̸�</dt>
								<dd><%=pname%></dd>
							</div>
							<div class="price">
								<dt>����</dt>
								<dd class="cost"><%=price1%></dd>
								��
							</div>
							<div class="count">
								<dt>����</dt>
								<dd>
									<input onkeyup="costCount()" type="number" value="1"
										autocomplete="off" min="0" name="qty">
									<div class="num_">
										<div class="btn_ up"></div>
										<div class="btn_ down"></div>
									</div>
								</dd>
							</div>

							<div>
								<dt>�� ����</dt>
								<dd class="last_cost">
									<span></span>��
								</dd>
							</div>

						</dl>

						<div class="btn_wrap">
							<form name="cartFrm">
								<%if(stock == 0){%>
										<input type="button" class="side_btn2" value="��ٱ���"> 
										<input type="button" class="side_btn2" value="�����ϱ�">
									<%} else {%>
										<input type="button" class="side_btn" value="��ٱ���" onclick="javascript:cartInsert(this.form)"> 
										<input type="button" class="side_btn" value="�����ϱ�" onclick="javascript:directOrder(this.form)"> 
									<%}%>
									<input type="hidden" name="flag" value="insert"> 
									<input type="hidden" name="id" value="<%=id%>"> 
									<input type="hidden" name="pnum" value="<%=pnum%>"> 
									<input type="hidden" name="pname" value="<%=pname%>"> 
									<input type="hidden" name="price1" value="<%=price1%>">
							</form>
						</div>
					</div>
					<div class="detail">
						<span>��ǰ �� �̹���</span> <img src="../image/<%=detail%>" alt="">
						<div class="show_btn show">������</div>
					</div>
					
					
					<!-- ���������� Start -->
					<div class="review">
						<div class="review_wrap">
							<div id="review-board">
								<h3 class="review-board-topic">����</h3> <!-- pnum�� ������ �ϰ�, ������ ��ǰ�󼼿��� pnum�޾ƿ� -->
								<label>�ش� ��ǰ�� �� <b><%=totalRecord%></b>���� ���䰡 �ֽ��ϴ�!</label>
								<br>
								<table>
									<tr>
										<td style="text-align:left;">
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
								</tr>
							</table>
							
							<!-- �Խù� ����Ʈ Start -->
							<table>
								<tr>
									<td align="center" colspan="2">
										<%
										// pnum�� �´� ���丸 ��������
										Vector<ReviewBean> vlist = rMgr.getReviewListByPnum(keyField, keyWord, start, cnt, pnum);
										int listSize = vlist.size(); // �� �������� ��� �� ���ڵ尹�� (�ִ� 10��, ������ �������� 10 ������ ���� ���� ���� ����)
										if (vlist.isEmpty()) {
											out.println("��ϵ� �Խù��� �����ϴ�.");
										} else {
										%>
											<table class="table">
												<tr align="center" class="table-column">
													<th width="100">�� ȣ</th>
													<th width="50">�� ��</th>
													<th width="100">�� ��</th>
													<th width="100">���̵�</th>
													<th width="100">�� ¥</th>
													<th width="100">&nbsp;</th>
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
														pnum = bean.getPnum();
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
														<td><a href="javascript:read('<%=i%>')" class="review-board-aTag"><%=totalRecord - start - i%></a></td><!-- ������� : ���� �ֽű��� ���� ���� ���� -->
														<td><a href="javascript:read('<%=i%>')" class="review-board-aTag"><%=score%></a></td>
														<td align="left">
															<a href="javascript:read('<%=i%>')" class="review-board-aTag"><%=subject%></a> <!-- �������� --> 					
															<%if (filename != null) {%>
																<img src="../img/file_icon1.png" width="15px" height="15px" align="middle"> <!-- ���������� �̸�Ƽ�� ���� -->
															<%}%>
															<%if (rCount > 0) {%> <!-- ����ִٸ� --> 
																(<%=rCount%>)
															<%}%>
														</td>
														<td><%=rid%></td><!-- �����ۼ��� -->
														<td><%=date%></td><!-- �����ۼ���¥ -->
														
														<td>
															<%if(id!=null){
																if(id.equals(rid) || id==rid || id.equals("admin") || id=="admin"){
															%>
																<form name="deleteReviewFrm" action="../review/reviewDeleteProc.jsp" method="post">
																	<input type="hidden" name="rnum" value="<%=rnum%>">
																	<input type="hidden" name="pnum" value="<%=pnum%>">
																	<input type="hidden" name="filename" value="<%=filename%>">
																	<input type="hidden" name="keyField" value="<%=keyField%>">
																	<input type="hidden" name="keyWord" value="<%=keyWord%>">
																	<input type="hidden" name="nowPage" value="<%=nowPage%>">
																	<input type="submit" class="btn btn-primary deleteBtn" value="����">
																</form>
																<%}%>
															<%} else{%>
																<form name="deleteReviewFrm" action="../review/reviewDeleteProc.jsp" method="post">
																	<input type="hidden" name="rnum" value="<%=rnum%>">
																	<input type="hidden" name="pnum" value="<%=pnum%>">
																	<input type="hidden" name="filename" value="<%=filename%>">
																	<input type="hidden" name="keyField" value="<%=keyField%>">
																	<input type="hidden" name="keyWord" value="<%=keyWord%>">
																	<input type="hidden" name="nowPage" value="<%=nowPage%>">
																</form>	
															<%} %>
														</td>
													</tr>
										
													<!-- ���䴩���� ������ �̵����� �Ʒ��� �ߵ��� -->
													<tr style="display:none; text-align:left" class="reviewDetail">
														<td colspan="7" align="left">
															<form name="reviewDetailFrm" action="../review/reviewUpdate.jsp?rnum=<%=rnum%>" method="POST" class="reviewDetailFrm" style="text-align:left;">
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
																		<img src="../img/full-star-score.png" width="30vw" height="30vh" class="scoreImg">
																		  
																	<%}
																	for(int j=0; j<remainder; j++){%>
																		<img src="../img/half-star-score.png" width="30vw" height="30vh" class="scoreImg">
																	<%}
																	for(int j=0; j<5-share-remainder; j++){%>
																		<img src="../img/blank-star-score.png" width="30vw" height="30vh" class="scoreImg">
																	<%}
																} else if(score%1.0==0 /*������*/){
																	int share = (int)(score / 1.0); // ��
																	
																	for(int j=0; j<share; j++){%>
																		<img src="../img/full-star-score.png" width="30vw" height="30vh" class="scoreImg">
																	<%}
																	for(int j=0; j<5-share; j++){%>
																	<img src="../img/blank-star-score.png" width="30vw" height="30vh" class="scoreImg">
																	<%}
																} // -- if-else�� ��%>
																&nbsp;&nbsp;&nbsp;<label class="reviewInfo"><%=rid%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=date%><br></label>
																<br><br>
																<h4><%=subject%></h4>
																<h6><%=content%></h6>
																<%if(filename!=null){ %>
																	<img src="../storage/<%=filename%>" width="800vw" height="400vw" style="display:block; margin: 0 auto; object-fit: cover;"><br>
																	<input type="hidden" name="filename" value="<%=filename%>">
																<%} %>
																<%if(id!=null){
																	if(id.equals(rid) || id==rid) { /*���θ����� ������ư Ȱ��ȭ*/%>
																		<input type="submit" class="btn btn-primary submitBtn" value="����">
																	<%}%>
																<%} %>
															</form>
															<br>
															<%
															Vector<RCommentBean> cvlist = cMgr.listRComment(rnum);%>
															<h6 style="text-align:left;">�ش� ����� �� <%=cvlist.size()%>���� ����� �޷Ƚ��ϴ�!</h6>
															<%for(int j=0; j<cvlist.size(); j++){
																rcBean = cvlist.get(j);
																
																int rcNum = rcBean.getRcNum();
																String cid = rcBean.getCid();
																String rcDate = rcBean.getRcDate();
																String comment = rcBean.getComment();
																
																if(!cvlist.isEmpty()) {
															%>
																	<form name="commentListFrm" action="../admin/commentDeleteProc.jsp" method="POST" style="text-align:left;">
																		<%=j+1%>) <%=cid %> : <%=comment%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[<%=rcDate%>�� �ۼ��� ����Դϴ�.]
																		<%if(id=="admin" || id.equals("admin")){%> <!-- �����ڸ� ��� ��� ���� ���� -->
																		<input type="hidden" name="rcNum" value="<%=rcNum%>">
																		<input type="hidden" name="pnum" value="<%=pnum%>">
																		<input type="hidden" name="flag" value="productDetail">
																		<input type="submit" class="btn btn-primary commentDeleteBtn" value="����">
																		<%}%>
																	</form>
																<%} %>
															<%} %>
														<br>
														<%if(id!=null){ %>	
															<%if(id=="admin"||id.equals("admin")) {%>
																<form name="commentFrm" action="../admin/CommentInsertProc.jsp" method="post" style="text-align:left;">
																	<input type="hidden" name="rnum" value="<%=rnum%>">
																	<input type="hidden" name="cid" value="<%=id%>">
																	<input type="hidden" name="pnum" value="<%=pnum%>">
																	<input type="hidden" name="flag" value="productDetail">
																	<input type="text" name="comment" style="height:4vh;">
																	<input type="submit" class="btn btn-primary submitBtn" value="�ۼ�">
																</form>
															<%}%>
														<%} %>
														</td>
													</tr>
												<%} // --- for��%>
											</table> 
											<%} // ---if-else��%>
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
										<td colspan="6">
											<div class="searchDiv">
												<form name="searchFrm" class="searchFrm">
													<select name="keyField" size="1" class="form-select" style="">
														<option value="rid">�ۼ��� ID</option>
														<option value="subject">�� ��</option>
														<option value="content">�� ��</option>
													</select> <!-- ����Ʈ text type --> 
													<input name="keyWord" size="16" class="form-control" style="display:inline"> 
													<input type="hidden" name="nowPage" value="1"> <!-- �˻� �� �ʱ�ȭ : ���� �˻� ����� 1���������� �������Ƿ�-->
													<input type="hidden" name="pnum" value="<%=pnum%>">
													<input type="button" value="�˻�" onclick="check()" class="btn btn-primary reviewSearchBtn">
												</form>
											</div>
										</td>
									</tr>
									<tr>
										<!-- 'ó������' ��ư ������ �� list()�Լ� ȣ�� -> listFrm submut -> reload = true ���� -> keyField, keyWord �ʱ�ȭ�� -->
										<td style="text-align:right">
											<a href="javascript:list()"><button type="button" class="btn btn-primary initBtn">ó������</button></a> 
										</td>
									</tr>
								</table>
								<!-- �Խù� ����Ʈ End -->


								<!-- ó������ ��ư ������ list() �޼ҵ带 ���� post������� ���� (�ʱ�ȭ)-->
								<form name="listFrm" method="post">
									<input type="hidden" name="reload" value="true"> 
									<input type="hidden" name="nowPage" value="1">
									<input type="hidden" name="pnum" value="<%=pnum%>">
								</form>
						
								<!-- �Ʒ� ������ GET������� �����ϸ�, 10�� 15�� �� ������ �ٲܶ����� ���ȣ�� -->
								<form name="readFrm">
									<input type="hidden" name="nowPage" value="<%=nowPage%>"> 
									<input type="hidden" name="numPerPage" value="<%=numPerPage%>"> 
									<input type="hidden" name="keyField" value="<%=keyField%>"> 
									<input type="hidden" name="keyWord" value="<%=keyWord%>"> 
									<input type="hidden" name="rnum">
									<input type="hidden" name="pnum" value="<%=pnum%>">
								</form>
							</div>	
						</div>
						<!-- ���������� End -->		
						<input type="button" value="<BACK" onClick="history.go(-1)" class="btn btn-primary backBtn">
						<!-- ������������ ���ư��� -->
					</div>
				</td>
			</tr>
		</table>
		
		<script>
		    window.onload = function () {
		        costCount()
		
		        const infoList = document.querySelector('.info_list');
		        const btnU = document.querySelector('.up');
		        const btnD = document.querySelector('.down');
		        const btnS = document.querySelector('.show');
		        const det = document.querySelector('.detail');
		    	const basket = document.querySelector('#basket');
		        const buyBtn = document.querySelector('#buyBtn');
		
		        console.log(btnS.length)
		
		        btnS.addEventListener('click', function(){
		            if(det.classList.contains('on')){
		                det.classList.remove('on');
		                btnS.innerText = '������';
		            }
		            else{
		                det.classList.add('on');
		                btnS.innerText = '����';
		            }
		        })
		
		        btnU.addEventListener('click', function () {
		            infoList.querySelector('input').value++;
		            costCount();
		        })
		        btnD.addEventListener('click', function () {
		            if(infoList.querySelector('input').value > 0){
		                infoList.querySelector('input').value--;
		                costCount();
		            }
		            
		        })
		
		    }
        
		    function costCount() {
		        const infoList = document.querySelector('.info_list');
		        const infoItem = infoList.querySelector('.cost');
		        const infoCost = infoList.querySelector('.last_cost');
		        
		        var cost = infoItem.innerText // ��ǰ ����
		        var count = infoList.querySelector('input').value; // ��ǰ ����
		        infoCost.querySelector('span').innerText = count * cost;
		    }


		     //cart
		     function cartDelete(form){
		    		form.flag.value="delete";
		    		form.submit();
		    }
		
		     function cartOrder(form){
		    		form.flag.value="order";
		    		form.submit();
		    }
     
		     function cartInsert(form){ // ��ٱ��� ��ư Ŭ��
		    	const id = '<%=id%>';
		    	if(<%=session.getAttribute("idKey")==null%>){ 
		    		alert("�α��� �� �̿����ּ���.");
		    		location.href="../member/login.jsp";
		    	} else {
		    		form.flag.value="insert";
		    		form.submit();
		    		location.href("../order/cartInsertProc.jsp"); // cartInsertProc.jsp -> OrderMgr
		    	}
		     }
		     
		    function directOrder(form){ // �ֹ��ϱ� ��ư Ŭ��
		    	const id = '<%=id%>';
		    	if(<%=session.getAttribute("idKey")==null%>){ 
		    		alert("�α��� �� �̿����ּ���.");
		    		location.href="../member/login.jsp";
		    	} else {
		    		form.flag.value = "direct";
		    		form.submit();
		    		location.href("../order/cartInsertProc.jsp"); // cartInsertProc.jsp -> OrderMgr
		    	}
		    }
		</script>
</body>
</html>