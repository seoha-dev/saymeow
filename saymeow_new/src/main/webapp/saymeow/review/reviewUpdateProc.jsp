<%@page import="saymeow.UtilMgr"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="rMgr" class="saymeow.ReviewMgr"/>

<%
	// multi�� request ���Ƿ� request = null �Ǿ� multi ��ü ����ϸ� ��
	MultipartRequest multi = new MultipartRequest(request, rMgr.SAVEFOLDER, rMgr.MAXSIZE, 
			rMgr.ENCODING, new DefaultFileRenamePolicy());
	rMgr.updateReview(multi);
%>
<script>
	alert('�����Ǿ����ϴ�!');
	location.href = "readMyReview.jsp";
</script>

