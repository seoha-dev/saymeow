<!-- �̹� ���� õ�� ���־, ������ �����Ϸ���µǸ� �����ۼ��Ϸ��� ����� �����ƴ�! -->
<!-- ���߼����ؼ� ������ �����ϰ��� ������ �ð� ���� ��-->
<%@page import="saymeow.UtilMgr"%>
<%@page import="saymeow.OrderBean"%>
<%@page import="java.util.Vector"%>
<%@page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<jsp:useBean id="oMgr" class="saymeow.OrderMgr"/>
<jsp:useBean id="rMgr" class="saymeow.ReviewMgr"/>
<%
	Vector<OrderBean> ovlist = new Vector<OrderBean>();
	int price = 0;
	int quantity = 0;
	int totalPrice = 0;
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

// ���� �ֹ� �� 
totalRecord = oMgr.getTotalCountById(keyField,keyWord,(String)session.getAttribute("idKey")); // �˻��� ���� keyField, keyWord �� �����Ǿ� �ְ�, �ƴ� ���� "" �� ����

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
<meta charset="UTF-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<title>�ֹ� ���� ��ȸ</title>
<script>
	function allChk() {
		o = document.ofrm;
		if(o.allCh.checked/*üũ�̺�Ʈ*/){
			for(i=1;i<o.och.length;i++){
				o.och[i].checked = true;
				if(o.och[i].disabled)
					o.och[i].checked = false;
			}
			o.btn.disabled = false;//��ư�� Ȱ��ȭ
			o.btn.style.color = "blue";
			o.btnForPayment.disabled = false;//��ư�� Ȱ��ȭ
			o.btnForPayment.style.color = "blue";
		} else {
			for(i=1;i<o.och.length;i++){
				o.och[i].checked = false;
			}
			o.btn.disabled = true;//��ư�� ��Ȱ��ȭ
			o.btn.style.color = "gray";
			o.btnForPayment.disabled = true;//��ư�� ��Ȱ��ȭ
			o.btnForPayment.style.color = "gray";
		}
	}
	
	function chk() {
		o = document.ofrm;
		for(i=1;i<o.och.length;i++){
			if(o.och[i].checked/*üũ�� �Ǿ�����*/){
				o.btn.disabled = false;//��ư�� Ȱ��ȭ
				o.btn.style.color = "blue";
				o.btnForPayment.disabled = false;//��ư�� Ȱ��ȭ
				o.btnForPayment.style.color = "blue";
				return;
			}//---if
		}//----for
		//for������ �ذ��� �� ������ �ؿ� 3���� ����.
		o.allCh.checked = false;
		o.btn.disabled = true;//��ư�� ��Ȱ��ȭ
		o.btn.style.color = "gray";
		o.btnForPayment.disabled = true;//��ư�� ��Ȱ��ȭ
		o.btnForPayment.style.color = "gray";
	}
	
	
	function ReviewForm(onum,pnum){
		document.review.onum.value=onum;
		document.review.pnum.value=pnum;
		document.review.submit();
	}
	
	function submitOrderProc(onum, pname){
		console.log(onum);
		document.paymentFrm.onum.value=onum;
		document.paymentFrm.pname.value=pname;
		document.paymentFrm.submit();
	}
	
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
		document.listFrm.action = "orderList.jsp";
		document.listFrm.submit(); // reload�� nowPage VALUE�� POST������� �����Ͽ� ���ȣ��
	}

	// �˻�
	function check() {
		if (document.searchFrm.keyWord.value == "") {
			alert("�˻�� �Է��ϼ���.");
			document.searchFrm.keyWord.focus();
			return;
		}
		document.searchFrm.submit(); // action �����Ƿ� ���ȣ��
	}

	// �Խñ� �б�
	function read(i) {
		/*�׽�Ʈ : ��۽����� �����غ���*/
		if(document.getElementsByClassName('reviewDetail')[i].style.display = 'hidden'){
			document.getElementsByClassName('reviewDetail')[i].setAttribute("style","display:table-row"); // block ��� table-row�ؾ� colspan ����
		}
	}
	
