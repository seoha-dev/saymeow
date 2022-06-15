<!-- mailSend.jsp에서 받아온 id와 email를 DB조회 -->
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="mail" class="saymeow.MailSend"/>
<%
	String id = request.getParameter("id");
	String email = request.getParameter("email");
	boolean result = mail.sendEmail(id, email);
	String msg = "전송 실패하였습니다. 지속적인 전송실패는 관리자에게 문의 바랍니다.";
	if(result) 
		msg = email + " 본 이메일 주소로 " + id + " 님의 비밀번호가 전송되었습니다.";
%>
<script>
	alert("<%=msg%>");
	location.href="../member/findPw.jsp";
</script>