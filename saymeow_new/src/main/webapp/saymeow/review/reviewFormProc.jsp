<%@page import="saymeow.ReviewMgr"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="rMgr" class="saymeow.ReviewMgr"/>
<%
	int pnum = Integer.parseInt(request.getParameter("pnum"));
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
		
		if(rMgr.insertReview(request)){%>
			<script>
				alert('succeded');
				location.href="../member/readMyReview.jsp";
			</script>
			<%} else if(!rMgr.insertReview(request)){%>
				<script>
					alert('failed');
					history.back();
				</script>
			<%}%>
	