</script>
<!-- ��Ʈ��Ʈ�� CSS -->
<link
href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
rel="stylesheet"
integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
crossorigin="anonymous">    
<%@ include file="../top2.jsp"%>
</head>
<body>
	<div class="d-flex align-items-start">
		<div class="nav flex-column nav-pills me-3" id="v-pills-tab" role="tablist" aria-orientation="vertical">
			<a href="orderList.jsp"><button class="nav-link active" id="v-pills-home-tab" data-bs-toggle="pill" data-bs-target="#v-pills-home" type="button" role="tab" aria-controls="v-pills-home" aria-selected="true">�ֹ�������ȸ</button></a>
			<a href="memberUpdate.jsp"><button class="nav-link" id="v-pills-profile-tab" data-bs-toggle="pill" data-bs-target="#v-pills-profile" type="button" role="tab" aria-controls="v-pills-profile" aria-selected="false">ȸ����������</button></a>
			<a href="readMyReview.jsp"><button class="nav-link" id="v-pills-messages-tab" data-bs-toggle="pill" data-bs-target="#v-pills-messages" type="button" role="tab" aria-controls="v-pills-messages" aria-selected="false">�� ���� ���</button></a>
			<a href="deleteMember.jsp"><button class="nav-link" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">ȸ��Ż��</button></a>
		</div>
		<div class="tab-content" id="v-pills-tabContent" align="center" style="margin:0 auto;">
		<form name="ofrm" action="orderCancleProc.jsp">
			<input type="hidden" name="och" value="0">
			<h3 style="margin: 5vh auto">�ֹ� ��Ȳ</h3>
			<!-- �Խù� ����Ʈ Start -->
			<table>
				<tr>
					<td align="center" colspan="9">
						<%
						ovlist = oMgr.getOrderList(keyField, keyWord, start, cnt, id);
						int listSize = ovlist.size(); // �� �������� ��� �� ���ڵ尹�� (�ִ� 10��, ������ �������� 10 ������ ���� ���� ���� ����)
						if (ovlist.isEmpty()) {
							out.println("��ϵ� �Խù��� �����ϴ�.");
						} else {%>
							<table cellspacing="0" class="table">
								<tr align="center" class="table-column" style="background-color: #eee;">
									<td width="100"><input type="checkbox" name="allCh" onclick="allChk()"></td>
									<th width="100">�ֹ�����</th>
									<th width="100">��ǰ��ȣ</th>
									<th width="100">��ǰ��</th>
									<th width="100">�� ��</th>
									<th width="100">���簡��</th>
									<th width="100">�� ����</th>
									<th width="100">�ֹ���ID</th>
									<th width="100">�ֹ���¥</th>
									<th width="150">�ֹ�����</th>
								</tr>
								<%
								for (int i = 0; i < numPerPage; /*10��*/ i++) {
									if (i == listSize)
										break;
	
									// vlist���� ���������� �����ͼ� bean ��ü ���� �� ��´�.
									OrderBean bean = ovlist.get(i);
	
									// bean���� �� get
									int onum = bean.getOnum();
									int pnum = bean.getPnum();
									int qty = bean.getQty();
									int price1 = bean.getPrice1();
									String pname = bean.getPname();
									String oid = bean.getOid();
									String regdate = bean.getRegdate();
									String oaddress = bean.getOaddress();
									String state = bean.getState();
								%>
									<!-- �� ��(����)�� �´� �� �ݺ������� ���� -->
									<tr align="center">
										<td>
											<%if(bean.getState().equals("2")||bean.getState().equals("3")){ %>
												<input type="checkbox" name="och" value="<%=bean.getOnum()%>" onclick="chk()" disabled>
											<%}else { %>
												<input type="checkbox" name="och" value="<%=bean.getOnum()%>" onclick="chk()">
											<%}%>
										</td>
										<td><%=totalRecord - start - i%></td><!-- ������� : ���� �ֽű��� ���� ���� ���� -->
										<td><%=pnum%></td>
										<td align="left">
											<a href="javascript:read('<%=i%>')" class="review-board-aTag"><%=pname%></a>
										</td>
										<td><%=qty%></td>
										<td><%=price1%></td>
										<td><%=qty*price1%></td>
										<td><%=oid%></td>
										<td><%=regdate%></td>
										<td>
										<%
											switch(bean.getState()){
												case"1": out.print("������");%>
												|&nbsp;<input type="button" value="�����ϱ�" style="border:1px solid #eee; background-color: #eee; font-size:0.9em; color:#495057;" onclick="submitOrderProc('<%=onum%>','<%=pname%>')">
												<%break;
												case"2": 
												if(!rMgr.checkReivewInsert(onum)/*false -> ���� �ۼ� ���ѻ���*/){%>
												<input type="button" value="���侲��" style="border:1px solid #eee; background-color: #eee; font-size:0.9em; color:#495057;" onclick="ReviewForm('<%=onum%>','<%=pnum%>')">
												<%} else {%>
													<%out.print("�����ۼ��Ϸ�");%>
												<%}
												break;
												case"3": %><font color="red"><%out.print("�ֹ����");%></font><%break;
											}
										%>
										</td>
									</tr>
									<%}// --vector ������ if-else�� �� %>
								</table>
							
						</td>
					</tr>
				<!-- �ι�° table ��-->
				
				
				<!-- ����¡ �� �� Start --> 
				<%if(totalRecord>1){ %> 
					<tr>
						<td align="center" style="font-size:1em;">
							<!-- ������ �̵�(ù�������� ����� ��)--> 
							<%if (nowBlock > 1) {%>
								<a href="javascript:block('<%=nowBlock - 1/*������*/%>')" class="review-board-aTag">&nbsp;�� ��&nbsp;</a> 
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
									<a href="javascript:block('<%=nowBlock + 1%>')" class="review-board-aTag">&nbsp;�� ��&nbsp;</a> 
								<%}%> 
								<!-- ����¡ �� �� End -->
							</td>
						</tr>
						<tr>
							<td colspan="6">
								<div style="text-align:center; margin: 2vw;">
									<form name="searchFrm" class="searchFrm"> 
										<input type="hidden" name="nowPage" value="1"> <!-- �˻� �� �ʱ�ȭ : ���� �˻� ����� 1���������� �������Ƿ�-->
									</form>
								</div>
							</td>
						</tr>
						
						<table>
							<input type="submit" name="btn" value="�ֹ����" style="border:1px solid #eee; background-color: #eee;" disabled>
						</table>
					<%} // --totalRecord>1 if�� %>
					<tr>
						<!-- 'ó������' ��ư ������ �� list()�Լ� ȣ�� -> listFrm submit -> reload = true ���� -> keyField, keyWord �ʱ�ȭ�� -->
						<td>
							<a href="javascript:list()" class="review-board-aTag" style="display:block; width:5vw; border:1px solid #eee; background-color: #eee; margin:3vh; transform: translateX(30vw);">
								<button type="button" style="border:none; height:4vh;">ó������</button>
							</a> 
						</td>
					</tr>
				<%} %>
				</table>
			</form>
			<!-- �Խù� ����Ʈ End -->
				
			<form name="review" method="post" action="../review/reviewForm.jsp">
				<input type="hidden" name="onum">
				<input type="hidden" name="pnum">
				<input type="hidden" name="flag" value="flagForReview">
			</form>	
			
			
			<!-- ���ϰ��� ���� �� -->	
			<form name="paymentFrm" method="post" action="../order/directOrderProc.jsp">
				<input type="hidden" name="flag" value="myOrderList">
				<input type="hidden" name="pname">
				<input type="hidden" name="onum">
				<input type="hidden" name="state">
			</form>
			
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
	</div>
</body>				
</html>