<%@page import="saymeow.UtilMgr"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="rMgr" class="saymeow.ReviewMgr"/>
<jsp:useBean id="cMgr" class="saymeow.RCommentMgr"/>
<%
	int rnum = UtilMgr.parseInt(request, "rnum");
	String filename = request.getParameter("filename");
	rMgr.deleteReview(rnum, filename);
	cMgr.deleteAllRComment(rnum);
%>

<script>
	alert('Review deleted successfully!');
	location.href="adminReviewBoard.jsp";
</script>