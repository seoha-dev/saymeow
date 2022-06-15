<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="mBean" class="saymeow.MemberBean"/> 
<jsp:useBean id="mMgr" class="saymeow.MemberMgr"/>
<jsp:setProperty name="mBean" property="*"/>
<%
// 생년월일 입력값 int로 받아오기
int mm = Integer.parseInt(request.getParameter("mon"));
int dd =  Integer.parseInt(request.getParameter("day"));
int p_mm = Integer.parseInt(request.getParameter("p_mon"));
int p_dd = Integer.parseInt(request.getParameter("p_day"));

// 생년월일 입력값 string으로 받아오기
String mon = request.getParameter("mon");
String day = request.getParameter("day");
String p_mon = request.getParameter("p_mon"); 
String p_day = request.getParameter("p_day");
String year = request.getParameter("year");
String p_year = request.getParameter("p_year");

// int로 받아온 값이 10보다 작으면 0 붙여서 string으로 반환
if (mm < 10) mon = "0"+request.getParameter("mon");
if (dd < 10) day = "0"+request.getParameter("day");
if (p_mm < 10) p_mon = "0"+request.getParameter("p_mon");
if (p_dd < 10) p_day = "0"+request.getParameter("p_day");

String birthday = year + mon + day;
String petAge = p_year+ p_mon + p_day;

// string 변환된 생년월일 bean에 담아서 보내기
mBean.setBirthday(birthday);
mBean.setPetAge(petAge); 
boolean flag = mMgr.insertMember(mBean);

//테스트
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
	alert("회원가입이 완료 되었습니다.");
	location.href="../index.jsp";
</script>
	<%}else{%>
	 	<script>
	alert("다시 입력하여 주십시오.");
	history.back();
</script>
	<%}%>
</div>
</body>
</html>