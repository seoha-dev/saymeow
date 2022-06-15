<!-- 이미 리뷰 천개 들어가있어서, 무조건 결제완료상태되면 리뷰작성완료라고 뜰거임 에러아님! -->
<!-- 다중선택해서 결제로 구현하고자 했으나 시간 부족 ㅠ-->
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
<% // 페이징 처리에 필요한 변수 선언
int totalRecord = 0; // 총 게시물 수 (최초 0개)
int numPerPage = 10; // 한 페이지당 불러올 레코드 개수 (디폴트 10개)
int pagePerBlock = 15; // 한 블럭당 총 15개 페이지 불러오기
int totalPage = 0; // 총 페이지 개수 (최초 0개)
int totalBlock = 0; // 총 블럭 개수
int nowPage = 1; // 현재 페이지 (최초 1페이지)
int nowBlock = 1; // 현재 블럭 (최초 1페이지 -> 1블럭에 위치)

if (request.getParameter("numPerPage") != null) { // x개씩보기 옵션 바꾸면 재귀호출되면서 다시 numPerPage 셋팅
	numPerPage = UtilMgr.parseInt(request, "numPerPage"); // 전달받은 numPerPage 값을 int형변환
}

// 검색 후 and 페이지 이동 시 재귀호출되므로 유지되어있음
String keyField = "", keyWord = ""; // 검색 전 디폴트
if (request.getParameter("keyWord") != null) { // 검색했다면
	keyField = request.getParameter("keyField");
	keyWord = request.getParameter("keyWord");
}

// 검색 후 '처음으로' 버튼 눌러야만 reload값이 전달되면서 검색 초기화된 상태로 재귀호출
if (request.getParameter("reload") != null && request.getParameter("reload").equals("true")) {
	keyField = "";
	keyWord = "";
}

// 최종 주문 수 
totalRecord = oMgr.getTotalCountById(keyField,keyWord,(String)session.getAttribute("idKey")); // 검색일 때만 keyField, keyWord 값 설정되어 있고, 아닐 때는 "" 값 가짐

// 페이지 클릭(list()함수) OR 게시글 읽고 '리스트로' 클릭 -> GET방식으로 위치해있던 nowPage 전달
if (request.getParameter("nowPage") != null) {
	nowPage = UtilMgr.parseInt(request, "nowPage");
}

// sql문 LIMIT에 들어가는 변수 선언 
int start = (nowPage * numPerPage) - numPerPage; // 1페이지일때 0, 2페이지일때 10, 3페이지일때 20, ...
int cnt = numPerPage; // 디폴트 10개 (한 페이지당 보여지는 레코드 개수)

// 전체 페이지 개수
totalPage = (int) Math.ceil((double) totalRecord / numPerPage); // Ex. 게시물 663개 -> 레코드개수/10(66페이지) + 1(올림 : 마지막페이지에 10으로 나눈 후 나머지 게시글 수(3개) 들어가야 하므로)

// 전체 블럭 개수
totalBlock = (int) Math.ceil((double) totalPage / pagePerBlock); // Ex. 총 67페이지 / 한 블럭당 15페이지 = 4.47 -> +1 (올림) 해서 5블럭

