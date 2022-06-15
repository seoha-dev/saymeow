<%@page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="EUC-KR"> 
<link rel="stylesheet" href="../css/styleTW.css">
<!-- 부트스트랩 CSS -->	
<link						
href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"						
rel="stylesheet"						
integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"						
crossorigin="anonymous">
<%@ include file="../top2.jsp"%>
<script>
	function pw_search(){
		f = document.findPwdFrm;
		
	 	if (f.id.value.length < 1) {
			  alert("아이디를 입력해 주세요.");
			  return;
		}
		
		if (f.email.value.length < 1) {
				alert("이메일 주소를 입력해 주세요.");
				return;
		}
		
		if(!f.email.value.includes('@')) {
			alert("'@' 를 포함한 이메일 주소를 입력해주세요.");
			return;
		}
		
		f.submit(); 
	}
</script>
</head>
<body id="findPwdBd">
	<form name="findPwdFrm" method="POST" class="findPwdFrm" action="mail/mailSendProc.jsp">
		<h3 class="subject">본인확인 이메일로 인증</h3>
		<table class="findPwdTbl">
			<tr>
				<td>
					<section class="findPwdSec">
						<div class="idDiv">
							<label class="idLb">아이디</label>
							<input type="text" size="25" name="id" class="idTf" placeholder="아이디를 입력하세요.">
						</div>
						<div class="emailDiv">
							<label class="emailLb">이메일 주소</label>
							<input type="text" size="25" name="email" class="emailTf" placeholder="example@saymeow.com">
						</div>
					</section>
				</td>
			</tr>
			<tr>
				<td>
					<input type="button" class="findBtn" name="enter" value="인증번호 발송"  onClick="pw_search()">
		 		</td>
		 	</tr>
		 </table>
	</form>
	<a href="login.jsp" class="back">&lt;이전으로</a>
</body> 
</html>