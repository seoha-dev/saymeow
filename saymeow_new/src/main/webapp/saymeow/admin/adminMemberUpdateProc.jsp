<!-- �������� ȸ���������� ó�������� -->
<!-- ���տϷ������� ȸ������ �� ����� ���� �Է¾������� ������. -->
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%> 
<jsp:useBean id="mMgr" class="saymeow.MemberMgr" />
<jsp:useBean id="mBean" class="saymeow.MemberBean" /> 
<jsp:setProperty name="mBean" property="*" />

<%boolean flag = mMgr.updateMember(mBean);
if(flag){%>
	<script>
		alert("���������� �����Ͽ����ϴ�");
		location.href="adminMember.jsp";
	</script>
<%}else{%>
	<script>
		alert("�������� ������ �߻��Ͽ����ϴ�.");
		history.back();
	</script>
<%}%>
