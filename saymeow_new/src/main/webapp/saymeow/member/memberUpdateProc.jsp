<%@ page contentType="text/html;charset=EUC-KR"%>
<%request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="mMgr" class="saymeow.MemberMgr" />
<jsp:useBean id="mBean" class="saymeow.MemberBean" /> 
<jsp:setProperty name="mBean" property="*" />
<%boolean flag = mMgr.updateMember(mBean);
if(flag){%>
	<script>
		alert("���������� �����Ͽ����ϴ�");
		location.href="index.jsp";
	</script>
<%}else{%>
	<script>
		alert("�������� ������ �߻��Ͽ����ϴ�.");
		history.back();
	</script>
<%}%>


