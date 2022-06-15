
function loginCheck(){
	if(document.login.id.value==""){
	 	alert("아이디를 입력해 주세요.");
		document.login.id.focus();
		return;
	}
	if(document.login.pwd.value==""){
		alert("비밀번호를 입력해 주세요.");
		document.login.pwd.focus();
		return;
	}
	document.login.submit(); 
}

function memberReg(){
	document.location="member.jsp";
}

function inputCheck(){
	if(document.joinFrm.id.value==""){
		alert("아이디를 입력해 주세요.");
		document.joinFrm.id.focus();
		return;
	}
	if(document.joinFrm.pwd.value==""){
		alert("비밀번호를 입력해 주세요.");
		document.joinFrm.pwd.focus();
		return;
	}
	if(document.joinFrm.repwd.value==""){
		alert("비밀번호를 확인해 주세요");
		document.joinFrm.repwd.focus();
		return;
	}
	if(document.joinFrm.pwd.value != document.joinFrm.repwd.value){
		alert("비밀번호가 일치하지 않습니다.");
		document.joinFrm.repwd.focus();
		return;
	}
	if(document.joinFrm.name.value==""){
		alert("이름을 입력해 주세요.");
		document.joinFrm.name.focus();
		return;
	}
	if(document.joinFrm.phone.value==""){
		alert("연락처를 입력해주세요.");
		document.joinFrm.phone.focus();
		return;
	}	
	
	if(document.joinFrm.email.value==""){
		alert("이메일을 입력해 주세요.");
		document.joinFrm.email.focus();
		return;
	}
		if(document.joinFrm.address.value==""){
		alert("주소를 입력해 주세요");
		document.joinFrm.address.focus();
		return;
	}
	if(document.joinFrm.petName.value==""){
		alert("고양이 이름을 입력해 주세요.");
		document.joinFrm.petName.focus();
		return;
	}
	
	if(document.joinFrm.petGender.value==""){
		alert("고양이 성별을 입력해 주세요.");
		document.joinFrm.petGender.focus();
		return;
	}
	if(document.joinFrm.petBreed.value==""){
		alert("고양이 종을 입력해 주세요.");
		document.joinFrm.petBreed.focus();
		return;
	}
    var str=document.joinFrm.email.value;	   
    var atPos = str.indexOf('@');
    var atLastPos = str.lastIndexOf('@');
    var dotPos = str.indexOf('.'); 
    var spacePos = str.indexOf(' ');
    var commaPos = str.indexOf(',');
    var eMailSize = str.length;
    if (atPos > 1 && atPos == atLastPos && 
	   dotPos > 3 && spacePos == -1 && commaPos == -1 
	   && atPos + 1 < dotPos && dotPos + 1 < eMailSize);
    else {
            alert('E-mail주소 형식이 잘못되었습니다.\n\r다시 입력해 주세요!');
	      document.joinFrm.email.focus();
		  return;
    }

	document.joinFrm.submit();
}


function idCheck(id){
	if(id == ""){
		alert("아이디를 입력해 주세요.");
		document.joinFrm.id.focus();
	}else{
		url="idCheck.jsp?id=" + id;
		window.open(url,"post","width=300,height=150");
	}
}

function id_search() { 
	 	var frm = document.idfindscreen;

	 	if (frm.name.value.length < 1) {
		  alert("이름을 입력해 주세요.");
		  return;
		 }

		 if (frm.phone.value.length != 11) {
			  alert("전화번호를 정확하게 입력해 주세요.");
			  return;
		 }

	 frm.method = "post";
	 frm.action = "findIdResult.jsp"; //결과창출력
	 frm.submit();  
	 }
	  function pw_search(){

  var frm=document.pwfindscreen;

  if(frm.mid.value.length<1){
   alert("ID를 입력해 주세요.");
   return;
  }

   if (frm.phone.value.length != 11) {
			  alert("전화번호를 정확하게 입력해 주세요.");
			  return;
		 }
	
  frm.method="post";
  frm.action="findPwResult.jsp"; //결과창 출력
  frm.submit(); 
  }


function win_close(){
	self.close();
}

function pwdCheck(){
	if(document.joinFrm.pwd.value != document.joinFrm.repwd.value){
		alert("비밀번호가 일치하지 않습니다.");
		document.joinFrm.repwd.focus();
		return;
	}
	
	document.joinFrm.submit();
}

