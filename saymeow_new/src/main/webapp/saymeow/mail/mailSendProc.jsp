<!-- mailSend.jsp���� �޾ƿ� id�� email�� DB��ȸ -->
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="mail" class="saymeow.MailSend"/>
<%
	String id = request.getParameter("id");
	String email = request.getParameter("email");
	boolean result = mail.sendEmail(id, email);
	String msg = "���� �����Ͽ����ϴ�. �������� ���۽��д� �����ڿ��� ���� �ٶ��ϴ�.";
	if(result) 
		msg = email + " �� �̸��� �ּҷ� " + id + " ���� ��й�ȣ�� ���۵Ǿ����ϴ�.";
%>
<script>
	alert("<%=msg%>");
	location.href="../member/findPw.jsp";
</script>