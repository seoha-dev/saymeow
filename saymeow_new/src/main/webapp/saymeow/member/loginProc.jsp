<!-- �α��� ó�������� -->
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
	
	// userId �̸��� �α��� �õ��� id�� ���� ��Ű ����
	Cookie cookie = new Cookie("userId", id); 
	
	if(checkbox!=null){ // üũ�ڽ� üũ���ο� ���� ��Ű ���� ���� �ٸ�
		// üũ => ��Ű ����
		response.addCookie(cookie);
		cookie.setMaxAge(60 * 60); // ��Ű ����ð� 1�ð� ���� 
	} else {
		// üũ���� => ��Ű ����
		cookie.setMaxAge(0); // ��Ű ����ð� 0 ���� �����Ͽ� ���������� ����
		response.addCookie(cookie);
	}
	
	if(id!=null && pwd!=null){ // null�� üũ
		if(mode==2){ // ��ȸ�� %>
			<script>
				alert('���̵� �Ǵ� ��й�ȣ�� ��Ȯ���� �ʽ��ϴ�!');
				history.back();
			</script>
	<%
		} else if(mode==0 || mode==1){ // ȸ�� or ������
			session.setAttribute("idKey",id); // �α��� ������ id�� ���ǿ� ����
			response.sendRedirect("../index.jsp");
		}
	}
	%>

