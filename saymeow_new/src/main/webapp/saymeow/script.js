
function loginCheck(){
	if(document.login.id.value==""){
	 	alert("���̵� �Է��� �ּ���.");
		document.login.id.focus();
		return;
	}
	if(document.login.pwd.value==""){
		alert("��й�ȣ�� �Է��� �ּ���.");
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
		alert("���̵� �Է��� �ּ���.");
		document.joinFrm.id.focus();
		return;
	}
	if(document.joinFrm.pwd.value==""){
		alert("��й�ȣ�� �Է��� �ּ���.");
		document.joinFrm.pwd.focus();
		return;
	}
	if(document.joinFrm.repwd.value==""){
		alert("��й�ȣ�� Ȯ���� �ּ���");
		document.joinFrm.repwd.focus();
		return;
	}
	if(document.joinFrm.pwd.value != document.joinFrm.repwd.value){
		alert("��й�ȣ�� ��ġ���� �ʽ��ϴ�.");
		document.joinFrm.repwd.focus();
		return;
	}
	if(document.joinFrm.name.value==""){
		alert("�̸��� �Է��� �ּ���.");
		document.joinFrm.name.focus();
		return;
	}
	if(document.joinFrm.phone.value==""){
		alert("����ó�� �Է����ּ���.");
		document.joinFrm.phone.focus();
		return;
	}	
	
	if(document.joinFrm.email.value==""){
		alert("�̸����� �Է��� �ּ���.");
		document.joinFrm.email.focus();
		return;
	}
		if(document.joinFrm.address.value==""){
		alert("�ּҸ� �Է��� �ּ���");
		document.joinFrm.address.focus();
		return;
	}
	if(document.joinFrm.petName.value==""){
		alert("����� �̸��� �Է��� �ּ���.");
		document.joinFrm.petName.focus();
		return;
	}
	
	if(document.joinFrm.petGender.value==""){
		alert("����� ������ �Է��� �ּ���.");
		document.joinFrm.petGender.focus();
		return;
	}
	if(document.joinFrm.petBreed.value==""){
		alert("����� ���� �Է��� �ּ���.");
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
            alert('E-mail�ּ� ������ �߸��Ǿ����ϴ�.\n\r�ٽ� �Է��� �ּ���!');
	      document.joinFrm.email.focus();
		  return;
    }

	document.joinFrm.submit();
}


function idCheck(id){
	if(id == ""){
		alert("���̵� �Է��� �ּ���.");
		document.joinFrm.id.focus();
	}else{
		url="idCheck.jsp?id=" + id;
		window.open(url,"post","width=300,height=150");
	}
}

function id_search() { 
	 	var frm = document.idfindscreen;

	 	if (frm.name.value.length < 1) {
		  alert("�̸��� �Է��� �ּ���.");
		  return;
		 }

		 if (frm.phone.value.length != 11) {
			  alert("��ȭ��ȣ�� ��Ȯ�ϰ� �Է��� �ּ���.");
			  return;
		 }

	 frm.method = "post";
	 frm.action = "findIdResult.jsp"; //���â���
	 frm.submit();  
	 }
	  function pw_search(){

  var frm=document.pwfindscreen;

  if(frm.mid.value.length<1){
   alert("ID�� �Է��� �ּ���.");
   return;
  }

   if (frm.phone.value.length != 11) {
			  alert("��ȭ��ȣ�� ��Ȯ�ϰ� �Է��� �ּ���.");
			  return;
		 }
	
  frm.method="post";
  frm.action="findPwResult.jsp"; //���â ���
  frm.submit(); 
  }


function win_close(){
	self.close();
}

function pwdCheck(){
	if(document.joinFrm.pwd.value != document.joinFrm.repwd.value){
		alert("��й�ȣ�� ��ġ���� �ʽ��ϴ�.");
		document.joinFrm.repwd.focus();
		return;
	}
	
	document.joinFrm.submit();
}

