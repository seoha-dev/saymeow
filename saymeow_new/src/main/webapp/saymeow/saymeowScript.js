/**
 * 
 */
 //cart
 function cartDelete(form){
		form.flag.value="delete";
		form.submit();
}
 function cartOrder(form){
		form.flag.value="order";
		form.submit();
}
 function cartInsert(form){
		form.flag.value="insert";
		form.submit();
}
 function directOrder(form){
		form.flag.value="direct";
		form.submit();
}

function allChk() {
	c = document.cfrm;
	if(c.allCh.checked/*체크이벤트*/){
		for(i=1;i<c.cch.length;i++){
			c.cch[i].checked = true;
			if(c.cch[i].disabled)
				c.cch[i].checked = false;
		}
	} else {
		for(i=1;i<c.cch.length;i++){
			c.cch[i].checked = false;
		}
	}
}
function chk() {
	c = document.cfrm;
	for(i=1;i<c.cch.length;i++){
		if(c.cch[i].checked/*체크가 되었을때*/){
		}//---if
	}//----for
}
