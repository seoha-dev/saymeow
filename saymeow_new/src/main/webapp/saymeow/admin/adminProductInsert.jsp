<%@page contentType="text/html; charset=EUC-KR"%>
<%

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>상품등록</title>
<script>
   function change(fr) {
      if (fr == "food") {
         // 중분류 option의 name과 value를 배열로 정렬
         num = new Array("건식사료(dry)", "습식사료(wet)");
         vnum = new Array("dry", "wet");
      } else if (fr == "treat") {
         num = new Array("스낵(snack)", "스틱(stick)");
         vnum = new Array("snack", "stick");
      } else if (fr == "toy") {
         num = new Array("막대/낚싯대(pole)", "인형(plush)");
         vnum = new Array("pole", "plush");
      } else if (fr == "litter") {
         num = new Array("모래(sand)", "화장실(box)");
         vnum = new Array("sand", "box");
      }

      // 셀렉트 안의 리스트를 기본값으로 한다.
      for (i = 0; i < productInsertFrm.sclass.length; i++) {
         productInsertFrm.sclass.options[0] = null;
      }

      // for문으로 두번째 셀렉트 박스에 값을 뿌려준다.
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
<!-- 사이드바-->
<section class="side">
	<div>
		<a href="adminOrder.jsp"><button>주문관리</button></a>
		<a href="adminMember.jsp"><button>회원관리</button></a>
		<a href="adminReviewBoard.jsp"><button >리뷰관리</button></a>
		<a href="adminProduct.jsp"><button >상품관리</button></a>
		<a href="adminSales.jsp"><button >매출관리</button></a>
		<a href="#"><button >판매데이터</button></a>
	</div>
</section>
   <!-- 본문 -->
   <section class="contents">
      <div class="plist">
         <br><br>
         <h1>상품등록</h1>
         <br><br><br>
         <form method="post" action="adminProductProc.jsp?flag=insert"
            enctype="multipart/form-data" name="productInsertFrm">
            <table border="1">
               <tr>
                  <td>상품이름</td>
                  <td><input name="pname" value=""></td>
               </tr>
               <tr>

                  <td>상품대분류</td>
                  <td><select name="mclass" style="width: 150px"
                     onchange="change(document.productInsertFrm.mclass.value)">
                        <option value="">--선택해주세요--</option>
                        <option value="food">사료(food)</option>
                        <option value="treat">간식(treat)</option>
                        <option value="toy">장난감(toy)</option>
                        <option value="litter">배변용품(litter)</option>
                  </select></td>
               </tr>

               <tr>
                  <td>상품중분류</td>
                  <td><select name="sclass" style="width: 150px">

                  </select></td>
               </tr>
               <tr>
                  <td>상품가격</td>
                  <td><input name="price1" value=""></td>
               </tr>
               <tr>
                  <td>상품원가</td>
                  <td><input name="price2" value=""></td>
               </tr>
               <tr>
                  <td>상품마진</td>
                  <td><input name="price3" value=""></td>
               </tr>
               <tr>
                  <td>상품이미지</td>
                  <td><input type="file" name="image"></td>
               </tr>
               <tr>
                  <td>상품상세이미지</td>
                  <td><input type="file" name="detail"></td>
               </tr>
               <tr>
                  <td>판매상태</td>
                  <td><input name="pstat" value="1"></td>
               </tr>
               <tr>
                  <td>상품재고</td>
                  <td><input name="stock"></td>
               </tr>
            </table>
            <br>
            <br>
            <br>
            <button type="submit">상품등록</button>
            <br>
            <br>
            <br>
         </form>
      </div>
   </section>
</body>
</html>