<!-- 관리자의 회원정보수정 처리페이지 -->
<!-- 취합완료했으나 회원가입 시 고양이 정보 입력안했으면 에러남. -->
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%> 
<jsp:useBean id="mMgr" class="saymeow.MemberMgr" />
<jsp:useBean id="mBean" class="saymeow.MemberBean" /> 
<jsp:setProperty name="mBean" property="*" />

<%boolean flag = mMgr.updateMember(mBean);
if(flag){%>
	<script>
		alert("성공적으로 수정하였습니다");
		location.href="adminMember.jsp";
	</script>
<%}else{%>
	<script>
		alert("수정도중 에러가 발생하였습니다.");
		history.back();
	</script>
<%}%>
