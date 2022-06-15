<!-- 로그인 처리페이지 -->
<%@page contentType="text/html;charset=EUC-KR"%>
<jsp:useBean id="mMgr" class="saymeow.MemberMgr" />
<%
	String id = null;
	if(request.getParameter("id")!=null)
		id = request.getParameter("id");
		
	String pwd = null;
	if(request.getParameter("pwd")!=null)
		pwd = request.getParameter("pwd");
	
	String checkbox = null;
	if(request.getParameter("checkbox")!=null)
		checkbox = request.getParameter("checkbox");
	
	
	int mode = mMgr.loginMember(id, pwd);
	
	// userId 이름에 로그인 시도한 id를 담은 쿠키 생성
	Cookie cookie = new Cookie("userId", id); 
	
	if(checkbox!=null){ // 체크박스 체크여부에 따라 쿠키 저장 유무 다름
		// 체크 => 쿠키 저장
		response.addCookie(cookie);
		cookie.setMaxAge(60 * 60); // 쿠키 생명시간 1시간 설정 
	} else {
		// 체크해제 => 쿠키 삭제
		cookie.setMaxAge(0); // 쿠키 생명시간 0 으로 설정하여 브라우저에서 삭제
		response.addCookie(cookie);
	}
	
	if(id!=null && pwd!=null){ // null값 체크
		if(mode==2){ // 비회원 %>
			<script>
				alert('아이디 또는 비밀번호가 정확하지 않습니다!');
				history.back();
			</script>
	<%
		} else if(mode==0 || mode==1){ // 회원 or 관리자
			session.setAttribute("idKey",id); // 로그인 성공한 id를 세션에 저장
			response.sendRedirect("../index.jsp");
		}
	}
	%>

