<%@page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="EUC-KR">
<link rel="stylesheet" href="../css/styleTW.css">
<!-- ��Ʈ��Ʈ�� CSS -->						
<link						
href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"						
rel="stylesheet"						
integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"						
crossorigin="anonymous">
<%@ include file="../top2.jsp"%>
<script>
	function id_search() { 
	 	f = document.findIdFrm;
	
	 	if (f.name.value.length < 1) {
		  alert("�̸��� �Է��� �ּ���.");
		  return;
		 }
	
		if (f.email.value.length < 1) {
			  alert("�̸��� �ּҸ� �Է��� �ּ���.");
			  return;
		 }
		 
		if(!f.email.value.includes('@')) {
			 alert("'@' �� ������ �̸��� �ּҸ� �Է����ּ���.");
			 return;
		 }
		 
	 	f.submit();  
	 }
	
	// ���̵� �� �̸��� value�� .proc�� �����ϴ� ���
	function submitForMailSend(){
		document.mailSendFrm.submit();
	}
</script>
</head>
<body id="findIdBd"> 
	<form name="findIdFrm" method="POST" class="findIdFrm" action="findIdResult.jsp">
		<h3 class="subject">����Ȯ�� �̸��Ϸ� ����</h3>
		<table class="findIdTbl">
			<tr>
				<td>
					<section class="findIdSec">
						<div class="nameDiv">
							<label class="nameLb">�̸�</label>
							<input type="text" size="25" name="name" class="nameTf" placeholder="ȫ�浿">
						</div>
						<div class="emailDiv">
							<label class="emailLb">�̸��� �ּ�</label>
							<input type="text" size="25" name="email" class="emailTf" placeholder="example@saymeow.com">
						</div>
					</section>
				</td>
			</tr>
			<tr>
				<td>
					<input type="button" class="findBtn" name="enter" value="���̵� ã��"  onClick="id_search()">
		 		</td>
		 	</tr>
		 </table>
	 </form>
	 <a href="login.jsp" class="back">&lt;��������</a>
</body> 
</html>