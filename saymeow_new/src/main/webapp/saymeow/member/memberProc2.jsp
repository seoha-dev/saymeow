<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="mBean" class="saymeow.MemberBean"/> 
<jsp:useBean id="mMgr" class="saymeow.MemberMgr"/>
<jsp:setProperty name="mBean" property="*"/>
<%
// ������� �Է°� int�� �޾ƿ���
int mm = Integer.parseInt(request.getParameter("mon"));
int dd =  Integer.parseInt(request.getParameter("day"));
int p_mm = Integer.parseInt(request.getParameter("p_mon"));
int p_dd = Integer.parseInt(request.getParameter("p_day"));

// ������� �Է°� string���� �޾ƿ���
String mon = request.getParameter("mon");
String day = request.getParameter("day");
String p_mon = request.getParameter("p_mon"); 
String p_day = request.getParameter("p_day");
String year = request.getParameter("year");
String p_year = request.getParameter("p_year");

// int�� �޾ƿ� ���� 10���� ������ 0 �ٿ��� string���� ��ȯ
if (mm < 10) mon = "0"+request.getParameter("mon");
if (dd < 10) day = "0"+request.getParameter("day");
if (p_mm < 10) p_mon = "0"+request.getParameter("p_mon");
if (p_dd < 10) p_day = "0"+request.getParameter("p_day");

String birthday = year + mon + day;
String petAge = p_year+ p_mon + p_day;

// string ��ȯ�� ������� bean�� ��Ƽ� ������
mBean.setBirthday(birthday);
mBean.setPetAge(petAge); 
boolean flag = mMgr.insertMember(mBean);

//�׽�Ʈ
/* System.out.println("p_mon:" + p_mon + "  p_day:" + p_day);
System.out.println("petAge:" + petAge);
System.out.println("mon:" + mon + "  day:" + day);
System.out.println("birthday:" + birthday);
System.out.println("mon1:" + mm);
System.out.println("day1:" + dd);
System.out.println("p_mon1:" + p_mm);
System.out.println("p_day1:" + p_dd); */
%>
<html>
<body>
<br/><br/>
<div align="center">
<%
if(flag){%>
	<script>
	alert("ȸ�������� �Ϸ� �Ǿ����ϴ�.");
	location.href="../index.jsp";
</script>
	<%}else{%>
	 	<script>
	alert("�ٽ� �Է��Ͽ� �ֽʽÿ�.");
	history.back();
</script>
	<%}%>
</div>
</body>
</html>