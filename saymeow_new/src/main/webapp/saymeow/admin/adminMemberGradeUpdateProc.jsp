<!-- �������� ȸ�� ��� ���� ó�� ������ -->
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%> 
<jsp:useBean id="adMgr" class="saymeow.AdminMemberMgr"/>
<%
// �������ǰ�� ȸ�������ϸ� ������ ���̵� �����Ƿ�, ��� ���� ������ ���� �޾ƿ´�. -> �������� �޾ƿ� mid�� ȸ������ ����� ��������
ArrayList<String> gradeArrList = new ArrayList<String>();
ArrayList<String> idArrList = new ArrayList<String>();
for(int i=0; i<request.getParameterValues("grade[]").length; i++){
	gradeArrList.add(i, request.getParameterValues("grade[]")[i]);
	idArrList.add(i, request.getParameterValues("mId[]")[i]);
	adMgr.updateMemberGrade(Integer.parseInt(gradeArrList.get(i)),idArrList.get(i));
}
%>
<script>
alert("Grade update was successful!");
location.href="adminMember.jsp";
</script> 