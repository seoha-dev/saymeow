<!-- 관리자의 회원 등급 수정 처리 페이지 -->
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%> 
<jsp:useBean id="adMgr" class="saymeow.AdminMemberMgr"/>
<%
// 관리자의경우 회원수정하면 관리자 아이디가 들어가지므로, 멤버 관련 정보를 따로 받아온다. -> 동적으로 받아온 mid로 회원정보 빈즈로 가져오기
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