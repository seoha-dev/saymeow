<!-- �Ǹŵ����� -->
<%@page import="saymeow.UtilMgr"%>
<%@page import="saymeow.AdminSalesDataBean"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:useBean id="dMgr" class="saymeow.AdminSalesDataMgr"/>
<%
Vector<AdminSalesDataBean> vlist = dMgr.getTopQtyInfo();
Vector<AdminSalesDataBean> vlist2 = dMgr.getTopSalesInfo();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�Ǹŵ�����</title>
	<!-- �ܺ� JS -->
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    
    <!-- ����׷��� -->
    <!-- �ֹ�������  -->
    <script type="text/javascript">
      google.charts.load("current", {packages:['corechart']});
      google.charts.setOnLoadCallback(drawChart);
      
      function getValueAt(column, dataTable, row) {
    	  return dataTable.getFormattedValue(row, column);
      }
      
      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ["��ǰ��", "�Ǹŷ�", { role: "style" } ],
          ["<%=dMgr.getSalesDataName(0)%>", <%=dMgr.getSalesDataQty(0)%>, "color: #fb6a31"],
          ["<%=dMgr.getSalesDataName(1)%>", <%=dMgr.getSalesDataQty(1)%>, "color: #92beaf"],
          ["<%=dMgr.getSalesDataName(2)%>", <%=dMgr.getSalesDataQty(2)%>, "color: #ffcc56"],
          ["<%=dMgr.getSalesDataName(3)%>", <%=dMgr.getSalesDataQty(3)%>, "color: #104a56"],
          ["<%=dMgr.getSalesDataName(4)%>", <%=dMgr.getSalesDataQty(4)%>, "color: #424242"],
          ["<%=dMgr.getSalesDataName(5)%>", <%=dMgr.getSalesDataQty(5)%>, "color: #cccccc"],
          ["<%=dMgr.getSalesDataName(6)%>", <%=dMgr.getSalesDataQty(6)%>, "color: #cccccc"],
          ["<%=dMgr.getSalesDataName(7)%>", <%=dMgr.getSalesDataQty(7)%>, "color: #cccccc"],
          ["<%=dMgr.getSalesDataName(8)%>", <%=dMgr.getSalesDataQty(8)%>, "color: #cccccc"],
          ["<%=dMgr.getSalesDataName(9)%>", <%=dMgr.getSalesDataQty(9)%>, "color: #cccccc"]
        ]);

        var view = new google.visualization.DataView(data);
        view.setColumns([0, 1,
                         { calc: getValueAt.bind(undefined, 1),
                           sourceColumn: 1,
                           type: "string",
                           role: "annotation" },
                         2]);

        var options = {
          title: "�Ǹŷ��� TOP10 [��ǰ��, �Ǹŷ�]",
          width: 800,
          height: 500,
          bar: {groupWidth: "50%"},
          legend: { position: "none" },
        };
        
        var chart = new google.visualization.ColumnChart(document.getElementById("columnchart_values"));
        chart.draw(view, options);
    }
    </script>
    
    <!-- ����׷��� ����׺� ����  -->
    <script type="text/javascript">
      google.charts.load("current", {packages:['corechart']});
      google.charts.setOnLoadCallback(drawChart);
      
      function getValueAt(column, dataTable, row) {
    	  return dataTable.getFormattedValue(row, column);
      }
      
      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ["��ǰ��", "�Ǹűݾ�", { role: "style" } ],
          ["<%=dMgr.getSalesDataName2(0)%>", <%=dMgr.getSalesData(0)%>, "color: #fb6a31"],
          ["<%=dMgr.getSalesDataName2(1)%>", <%=dMgr.getSalesData(1)%>, "color: #92beaf"],
          ["<%=dMgr.getSalesDataName2(2)%>", <%=dMgr.getSalesData(2)%>, "color: #ffcc56"],
          ["<%=dMgr.getSalesDataName2(3)%>", <%=dMgr.getSalesData(3)%>, "color: #104a56"],
          ["<%=dMgr.getSalesDataName2(4)%>", <%=dMgr.getSalesData(4)%>, "color: #424242"],
          ["<%=dMgr.getSalesDataName2(5)%>", <%=dMgr.getSalesData(5)%>, "color: #cccccc"],
          ["<%=dMgr.getSalesDataName2(6)%>", <%=dMgr.getSalesData(6)%>, "color: #cccccc"],
          ["<%=dMgr.getSalesDataName2(7)%>", <%=dMgr.getSalesData(7)%>, "color: #cccccc"],
          ["<%=dMgr.getSalesDataName2(8)%>", <%=dMgr.getSalesData(8)%>, "color: #cccccc"],
          ["<%=dMgr.getSalesDataName2(9)%>", <%=dMgr.getSalesData(9)%>, "color: #cccccc"]
        ]);

        var view = new google.visualization.DataView(data);
        view.setColumns([0, 1,
                         { calc: getValueAt.bind(undefined, 1),
                           sourceColumn: 1,
                           type: "string",
                           role: "annotation" },
                         2]);

        var options = {
          title: "�Ǹűݾ� TOP10 [��ǰ��, �Ǹűݾ�]",
          width: 800,
          height: 500,
          bar: {groupWidth: "50%"},
          legend: { position: "none" },
        };
        
        var chart = new google.visualization.ColumnChart(document.getElementById("columnchart_values2"));
        chart.draw(view, options);
    }
    </script>
    
      
	<!-- ����׷��� : ���� �⵵�� �������� 4��ġ ������ (Ex.23��Ǹ� 20~23�� ������) -->
	<!-- ������ �����, ���, �������� ���� �׷��� -->
	<script type="text/javascript">
		google.charts.load('current', {packages:['bar']});
		google.charts.setOnLoadCallback(drawChart);

		function drawChart() {
			var data = google.visualization.arrayToDataTable([
	          ['Year', 'Sales', 'Expenses', 'Profit'], 
	          ['<%=dMgr.getStandardYear(3)%>', <%=dMgr.getSales(dMgr.getStandardYear(3))%>, <%=dMgr.getExpenses(dMgr.getStandardYear(3))%>, <%=dMgr.getSales(dMgr.getStandardYear(3))-dMgr.getExpenses(dMgr.getStandardYear(3))%>],
	          ['<%=dMgr.getStandardYear(2)%>', <%=dMgr.getSales(dMgr.getStandardYear(2))%>, <%=dMgr.getExpenses(dMgr.getStandardYear(2))%>, <%=dMgr.getSales(dMgr.getStandardYear(2))-dMgr.getExpenses(dMgr.getStandardYear(2))%>],
	          ['<%=dMgr.getStandardYear(1)%>', <%=dMgr.getSales(dMgr.getStandardYear(1))%>, <%=dMgr.getExpenses(dMgr.getStandardYear(1))%>, <%=dMgr.getSales(dMgr.getStandardYear(1))-dMgr.getExpenses(dMgr.getStandardYear(1))%>],
	          ['<%=dMgr.getStandardYear(0)%>', <%=dMgr.getSales(dMgr.getStandardYear(0))%>, <%=dMgr.getExpenses(dMgr.getStandardYear(0))%>, <%=dMgr.getSales(dMgr.getStandardYear(0))-dMgr.getExpenses(dMgr.getStandardYear(0))%>]
	        ]);

	        var options = {
	          chart: {
	            title: 'Company Performance',
	            subtitle: 'Sales, Expenses, and Profit: <%=dMgr.getStandardYear(3)%>-<%=dMgr.getStandardYear(0)%>',
	          },
	          bars: 'vertical',
	          vAxis: {format: 'decimal'},
	          width: 1200,
	          height: 400,
	          colors: ['#1b9e77', '#d95f02', '#7570b3']
	        };

	        var chart = new google.charts.Bar(document.getElementById('chart_div'));
	
	        chart.draw(data, google.charts.Bar.convertOptions(options));
	
	        btns.onclick = function (e) {
	
	        if (e.target.tagName === 'BUTTON') {
				options.vAxis.format = e.target.id === 'none' ? '' : e.target.id;
	            chart.draw(data, google.charts.Bar.convertOptions(options));
			}
		}
	}
    </script>
    
    
    <!-- ��з��� ����/��ü ���� �����׷��� -->
    <script type="text/javascript">
		google.charts.load("current", {packages:["corechart"]});
		google.charts.setOnLoadCallback(drawChart);
		function drawChart() {
        	var data = google.visualization.arrayToDataTable([
	          ['mClass',	 'Total Sales'],
	          ['food',   	  <%=dMgr.getMSales("food")%>],
	          ['treat',    	  <%=dMgr.getMSales("treat")%>],
	          ['toy',  		  <%=dMgr.getMSales("toy")%>],
	          ['litter',	  <%=dMgr.getMSales("litter")%>],

	        ]);

	        var options = {
	          title: '��ü ���⿡�� ��з��� ��ǰ ����� ����',
	          width: 700,
	          height: 500,
	          
	        };
	
	        var chart = new google.visualization.PieChart(document.getElementById('piechart'))
	        chart.draw(data, options);
		}
	</script>

    <!-- �ߺз��� ����/��ü ���� �����׷��� -->
    <script type="text/javascript">
		google.charts.load("current", {packages:["corechart"]});
		google.charts.setOnLoadCallback(drawChart);
		function drawChart() {
        	var data = google.visualization.arrayToDataTable([
	          ['sClass', 'Total Sales'],
	          ['dry',     		<%=dMgr.getSSales("dry")%>],
	          ['wet',     		<%=dMgr.getSSales("wet")%>],
	          ['snack',  	  <%=dMgr.getSSales("snack")%>],
	          ['stick', 	  <%=dMgr.getSSales("stick")%>],
	          ['pole', 		   <%=dMgr.getSSales("pole")%>],
	          ['plush',  	  <%=dMgr.getSSales("plush")%>],
	          ['sand',		   <%=dMgr.getSSales("sand")%>],
	          ['box',		 	<%=dMgr.getSSales("box")%>],

	        ]);

	        var options = {
	          title: '��ü ���⿡�� �ߺз��� ��ǰ ����� ����',
	          width: 700,
	          height: 500,
	        };
	
	        var chart = new google.visualization.PieChart(document.getElementById('piechart2'))
	        chart.draw(data, options);
		}
	</script>
 
