<%@page import="saymeow.ProductBean"%>
<%@page import="saymeow.UtilMgr"%>
<%@page import="saymeow.OrderBean"%>
<%@page import="java.util.Vector"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="aMgr" class="saymeow.AdminMgr"/>
<jsp:useBean id="pMgr" class="saymeow.ProductMgr"/>

<%
	int sellTotal = 0;
	String state = "1";
	int month = 0;
	int year = 0;
	
    if(request.getParameter("year")!=null){
    	year = UtilMgr.parseInt(request, "year");
    }
    if(request.getParameter("month")!=null){
    	month = UtilMgr.parseInt(request, "month");
    }
    int getPrice = 0; //�缳���ϱ� (��ǰ ����)
    
%>
<!DOCTYPE html>
<html>
<head>
<title>Sell History</title>
<script type="text/javascript">
function selectYFn(year){
	document.readFrm.year.value=year;
	document.readFrm.submit();
}
function selectMFn(month){
	if(document.readFrm.year.value == 0){
		alert('�⵵�� �������ּ���!');
		document.readFrm.month.value=0;
		document.readFrm.submit();
	} else {
	document.readFrm.month.value=month;
	document.readFrm.submit();
	}
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
<!-- ���̵�� -->
<div class="d-flex align-items-start">
	<div class="nav flex-column nav-pills me-3" id="v-pills-tab" role="tablist" aria-orientation="vertical">
		<a href="adminOrder.jsp"><button class="nav-link" id="v-pills-home-tab" data-bs-toggle="pill" data-bs-target="#v-pills-home" type="button" role="tab" aria-controls="v-pills-home" aria-selected="true">�ֹ�����</button></a>
		<a href="adminMember.jsp"><button class="nav-link" id="v-pills-profile-tab" data-bs-toggle="pill" data-bs-target="#v-pills-profile" type="button" role="tab" aria-controls="v-pills-profile" aria-selected="false">ȸ������</button></a>
		<a href="adminReviewBoard.jsp"><button class="nav-link" id="v-pills-messages-tab" data-bs-toggle="pill" data-bs-target="#v-pills-messages" type="button" role="tab" aria-controls="v-pills-messages" aria-selected="false">�������</button></a>
		<a href="adminProduct.jsp"><button class="nav-link" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">��ǰ����</button></a>
		<a href="sellHistory.jsp"><button class="nav-link active" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">�������</button></a>
		<a href="adminSales.jsp"><button class="nav-link" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">�Ǹŵ�����</button></a>
	</div>
	<!-- ���� -->
	<div class="tab-content" id="v-pills-tabContent" align="center" style="margin:0 auto;">
		<section class="contents">
			<h3 style="text-align: center; margin: 1.5vw; margin-bottom: 2vw;">�������</h3>
			<div>
				<form name="sFrm">
					<select name="year" onchange="selectYFn(this.form.year.value)" class="form-select" style="display:inline; width:15vw;">
						<option value="2022">2022��</option>
						<option value="0" selected>��ü</option> 
					</select>
					<select name="month" onchange="selectMFn(this.form.month.value)" class="form-select" style="display:inline; width:15vw;">
						<%for(int i=1;i<13;i++){%>
							<option value="<%=i%>"><%=i%>��</option>
						<%}%>
						<option value="0" selected>��ü</option> 
					</select>
				</form>
				<script>
					document.sFrm.year.value=<%=year%>;
					document.sFrm.month.value=<%=month%>;
				</script>
			</div>
			<div style="margin-top:2vh;">
				<table class="table" style="border: 1px solid #eee;">
						<tr class="table-column" style="height:6vh; vertical-align:middle; background-color:#eee; text-align:center;">
							<th style="border-right:0.3px solid #FAF0E6;">��ǰ ��ȣ</th>
							<th style="border-right:0.3px solid #FAF0E6;">��ǰ��</th>
							<th style="border-right:0.3px solid #FAF0E6;">�Ǹ� ����</th>
							<th>�Ǹ� �ݾ�</th>
						</tr>
					<%if(year==0&&month==0){
						Vector<OrderBean> vlist = aMgr.showAllOrder();
						for(int i=0;i<vlist.size();i++){
							OrderBean order = vlist.get(i);
							int pnum = order.getPnum();
							String pname = order.getPname();
							int qty = order.getQty();
							getPrice = pMgr.getPrice(pnum);
							int total = qty*getPrice;
							String UTotal = UtilMgr.monFormat(total);
							sellTotal += total;
					%>
					<tr>
						<td style="border-right:0.3px solid #FAF0E6;"><%=pnum%></td>
						<td style="border-right:0.3px solid #FAF0E6;"><%=pname%></td>
						<td style="border-right:0.3px solid #FAF0E6;"><%=qty%></td>
						<td><%=UTotal%></td>
					</tr>
					<%	}
					}else if(year!=0&&month==0){
						Vector<OrderBean> vlist = aMgr.selectYRegdate(year);
						for(int i=0;i<vlist.size();i++){
							OrderBean order = vlist.get(i);
							int pnum = order.getPnum();
							String pname = order.getPname();
							int qty = order.getQty();
							getPrice = pMgr.getPrice(pnum);
							int total = qty*getPrice;
							String UTotal = UtilMgr.monFormat(total);
							sellTotal += total;
					%>
					<tr>
						<td style="border-right:0.3px solid #FAF0E6;"><%=pnum%></td>
						<td style="border-right:0.3px solid #FAF0E6;"><%=pname%></td>
						<td style="border-right:0.3px solid #FAF0E6;"><%=qty%></td>
						<td><%=UTotal%></td>
					</tr>
					<%	}
					}else if(year!=0&&month!=0){
						Vector<OrderBean> vlist = aMgr.selectYMRegdate(year, month);
						if(vlist.size()!=0){
							for(int i=0;i<vlist.size();i++){
								OrderBean order = vlist.get(i);
								int pnum = order.getPnum();
								String pname = order.getPname();
								int qty = order.getQty();
								getPrice = pMgr.getPrice(pnum);
								int total = qty*getPrice;
								String UTotal = UtilMgr.monFormat(total);
								sellTotal += total;
					%>
					<tr>
						<td style="border-right:0.3px solid #FAF0E6;"><%=pnum%></td>
						<td style="border-right:0.3px solid #FAF0E6;"><%=pname%></td>
						<td style="border-right:0.3px solid #FAF0E6;"><%=qty%></td>
						<td style="border-right:0.3px solid #FAF0E6;"><%=UTotal%></td>
					</tr>
					<%		}
						}else if(vlist.size()==0){%>
					<tr>
						<td colspan="4">�Ǹ� ������ �����ϴ�</td>
					</tr>
					<%	}
					}%>
				</table>
				<h3>�� �Ǹűݾ��� <span style="color:red;"><%=UtilMgr.monFormat(sellTotal)%></span>�� �Դϴ�.</h3>
			</div>
			<form name="readFrm">
				<input type="hidden" name="year" value="<%=year%>">
				<input type="hidden" name="month" value="<%=month%>"> 
			</form>
		</section>
	</div>
</div>
</body>
</html>