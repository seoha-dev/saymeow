<!-- 관리자 댓글 한 개 단위 삭제 -->
<%@page import="saymeow.UtilMgr"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:useBean id="cMgr" class="saymeow.RCommentMgr"/>
<%
	int rcNum = UtilMgr.parseInt(request, "rcNum"); // rcNum 전달받기
	cMgr.deleteRComment(rcNum);
	
	String flag = null;
	if(request.getParameter("flag")!=null){
		flag = request.getParameter("flag");
	}
	
	int pnum = 0;
	if(UtilMgr.parseInt(request, "pnum")!=0){
		pnum = UtilMgr.parseInt(request, "pnum");
	}
	
	if(flag.equals("productDetail") && flag!=null){ // 상품상세에서 댓글 삭제한 경우%>
			System.out.println("아님");
		<script>
			alert('댓글이 삭제되었습니다!');
			location.href = "../product/productDetail.jsp?pnum="+<%=pnum%>; // ../ : 이전경로 이동
		</script>
	<%} else if(flag==null || flag.trim().equals("")) { // 그외에서 댓글 삭제한 경우%>
		System.out.println("null");
		<script>
			alert('댓글이 삭제되었습니다!');
			location.href = "adminReviewBoard.jsp";
		</script>
	<%}%>
