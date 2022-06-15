<!-- ���տϷ� -->
<%@page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<jsp:useBean id="mBean" class="saymeow.MemberBean"/>
<jsp:setProperty name="mBean" property="*"/>

<html>
<head>
<head>
<meta charset="EUC-KR">
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <title>ȸ������</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <!-- ��Ʈ��Ʈ�� CSS -->
	<link
		href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
		rel="stylesheet"
		integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
		crossorigin="anonymous"> 
<link rel='stylesheet' type='text/css' media='screen' href='../css/member.css'>
<%@ include file="../top2.jsp"%>
</head>

<script src="../script.js">
</script>

<body>
	<section class="membersection">
	<div class="title" align="center">
	<h4><b>ȸ������</b></h4>
	</div>
	<form name="joinFrm" method="post" action="memberProc2.jsp">
	<fieldset>
	<br><br><br>
	<legend>ȸ�� ����</legend>
	<ul class="memberinfo">
	<li>
		<label for="id" class="lb">ȸ�� ���̵�</label>
		<input name="id" class="id" required autofocus>
		<input type="button" class="btn1" value="�ߺ�Ȯ��" onClick="idCheck(this.form.id.value)"/>
	</li>
	<li>
		<label for="pwd" class="lb">��й�ȣ</label>
		<input name="pwd" type="password" required autofocus>
	</li>	
	<li>
		<label for="repwd" class="lb">��й�ȣ Ȯ��</label>
		<input name="repwd" type="password" required autofocus>
	</li>	
	<li>
		<label for="name" class="lb">ȸ�� �̸�</label>
		<input name="name" required autofocus>
	</li>	
	<li>
		<label for="birthday" class="lb">ȸ�� �������</label>
		<select name="year" class="year">
	<% // ����
		for (int i = 1960; i <= 2010; i++) { %>
		<option value="<%=i%>">
		<%=i%>
		</option>
	<%} //-- for %> 
		</select>
		<select name="mon">
	<% // ����
		for (int i = 1; i <= 12; i++) { %>
		<option value="<%=i%>">
		<%=i%>
		</option>
	<%} //-- for %>
		</select>
		<select name="day">
	<% // ����
		for (int j = 1; j <= 31; j++) { %>
		<option value="<%=j%>">
		<%=j%>
		</option>
	<%} //-- for %>
		</select><br>
	</li>	
	<li>
		<label for="phone" class="lb">ȸ�� ����ó</label>
		<input name="phone" required autofocus>
	</li>
	<li>
		<label for="email" class="lb">ȸ�� �̸���</label>
		<input name="email" required autofocus>
	</li>
	<li>
		<label for="address" class="lb">ȸ�� �ּ�</label>
		<input name="address" required autofocus>
	</li>	
	</ul>
	<legend>����� ����</legend>
	<ul class="catinfo">
	<li>
		<label for="petName" class="lb">����� �̸�</label>
		<input name="petName" required autofocus>
	</li>
	<li>
		<label for="petAge" class="lb">����� �������</label>
		<select name="p_year" class="year">
	<% // ����
		for (int i = 2000; i <= 2022; i++) { %>
		<option value="<%=i%>">
		<%=i%>
		</option>
	<%} //-- for %> 
		</select>
		<select name="p_mon">
	<% // ����
		for (int k = 1; k <= 12; k++) { %>
		<option value="<%=k%>">
		<%=k%>
		</option>
	<%} //-- for %>
		</select>
		<select name="p_day">
	<% // ����
		for (int l = 1; l <= 31; l++) { %>
		<option value="<%=l%>">
		<%=l%>
		</option>
	<%} //-- for %>
		</select><br>
	</li>
	<li>
	<label for="petGender" class="lb">����� ����</label>
	��<input type="radio" name="petGender" class="radio" value="1" checked>
	��<input type="radio" name="petGender" class="radio" value="0">
	</li>
	<li>
	<label for="petBreed" class="lb">����� ǰ��</label>
	<input name="petBreed" required autofocus>

	</li>
	</ul>
		<br><br><br>
		<input type="button" class="btn1" onclick="inputCheck()" value="ȸ������"/>
		<br><br><br>
	</fieldset>
	</form>
	</section>
	
	<!-- ��Ʈ��Ʈ�� JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous">
	</script>

</body>
</html>