// 현재 몇번째 블럭인지 
nowBlock = (int) Math.ceil((double) nowPage / pagePerBlock); // Ex. 현재 1페이지 / 한 블럭당 15페이지

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<title>주문 내역 조회</title>
<script>
	function allChk() {
		o = document.ofrm;
		if(o.allCh.checked/*체크이벤트*/){
			for(i=1;i<o.och.length;i++){
				o.och[i].checked = true;
				if(o.och[i].disabled)
					o.och[i].checked = false;
			}
			o.btn.disabled = false;//버튼의 활성화
			o.btn.style.color = "blue";
			o.btnForPayment.disabled = false;//버튼의 활성화
			o.btnForPayment.style.color = "blue";
		} else {
			for(i=1;i<o.och.length;i++){
				o.och[i].checked = false;
			}
			o.btn.disabled = true;//버튼의 비활성화
			o.btn.style.color = "gray";
			o.btnForPayment.disabled = true;//버튼의 비활성화
			o.btnForPayment.style.color = "gray";
		}
	}
	
	function chk() {
		o = document.ofrm;
		for(i=1;i<o.och.length;i++){
			if(o.och[i].checked/*체크가 되었을때*/){
				o.btn.disabled = false;//버튼의 활성화
				o.btn.style.color = "blue";
				o.btnForPayment.disabled = false;//버튼의 활성화
				o.btnForPayment.style.color = "blue";
				return;
			}//---if
		}//----for
		//for문에서 해결을 못 했을때 밑에 3줄이 실행.
		o.allCh.checked = false;
		o.btn.disabled = true;//버튼의 비활성화
		o.btn.style.color = "gray";
		o.btnForPayment.disabled = true;//버튼의 비활성화
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
	
	// 페이징 처리
	function pageing(page) {
		document.readFrm.nowPage.value /*value 빼먹지말기*/= page; // 매개변수로 받은 page를 nowPage의 값으로 요청
		document.readFrm.submit();
	}

	// 블럭 이동
	function block(block) {
		document.readFrm.nowPage.value = <%=pagePerBlock%> * (block - 1) + 1;
		// block=1 -> nowPage=0, block=2 -> nowPage=16, ...
		document.readFrm.submit();
	}

	// 한 페이지당 게시글 개수
	function numPerFn(numPerPage) {
		document.readFrm.numPerPage.value = numPerPage;
		document.readFrm.submit(); // 재귀호출 시 변경된 numPerPage 전달
	}

	// (처음으로 버튼 눌러야만 실행되는 메소드) 목록 이동
	function list() {
		document.listFrm.action = "orderList.jsp";
		document.listFrm.submit(); // reload와 nowPage VALUE를 POST방식으로 전달하여 재귀호출
	}

	// 검색
	function check() {
		if (document.searchFrm.keyWord.value == "") {
			alert("검색어를 입력하세요.");
			document.searchFrm.keyWord.focus();
			return;
		}
		document.searchFrm.submit(); // action 없으므로 재귀호출
	}

	// 게시글 읽기
	function read(i) {
		/*테스트 : 토글식으로 구현해보기*/
		if(document.getElementsByClassName('reviewDetail')[i].style.display = 'hidden'){
			document.getElementsByClassName('reviewDetail')[i].setAttribute("style","display:table-row"); // block 대신 table-row해야 colspan 먹힘
		}
	}
	
</script>
<!-- 부트스트랩 CSS -->
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
			<a href="orderList.jsp"><button class="nav-link active" id="v-pills-home-tab" data-bs-toggle="pill" data-bs-target="#v-pills-home" type="button" role="tab" aria-controls="v-pills-home" aria-selected="true">주문내역조회</button></a>
			<a href="memberUpdate.jsp"><button class="nav-link" id="v-pills-profile-tab" data-bs-toggle="pill" data-bs-target="#v-pills-profile" type="button" role="tab" aria-controls="v-pills-profile" aria-selected="false">회원정보수정</button></a>
			<a href="readMyReview.jsp"><button class="nav-link" id="v-pills-messages-tab" data-bs-toggle="pill" data-bs-target="#v-pills-messages" type="button" role="tab" aria-controls="v-pills-messages" aria-selected="false">내 리뷰 목록</button></a>
			<a href="deleteMember.jsp"><button class="nav-link" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">회원탈퇴</button></a>
		</div>
		<div class="tab-content" id="v-pills-tabContent" align="center" style="margin:0 auto;">
		<form name="ofrm" action="orderCancleProc.jsp">
			<input type="hidden" name="och" value="0">
			<h3 style="margin: 5vh auto">주문 현황</h3>
			<!-- 게시물 리스트 Start -->
			<table>
				<tr>
					<td align="center" colspan="9">
						<%
						ovlist = oMgr.getOrderList(keyField, keyWord, start, cnt, id);
						int listSize = ovlist.size(); // 각 페이지가 담는 총 레코드갯수 (최대 10개, 마지막 페이지는 10 이하의 값을 가질 수도 있음)
						if (ovlist.isEmpty()) {
							out.println("등록된 게시물이 없습니다.");
						} else {%>
							<table cellspacing="0" class="table">
								<tr align="center" class="table-column" style="background-color: #eee;">
									<td width="100"><input type="checkbox" name="allCh" onclick="allChk()"></td>
									<th width="100">주문순번</th>
									<th width="100">상품번호</th>
									<th width="100">상품명</th>
									<th width="100">수 량</th>
									<th width="100">개당가격</th>
									<th width="100">총 가격</th>
									<th width="100">주문자ID</th>
									<th width="100">주문날짜</th>
									<th width="150">주문상태</th>
								</tr>
								<%
								for (int i = 0; i < numPerPage; /*10개*/ i++) {
									if (i == listSize)
										break;
	
									// vlist에서 순차적으로 가져와서 bean 객체 생성 후 담는다.
									OrderBean bean = ovlist.get(i);
	
									// bean에서 값 get
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
									<!-- 각 열(주제)에 맞는 값 반복문으로 들고옴 -->
									<tr align="center">
										<td>
											<%if(bean.getState().equals("2")||bean.getState().equals("3")){ %>
												<input type="checkbox" name="och" value="<%=bean.getOnum()%>" onclick="chk()" disabled>
											<%}else { %>
												<input type="checkbox" name="och" value="<%=bean.getOnum()%>" onclick="chk()">
											<%}%>
										</td>
										<td><%=totalRecord - start - i%></td><!-- 리뷰순번 : 가장 최신글이 위에 오는 구조 -->
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
												case"1": out.print("결제전");%>
												|&nbsp;<input type="button" value="결제하기" style="border:1px solid #eee; background-color: #eee; font-size:0.9em; color:#495057;" onclick="submitOrderProc('<%=onum%>','<%=pname%>')">
												<%break;
												case"2": 
												if(!rMgr.checkReivewInsert(onum)/*false -> 리뷰 작성 안한상태*/){%>
												<input type="button" value="리뷰쓰기" style="border:1px solid #eee; background-color: #eee; font-size:0.9em; color:#495057;" onclick="ReviewForm('<%=onum%>','<%=pnum%>')">
												<%} else {%>
													<%out.print("리뷰작성완료");%>
												<%}
												break;
												case"3": %><font color="red"><%out.print("주문취소");%></font><%break;
											}
										%>
										</td>
									</tr>
									<%}// --vector 사이즈 if-else문 끝 %>
								</table>
							
						</td>
					</tr>
				<!-- 두번째 table 끝-->
				
				
				<!-- 페이징 및 블럭 Start --> 
				<%if(totalRecord>1){ %> 
					<tr>
						<td align="center" style="font-size:1em;">
							<!-- 이전블럭 이동(첫블럭에서는 없어야 함)--> 
							<%if (nowBlock > 1) {%>
								<a href="javascript:block('<%=nowBlock - 1/*이전블럭*/%>')" class="review-board-aTag">&nbsp;이 전&nbsp;</a> 
							<%}%> <!-- 페이징(특정블럭) --> 
							<%// 아래변수로 for문 돌리면 최초 1~16 -> 1~15까지 반복
							int pageStart = (nowBlock - 1) * pagePerBlock + 1; /*최초1, 16, 31, ...*/
							/*마지막 블럭은 15페이지가 안될 수 있으므로 삼항연산자 사용*/
							int pageEnd = (pageStart + pagePerBlock /*15*/) < totalPage ? pageStart + pagePerBlock : totalPage + 1; 
			
			 				// 반복문 (15번씩 반복, 마지막 블럭에서는 91~101페이지까지만 반복됨)
			 				for (; pageStart < pageEnd; pageStart++) { // 비워진 조건 초기식은? pageStart = 1;부터 시작%> 
				 					<a href="javascript:pageing('<%=pageStart%>')"> 
										<%if(pageStart == nowPage){%>
											<font color="black">[<%=pageStart%>]</font>
										<%}else { %>
											<font color="#a0a0a0">[<%=pageStart%>]</font>
										<%} %>	
									</a> 
								<%} // --- for%> 
								<!-- 다음블럭 이동 기능 (마지막블럭만 없는 기능)--> 
								<%if (totalBlock > nowBlock) {%>
									<a href="javascript:block('<%=nowBlock + 1%>')" class="review-board-aTag">&nbsp;다 음&nbsp;</a> 
								<%}%> 
								<!-- 페이징 및 블럭 End -->
							</td>
						</tr>
						<tr>
							<td colspan="6">
								<div style="text-align:center; margin: 2vw;">
									<form name="searchFrm" class="searchFrm"> 
										<input type="hidden" name="nowPage" value="1"> <!-- 검색 후 초기화 : 보통 검색 결과가 1페이지부터 보여지므로-->
									</form>
								</div>
							</td>
						</tr>
						
						<table>
							<input type="submit" name="btn" value="주문취소" style="border:1px solid #eee; background-color: #eee;" disabled>
						</table>
					<%} // --totalRecord>1 if문 %>
					<tr>
						<!-- '처음으로' 버튼 눌렀을 때 list()함수 호출 -> listFrm submit -> reload = true 전달 -> keyField, keyWord 초기화됨 -->
						<td>
							<a href="javascript:list()" class="review-board-aTag" style="display:block; width:5vw; border:1px solid #eee; background-color: #eee; margin:3vh; transform: translateX(30vw);">
								<button type="button" style="border:none; height:4vh;">처음으로</button>
							</a> 
						</td>
					</tr>
				<%} %>
				</table>
			</form>
			<!-- 게시물 리스트 End -->
				
			<form name="review" method="post" action="../review/reviewForm.jsp">
				<input type="hidden" name="onum">
				<input type="hidden" name="pnum">
				<input type="hidden" name="flag" value="flagForReview">
			</form>	
			
			
			<!-- 단일결제 전달 폼 -->	
			<form name="paymentFrm" method="post" action="../order/directOrderProc.jsp">
				<input type="hidden" name="flag" value="myOrderList">
				<input type="hidden" name="pname">
				<input type="hidden" name="onum">
				<input type="hidden" name="state">
			</form>
			
			<!-- 처음으로 버튼 누르면 list() 메소드를 위해 post방식으로 전달 (초기화)-->
			<form name="listFrm" method="post">
				<input type="hidden" name="reload" value="true"> 
				<input type="hidden" name="nowPage" value="1">
			</form>
	
			<!-- 아래 값들을 GET방식으로 전달하며, 10개 15개 등 아이템 바꿀때마다 재귀호출 -->
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