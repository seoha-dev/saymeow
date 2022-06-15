<!-- ���ϱ�� ����� -->
<%@page import="saymeow.UtilMgr"%>
<%@page import="java.util.ArrayList"%>
<%@page import="saymeow.MemberBean"%>
<%@page import="java.util.Vector"%>
<%@page import="saymeow.AdminMemberMgr"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<jsp:useBean id="amMgr" class="saymeow.AdminMemberMgr"/>
<%
request.setCharacterEncoding("EUC-KR");
String sid = request.getParameter("sid"); // �˻��� ȸ���� id
Vector<MemberBean> mvlist = new Vector<MemberBean>();

 // ��üȸ�� ����Ʈ�� �޼ҵ�
if(sid==null || sid.equals("")) {
	mvlist = amMgr.getAllM(); // ��üȸ�� ����Ʈ�� �޼ҵ�
	// System.out.println("[adminMember.jsp] ��ü ȸ�� ���");
}else {
	mvlist = amMgr.searchM(sid); // ȸ��id�� �˻� �޼ҵ�
	// System.out.println("[adminMember.jsp] ȸ�� ID�� �˻�");  
} 
 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
    <title>adminMember</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <link rel='stylesheet' type='text/css' media='screen' href='../css/adminMember.css'>	
<!-- ��Ʈ��Ʈ�� CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<%@ include file="../top2.jsp" %>
<script> // ���� ȸ������ ��� : �ݺ����̹Ƿ� JS�� ���� �������� ���� ���޹޵��� �մϴ�.
function updateOneMember(value){
  	f = document.adminMemberUpdateFrm;
	f.selectedId.value = value;
	f.action="adminMemberUpdate.jsp";
	f.submit(); 
}
</script>
</head>
<body id="adminMember">
	<!-- ���̵�� -->
	<div class="d-flex align-items-start">
		<div class="nav flex-column nav-pills me-3" id="v-pills-tab" role="tablist" aria-orientation="vertical">
			<a href="adminOrder.jsp"><button class="nav-link" id="v-pills-home-tab" data-bs-toggle="pill" data-bs-target="#v-pills-home" type="button" role="tab" aria-controls="v-pills-home" aria-selected="true">�ֹ�����</button></a>
			<a href="adminMember.jsp"><button class="nav-link active" id="v-pills-profile-tab" data-bs-toggle="pill" data-bs-target="#v-pills-profile" type="button" role="tab" aria-controls="v-pills-profile" aria-selected="false">ȸ������</button></a>
			<a href="adminReviewBoard.jsp"><button class="nav-link" id="v-pills-messages-tab" data-bs-toggle="pill" data-bs-target="#v-pills-messages" type="button" role="tab" aria-controls="v-pills-messages" aria-selected="false">�������</button></a>
			<a href="adminProduct.jsp"><button class="nav-link" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">��ǰ����</button></a>
			<a href="sellHistory.jsp"><button class="nav-link" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">�������</button></a>
			<a href="adminSales.jsp"><button class="nav-link" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">�Ǹŵ�����</button></a>
		</div>	

		<!-- ���� -->
		<section class="contents">
		<form name="adminMemberUpdateFrm" method="post">
		<div class="mlist">
		<h3 style="text-align: center; margin: 1.5vw; margin-bottom: 2vw;">ȸ������</h3><br>
		<table style="border: 1px solid #eee;">
						<thead>
							<tr style="background-color:#eee;">
								<th style="width:5vw; border-right:1px solid #FAF0E6; height:6vh;">
									���̵�
								</th>
								<th style="width:10vw; border-right:1px solid #FAF0E6;">
									�̸�
									<input type="image" src="../img/up-arrow-full.png" id="upArrowImg" width="30vw" height="20vh" onClick="sort('upArrowImg'); return false;">
									<input type="image" src="../img/down-arrow-full.png" id="downArrowImg" width="30vw" height="20vh" onClick="sort('downArrowImg'); return false;">
								</th>
								<th style="width:10vw; border-right:1px solid #FAF0E6;">����ó</th>
								<th style="width:15vw; border-right:1px solid #FAF0E6;">�̸���</th>
								<th style="width:5vw; border-right:1px solid #FAF0E6;">ȸ�����</th>
								<th style="width:5vw;">����</th>
							</tr>
						</thead>
						<tbody>
							<%		
								for (int i=0; i < mvlist.size(); i++) {
								MemberBean mbean = mvlist.get(i); 
								
								String mid[] = new String[mvlist.size()];
								
								if(request.getParameter("id")!=null){
									mid[i] = request.getParameter("id");
								}
								String name[] = new String[mvlist.size()];
								if(request.getParameter("name")!=null){
									name[i] = request.getParameter("name");
								}
								String phone[] = new String[mvlist.size()];
								if(request.getParameter("phone")!=null){
									phone[i] = request.getParameter("phone");
								}
								String email[] = new String[mvlist.size()];
								if(request.getParameter("email")!=null){
									email[i] = request.getParameter("email");
								}
								int grade[] = new int[mvlist.size()];
								if(request.getParameter("grade")!=null){
									grade[i] = UtilMgr.parseInt(request, "grade");
								}
								%>
							<tr>
							<input type="hidden" name="mId[]" value="<%=(request.getParameter("id")!=null) ? mid[i] : mbean.getId()%>">
							<%-- <input type="hidden" name="mid" value="<%=mbean.getId()%>"> --%>
								<td><input style="width:5vw; border: 0; border-right:1px solid #FAF0E6;" name="id" value="<%=(request.getParameter("id")!=null) ? mid[i] : mbean.getId()%>" readonly></td>
								<td><input style="width:10vw; border: 0; border-right:1px solid #FAF0E6;" name="name" value="<%=(request.getParameter("name")!=null) ? name[i] : mbean.getName()%>" readonly></td>
								<td><input style="width:10vw; border: 0; border-right:1px solid #FAF0E6;" name="phone" value="<%=(request.getParameter("phone")!=null) ? phone[i] : mbean.getPhone()%>" readonly></td>
								<td><input style="width:15vw; border: 0; border-right:1px solid #FAF0E6;" name="email" value="<%=(request.getParameter("email")!=null) ? email[i] : mbean.getEmail()%>" readonly></td>
								<td>
									<input style="width:5vw; border: 0; border-right:1px solid #FAF0E6;" value="<%=(request.getParameter("grade")!=null) ? grade[i] : mbean.getGrade()%>" name="grade" readonly>
								</td>
								<td>
									<input type="image" src="../img/update.png" name="updateOneMemberBtn<%=i%>" 
									onclick="updateOneMember(this.form.id[<%=i%>].value); return false;" width="20vw;" height="20vh;">
								</td>
								<!-- ���� ���� -->


							</tr>
							<%} // -- for�� ��%>
							<input type="hidden" name="selectedId">
						</tbody>
					</table>
				  	</div>
			</form>

	
		<section class="searchsection">
		<div class="memberSearch">
			<form>
			<br><br>
				<input type="search" class="form-control form-text-input" placeholder="ȸ�� ID�� �˻�" name="sid">
				<button type="submit" style="border: 5px solid #eee; border-radius: 4px; background-color:#eee;">�˻�</button>
				<button onClick="location.href='adminMember.jsp'" style="border: 5px solid #eee; border-radius: 4px; background-color:#eee;">��ü����</button>
			<br><br>
			</form>
		</div>
		</section>
		</section>
