<%@page import="saymeow.MemberMgr"%>
<%@page import="saymeow.MemberBean"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="mMgr" class="saymeow.MemberMgr" />
<%
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
		MemberBean mbean = mMgr.getMember(id);
		if(pwd.equals(mbean.getPwd())){
			mMgr.deleteMember(id);
			session.invalidate();
			response.sendRedirect("login.jsp");
			return;
		}else{
			%>
			<script>
			alert("비밀번호가 일치하지 않습니다.");
			history.back();
			</script>
		<%}%>