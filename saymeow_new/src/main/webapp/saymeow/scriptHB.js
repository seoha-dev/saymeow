/*reviewForm.jsp용 자바스크립트*/
const star = (target) => {
	// star 클래스이면서 span 태그의 width를 input=range 값의 백분율만큼 width지정하여 나머지는 잘린다. -> 마치 별점 선택한 것 처럼 보임
    document.querySelector(`.star span`).style.width = `${target.value * 10}%`;
  }

 