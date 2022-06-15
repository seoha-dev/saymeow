<%@page import="saymeow.UtilMgr"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="rMgr" class="saymeow.ReviewMgr"/>
<jsp:useBean id="cMgr" class="saymeow.RCommentMgr"/>
<%
	int pnum = UtilMgr.parseInt(request, "pnum");
	String keyField = request.getParameter("keyField");
	String keyWord = request.getParameter("keyWord");
	int nowPage = UtilMgr.parseInt(request, "nowPage");
	int rnum = UtilMgr.parseInt(request, "rnum");
	String filename = request.getParameter("filename");
	rMgr.deleteReview(rnum, filename);
	cMgr.deleteAllRComment(rnum);
%>

<script>
	alert('Review deleted successfully!');
	location.href = "../product/productDetail.jsp?keyField=<%=keyField%>&keyWord=<%=keyWord%>&nowPage=<%=nowPage%>&pnum=<%=pnum%>";
</script>