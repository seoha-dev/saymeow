<!-- 취합완료 -->

<!-- 로그아웃 처리페이지 -->
<%@page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
	session.invalidate(); // 세션 유효하지않게 처리
%>
<script>
    alert("로그아웃 되었습니다.");
	location.href = "../index.jsp?id=null";
</script>