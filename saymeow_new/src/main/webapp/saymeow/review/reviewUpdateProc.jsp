<%@page import="saymeow.UtilMgr"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="rMgr" class="saymeow.ReviewMgr"/>

<%
	// multi에 request 들어가므로 request = null 되어 multi 객체 사용하면 됨
	MultipartRequest multi = new MultipartRequest(request, rMgr.SAVEFOLDER, rMgr.MAXSIZE, 
			rMgr.ENCODING, new DefaultFileRenamePolicy());
	rMgr.updateReview(multi);
%>
<script>
	alert('수정되었습니다!');
	location.href = "readMyReview.jsp";
</script>

