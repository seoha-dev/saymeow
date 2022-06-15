<%@page import="saymeow.UtilMgr"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:useBean id="cMgr" class="saymeow.RCommentMgr"/>
<jsp:useBean id="rcBean" class="saymeow.RCommentBean"/>
<jsp:setProperty property="*" name="rcBean"/>
<%
	String comment = null; // 댓글내용
	if(request.getParameter("comment")!=null){
		comment = request.getParameter("comment");
	}
	
	String flag = null;
	if(request.getParameter("flag")!=null){
		flag = request.getParameter("flag");
	}
	
	int pnum = 0;
	if(UtilMgr.parseInt(request, "pnum")!=0){
		pnum = UtilMgr.parseInt(request, "pnum");
	}
%>	
	<%if(flag!=null&&flag.equals("productDetail")){ // 상품상세에서 댓글 단경우%>
		<%if(comment.trim().equals("")||comment==null){%>
			<script>
				alert('(공백제외) 1자 이상 댓글을 입력해주세요.');
				history.back();
			</script>
		<%} else {%>
			<script>
				alert('댓글을 추가했습니다.');
				location.href = "../product/productDetail.jsp?pnum="+<%=pnum%>; // ../ : 이전경로 이동
			</script>
			<%
			cMgr.insertRComment(rcBean); // 댓글 추가 메소드
		}
			%>	
	<%} else { // 상품상세 이외(리뷰목록)에서 댓글 단 경우%>
		<%if(comment.trim().equals("")||comment==null){%>
			<script>
				alert('(공백제외) 1자 이상 댓글을 입력해주세요.');
				history.back();
			</script>
		<%} else {%>
			<script>
				alert('댓글을 추가했습니다.');
				location.href = "adminReviewBoard.jsp" // ../ : 이전경로 이동
			</script>
			<%
			cMgr.insertRComment(rcBean); // 댓글 추가 메소드
		}
			%>	
	<%}%>