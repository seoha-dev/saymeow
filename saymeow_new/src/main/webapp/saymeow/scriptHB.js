/*reviewForm.jsp�� �ڹٽ�ũ��Ʈ*/
const star = (target) => {
	// star Ŭ�����̸鼭 span �±��� width�� input=range ���� �������ŭ width�����Ͽ� �������� �߸���. -> ��ġ ���� ������ �� ó�� ����
    document.querySelector(`.star span`).style.width = `${target.value * 10}%`;
  }

 