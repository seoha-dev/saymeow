<!-- ������ ��� �� �� ���� ���� -->
<%@page import="saymeow.UtilMgr"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:useBean id="cMgr" class="saymeow.RCommentMgr"/>
<%
	int rcNum = UtilMgr.parseInt(request, "rcNum"); // rcNum ���޹ޱ�
	cMgr.deleteRComment(rcNum);
	
	String flag = null;
	if(request.getParameter("flag")!=null){
		flag = request.getParameter("flag");
	}
	
	int pnum = 0;
	if(UtilMgr.parseInt(request, "pnum")!=0){
		pnum = UtilMgr.parseInt(request, "pnum");
	}
	
	if(flag.equals("productDetail") && flag!=null){ // ��ǰ�󼼿��� ��� ������ ���%>
			System.out.println("�ƴ�");
		<script>
			alert('����� �����Ǿ����ϴ�!');
			location.href = "../product/productDetail.jsp?pnum="+<%=pnum%>; // ../ : ������� �̵�
		</script>
	<%} else if(flag==null || flag.trim().equals("")) { // �׿ܿ��� ��� ������ ���%>
		System.out.println("null");
		<script>
			alert('����� �����Ǿ����ϴ�!');
			location.href = "adminReviewBoard.jsp";
		</script>
	<%}%>
