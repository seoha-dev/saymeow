<%@page import="saymeow.UtilMgr"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:useBean id="cMgr" class="saymeow.RCommentMgr"/>
<jsp:useBean id="rcBean" class="saymeow.RCommentBean"/>
<jsp:setProperty property="*" name="rcBean"/>
<%
	String comment = null; // ��۳���
	if(request.getParameter("comment")!=null){
		comment = request.getParameter("comment");
	}
	
	String flag = null;
	if(request.getParameter("flag")!=null){
		flag = request.getParameter("flag");
	}
	
	int pnum = 0;
	if(UtilMgr.parseInt(request, "pnum")!=0){
		pnum = UtilMgr.parseInt(request, "pnum");
	}
%>	
	<%if(flag!=null&&flag.equals("productDetail")){ // ��ǰ�󼼿��� ��� �ܰ��%>
		<%if(comment.trim().equals("")||comment==null){%>
			<script>
				alert('(��������) 1�� �̻� ����� �Է����ּ���.');
				history.back();
			</script>
		<%} else {%>
			<script>
				alert('����� �߰��߽��ϴ�.');
				location.href = "../product/productDetail.jsp?pnum="+<%=pnum%>; // ../ : ������� �̵�
			</script>
			<%
			cMgr.insertRComment(rcBean); // ��� �߰� �޼ҵ�
		}
			%>	
	<%} else { // ��ǰ�� �̿�(������)���� ��� �� ���%>
		<%if(comment.trim().equals("")||comment==null){%>
			<script>
				alert('(��������) 1�� �̻� ����� �Է����ּ���.');
				history.back();
			</script>
		<%} else {%>
			<script>
				alert('����� �߰��߽��ϴ�.');
				location.href = "adminReviewBoard.jsp" // ../ : ������� �̵�
			</script>
			<%
			cMgr.insertRComment(rcBean); // ��� �߰� �޼ҵ�
		}
			%>	
	<%}%>