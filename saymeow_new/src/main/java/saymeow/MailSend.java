package saymeow;

public class MailSend {
	// mgr�� DB��ȸ���� �� �����ϴ� id�� email�� �Է¹޾Ҵٸ� ���� ������ �޼ҵ�
	public boolean sendEmail(String id, String email) {
		boolean flag = false; // ����Ʈ
		MemberMgr mgr = new MemberMgr();
		String pwd = mgr.findPwd(id, email);
		if(pwd!=null) {
			String subject = "[SayMeow] ��й�ȣ �ȳ��Դϴ�.";
			String content = id + "���� ��й�ȣ�� " + pwd + " �Դϴ�.";
			GmailSend.send(subject, content, email);
			flag = true; // ���������� ���۵Ǿ��ٸ� true ��ȯ
		}
		
		return flag;
	}

}