</div>
<script>
function sort(id){
	
	if(id=='upArrowImg'){
		f = document.adminMemberUpdateFrm;
		<%
		mvlist = amMgr.getSortMember("up");
		for(int i=0; i<mvlist.size(); i++){
			MemberBean mbean = mvlist.get(i);%>
			f.id[<%=i%>].value = "<%=mbean.getId()%>";
			f.name[<%=i%>].value = "<%=mbean.getName()%>";
			f.phone[<%=i%>].value = "<%=mbean.getPhone()%>";
			f.email[<%=i%>].value = "<%=mbean.getEmail()%>";
			f.grade[<%=i%>].value = <%=mbean.getGrade()%>;

		<%}%>
		
	} else if(id='downArrowImg'){
		f = document.adminMemberUpdateFrm;
		f.action="adminMember.jsp";
		<%
		mvlist = amMgr.getSortMember("down");
		for(int i=0; i<mvlist.size(); i++){
			MemberBean mbean = mvlist.get(i);%>
			f.id[<%=i%>].value = "<%=mbean.getId()%>";
			f.name[<%=i%>].value = "<%=mbean.getName()%>";
			f.phone[<%=i%>].value = "<%=mbean.getPhone()%>";
			f.email[<%=i%>].value = "<%=mbean.getEmail()%>";
			f.grade[<%=i%>].value = <%=mbean.getGrade()%>;

		<%}%>
	} else {
		alert('error');
	}
	
}
</script>
</body>
</html>