<!-- ��Ʈ��Ʈ�� CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<%@ include file="../top2.jsp"%>
<link rel='stylesheet' type='text/css' media='screen' href='../css/adminSales.css'>	
</head>
<body>
	<div class="d-flex align-items-start">
		<!-- ���̵�� -->
		<div class="nav flex-column nav-pills me-3" id="v-pills-tab" role="tablist" aria-orientation="vertical">
			<a href="adminOrder.jsp"><button class="nav-link" id="v-pills-home-tab" data-bs-toggle="pill" data-bs-target="#v-pills-home" type="button" role="tab" aria-controls="v-pills-home" aria-selected="true">�ֹ�����</button></a>
			<a href="adminMember.jsp"><button class="nav-link" id="v-pills-profile-tab" data-bs-toggle="pill" data-bs-target="#v-pills-profile" type="button" role="tab" aria-controls="v-pills-profile" aria-selected="false">ȸ������</button></a>
			<a href="adminReviewBoard.jsp"><button class="nav-link" id="v-pills-messages-tab" data-bs-toggle="pill" data-bs-target="#v-pills-messages" type="button" role="tab" aria-controls="v-pills-messages" aria-selected="false">�������</button></a>
			<a href="adminProduct.jsp"><button class="nav-link" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">��ǰ����</button></a>
			<a href="sellHistory.jsp"><button class="nav-link" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">�������</button></a>
			<a href="adminSales.jsp"><button class="nav-link active" id="v-pills-settings-tab" data-bs-toggle="pill" data-bs-target="#v-pills-settings" type="button" role="tab" aria-controls="v-pills-settings" aria-selected="false">�Ǹŵ�����</button></a>
		</div>
	
		<section class="chart">
		
		<!-- ���� -->
		
		
		<div class="barandtable">
	
		<!-- �Ǹŷ�top10 ����׷��� -->
		<div id="columnchart_values"></div>
	
		<!-- �Ǹŷ�top10 �׸�� ������̺� (�Ǹŷ�, �ֿ����� ����, ����� ��տ���, �ֿ�����) -->
		<div class="table">
		<table border="1" width="500px">
		<thead>
		<tr>
		<th width="50">����</th>
		<th width="100">��ǰ��</th>
		<th width="100">�Ǹŷ�</th>
		<th width="100">����� ����</th>
		<th width="100">����� ����</th>
		<th width="100">����</th>
		</tr>
		</thead>
		<tbody>
