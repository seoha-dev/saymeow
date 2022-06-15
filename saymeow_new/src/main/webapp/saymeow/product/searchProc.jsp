<%@page contentType="text/html; charset=EUC-KR"%>
<%
	request.setCharacterEncoding("EUC-KR");
	String keyWord = request.getParameter("keyWord");	

	if(keyWord!=null) { %>
		<form  method="post" id="frm" action="productSearch.jsp">
		<input type=hidden name="keyWord" value="<%=keyWord%>">
		</form> 
		<script>
			document.getElementById('frm').submit();
		</script>
<%		
	}
%>