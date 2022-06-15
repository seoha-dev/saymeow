<%@page contentType="text/html; charset=EUC-KR"%>
<%

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>��ǰ���</title>
<script>
   function change(fr) {
      if (fr == "food") {
         // �ߺз� option�� name�� value�� �迭�� ����
         num = new Array("�ǽĻ��(dry)", "���Ļ��(wet)");
         vnum = new Array("dry", "wet");
      } else if (fr == "treat") {
         num = new Array("����(snack)", "��ƽ(stick)");
         vnum = new Array("snack", "stick");
      } else if (fr == "toy") {
         num = new Array("����/���˴�(pole)", "����(plush)");
         vnum = new Array("pole", "plush");
      } else if (fr == "litter") {
         num = new Array("��(sand)", "ȭ���(box)");
         vnum = new Array("sand", "box");
      }

      // ����Ʈ ���� ����Ʈ�� �⺻������ �Ѵ�.
      for (i = 0; i < productInsertFrm.sclass.length; i++) {
         productInsertFrm.sclass.options[0] = null;
      }

      // for������ �ι�° ����Ʈ �ڽ��� ���� �ѷ��ش�.
      for (i = 0; i < num.length; i++) {
         document.productInsertFrm.sclass.options[i] = new Option(num[i],
               vnum[i]);
      }

   }
</script>
    <link rel='stylesheet' type='text/css' media='screen' href='../css/adminMember.css'>	
<jsp:include page = "../top2.jsp"/>
</head>
<body>
<!-- ���̵��-->
<section class="side">
	<div>
		<a href="adminOrder.jsp"><button>�ֹ�����</button></a>
		<a href="adminMember.jsp"><button>ȸ������</button></a>
		<a href="adminReviewBoard.jsp"><button >�������</button></a>
		<a href="adminProduct.jsp"><button >��ǰ����</button></a>
		<a href="adminSales.jsp"><button >�������</button></a>
		<a href="#"><button >�Ǹŵ�����</button></a>
	</div>
</section>
   <!-- ���� -->
   <section class="contents">
      <div class="plist">
         <br><br>
         <h1>��ǰ���</h1>
         <br><br><br>
         <form method="post" action="adminProductProc.jsp?flag=insert"
            enctype="multipart/form-data" name="productInsertFrm">
            <table border="1">
               <tr>
                  <td>��ǰ�̸�</td>
                  <td><input name="pname" value=""></td>
               </tr>
               <tr>

                  <td>��ǰ��з�</td>
                  <td><select name="mclass" style="width: 150px"
                     onchange="change(document.productInsertFrm.mclass.value)">
                        <option value="">--�������ּ���--</option>
                        <option value="food">���(food)</option>
                        <option value="treat">����(treat)</option>
                        <option value="toy">�峭��(toy)</option>
                        <option value="litter">�躯��ǰ(litter)</option>
                  </select></td>
               </tr>

               <tr>
                  <td>��ǰ�ߺз�</td>
                  <td><select name="sclass" style="width: 150px">

                  </select></td>
               </tr>
               <tr>
                  <td>��ǰ����</td>
                  <td><input name="price1" value=""></td>
               </tr>
               <tr>
                  <td>��ǰ����</td>
                  <td><input name="price2" value=""></td>
               </tr>
               <tr>
                  <td>��ǰ����</td>
                  <td><input name="price3" value=""></td>
               </tr>
               <tr>
                  <td>��ǰ�̹���</td>
                  <td><input type="file" name="image"></td>
               </tr>
               <tr>
                  <td>��ǰ���̹���</td>
                  <td><input type="file" name="detail"></td>
               </tr>
               <tr>
                  <td>�ǸŻ���</td>
                  <td><input name="pstat" value="1"></td>
               </tr>
               <tr>
                  <td>��ǰ���</td>
                  <td><input name="stock"></td>
               </tr>
            </table>
            <br>
            <br>
            <br>
            <button type="submit">��ǰ���</button>
            <br>
            <br>
            <br>
         </form>
      </div>
   </section>
</body>
</html>