<%		
		for (int i=0; i < vlist.size(); i++) {
		AdminSalesDataBean bean = vlist.get(i);
%>
		<tr>
		<td><%=i+1%></td>
		<td><%=bean.getPname()%></td>
		<td><%=bean.getQty()%>��</td>
		<td><%=bean.getPetGender()%></td>
		<td><%=bean.getPetAge()%>��</td>
		<td><%=bean.getAddress()%></td>
		</tr>
		<% } //-for %>		
		</tbody>
		</table>
		</div>
		</div>
		
		<!-- �Ǹűݾ�top10 ����׷��� -->
		<div class="barandtable">
		<div id="columnchart_values2"></div>
		<div class="table">
		<table border="1" width="500px">
		<thead>
		<tr>
		<th width="50">����</th>
		<th width="100">��ǰ��</th>
		<th width="100">�Ǹűݾ�</th>
		<th width="100">����� ����</th>
		<th width="100">����� ����</th>
		<th width="100">����</th>
		</tr>
		</thead>
		<tbody>
<%		
		for (int i=0; i < vlist2.size(); i++) {
		AdminSalesDataBean bean = vlist2.get(i);
%>
		<tr>
		<td><%=i+1%></td>
		<td><%=bean.getPname()%></td>
		<td><%=UtilMgr.monFormat(bean.getPrice1())%>��</td>
		<td><%=bean.getPetGender()%></td>
		<td><%=bean.getPetAge()%>��</td>
		<td><%=bean.getAddress()%></td>
		</tr>
		<% } //-for %>		
		</tbody>
		</table>
		</div>
		</div>
		<div class="classpie">
		<div id="piechart"></div> 
		<div id="piechart2"></div>
		</div>
		<div id="chart_div"></div>

	
		</section>
	</div>
</body>
</html>