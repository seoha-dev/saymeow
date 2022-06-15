package saymeow;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class AdminSalesDataMgr {
	private DBConnectionMgr pool; // ����
	
	// ������
	public AdminSalesDataMgr() {
		pool = DBConnectionMgr.getInstance(); // �ν��Ͻ�ȭ
	}
	
	/*����׷���*/
	// ����׷��� ����� ���� �Ǹż� 1~5�� �̸� ��������
	public String getSalesDataName(int index) { // getSalesRanking �޼ҵ� index������ ���� �ǹ�
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String pName = null;
		try {
			con = pool.getConnection();
			sql = "SELECT pname "
					+ "FROM petorder "
					+ "GROUP BY pnum "
					+ "ORDER BY SUM(qty) DESC, pname "
					+ "LIMIT ?,1 ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, index);
			rs = pstmt.executeQuery();
			if(rs.next())
				pName = rs.getString(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return pName;
	}
	
	// ����׷��� ����� ���� �Ǹż� 1~5�� �Ǹŷ� ��������
	public int getSalesDataQty(int index) { // getSalesRanking �޼ҵ� index������ ���� �ǹ�
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int qty = 0;
		try {
			con = pool.getConnection();
			sql = "SELECT SUM(qty) "
					+ "FROM petorder "
					+ "GROUP BY pnum "
					+ "ORDER BY SUM(qty) DESC, pname "
					+ "LIMIT ?,1 ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, index);
			rs = pstmt.executeQuery();
			if(rs.next())
				qty = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return qty;
	}
		
	/*������Ʈ*/
	// �Ǹż� 1~5�� ������
	public ProductBean getSalesRanking(int index) { // index : ? = limit ������ ù ���������� ���ϴ� ����, �ϳ��� �������Ƿ� 1�� �������� ����ϸ��
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ProductBean pBean = new ProductBean();
		try {
			con = pool.getConnection();
			/*�ֹ� ���� ���� ������ top5 ����*/
			sql = "SELECT p.pname, o.pnum "
				+ "FROM product p INNER JOIN petorder o "
				+ "WHERE o.pnum = p.pnum AND state = 2 " // ������ �ǸſϷ�� ��ǰ�� �Ǹŵ����Ϳ� �ջ�ǵ���
				+ "GROUP BY o.pnum "
				+ "ORDER BY SUM(o.qty) DESC, p.pname " // ���� ���� �켱���� qty�� ���ٸ� ��ǰ�̸� ������������
				+ "LIMIT ?, 1;";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, index);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				pBean.setPname(rs.getString(1));
				pBean.setPnum(rs.getInt(2));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return pBean;
	}
	
	// getSalesRanking �޼ҵ� ����� 1���� �����ͼ� ����� ��ȯ �� ������Ʈ ��ҿ� �̸� �ֱ�
	public String getSalesDataPname(int index) { // getSalesRanking �޼ҵ� index������ ���� �ǹ�
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String pName = null;
		try {
			AdminSalesDataMgr dMgr = new AdminSalesDataMgr();
			ProductBean pBean = dMgr.getSalesRanking(index);
			con = pool.getConnection();
			// ���� ��ǰ ������ �ֹ��ߴ���, �� �հ�� ����� ���ϱ� (Ex. �ֹ����� �� pnum=1 qty=4, pnum=1 qty=4�� pnum=2 qty=8�� ������� ����)
			sql = "SELECT pname, SUM(qty) * 100/ (SELECT SUM(qty) FROM petorder) FROM petorder WHERE pnum = ? AND state = 2";
			pstmt = con.prepareStatement(sql);			
			pstmt.setInt(1, pBean.getPnum());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				pName = rs.getString(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return pName;
	}
	
	// getSalesRanking �޼ҵ� ����� 1���� �����ͼ� ����� ��ȯ �� ������Ʈ ��ҿ� �ۼ�Ʈ �ֱ�
	public double getSalesDataPnum(int index) { // getSalesRanking �޼ҵ� index������ ���� �ǹ�
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		double percentage = 0;
		try {
			AdminSalesDataMgr dMgr = new AdminSalesDataMgr();
			ProductBean pBean = dMgr.getSalesRanking(index);
			con = pool.getConnection();
			// ���� ��ǰ ������ �ֹ��ߴ���, �� �հ�� ����� ���ϱ� (Ex. �ֹ����� �� pnum=1 qty=4, pnum=1 qty=4�� pnum=2 qty=8�� ������� ����)
			sql = "SELECT pname, SUM(qty) * 100/ (SELECT SUM(qty) FROM petorder) FROM petorder WHERE pnum = ? AND state = 2";
			pstmt = con.prepareStatement(sql);			
			pstmt.setInt(1, pBean.getPnum()); 
			rs = pstmt.executeQuery();
			if(rs.next()) {
				percentage = rs.getDouble(2);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return percentage;
	}
	
	
	
	
	/*����׷���*/
	// ���������� �⵵ ����Ǳ� ���� ���糯¥�� �⵵���� �����?�����? ���� �־ �⵵ ��ȯ�ϱ�
	public String getStandardYear(int interval) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String standardYear = null;
		try {
			con = pool.getConnection();
			sql = "SELECT DATE_FORMAT(DATE_SUB(now(), INTERVAL ? YEAR),'%Y')";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, interval);
			rs = pstmt.executeQuery();
			if(rs.next())
				standardYear = rs.getString(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return standardYear;
	}
	
	// Ư�� �⵵�� �� �ǸŰ��� ���ϱ�(�������� �ȵȰ���)
	public int getSales(String standardYear) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int sales = 0;
		try {
			con = pool.getConnection();
			sql = "SELECT SUM(price1 * qty) "
				+ "FROM petorder "
				+ "WHERE DATE_FORMAT(regdate, '%Y') > (SELECT DATE_FORMAT(DATE_SUB(?, INTERVAL 1 YEAR), '%Y')) "
				+ "AND DATE_FORMAT(regdate, '%Y') < (SELECT DATE_FORMAT(DATE_ADD(?, INTERVAL 1 YEAR), '%Y')) "
				+ "AND state = 2"; // ������ �ǸſϷ�� ��ǰ�� �Ǹŵ����Ϳ� �ջ�ǵ���
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, standardYear+"-01-01");
			pstmt.setString(2, standardYear+"-01-01");
			rs = pstmt.executeQuery();
			if(rs.next()) {
				sales = rs.getInt(1); // �� �ǸŰ���
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return sales;
	}
	
	// Ư�� �⵵�� ���� ���ϱ�
	public int getExpenses(String standardYear) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int expenses = 0;
		try {
			con = pool.getConnection();
			sql = "SELECT SUM(p.price2 * o.qty) "
				+ "FROM petorder o INNER JOIN product p "
				+ "WHERE o.pnum = p.pnum "
				+ "AND DATE_FORMAT(regdate, '%Y') > (SELECT DATE_FORMAT(DATE_SUB(?, INTERVAL 1 YEAR), '%Y')) "
				+ "AND DATE_FORMAT(regdate, '%Y') < (SELECT DATE_FORMAT(DATE_ADD(?, INTERVAL 1 YEAR),'%Y')) "
				+ "AND state = 2"; // ������ �ǸſϷ�� ��ǰ�� �Ǹŵ����Ϳ� �ջ�ǵ���
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, standardYear+"-01-01");
			pstmt.setString(2, standardYear+"-01-01");
			rs = pstmt.executeQuery();
			if(rs.next()) {
				expenses = rs.getInt(1); // �� �ǸŰ���
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return expenses;
	}
	
	
	/*�����׷���*/
	//-- ��з��� ����ݾ� (mclass sales)
	public int getMSales(String mClass) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int Msales = 0;
		try {
			con = pool.getConnection();
			
			sql = "SELECT SUM(o.price1*o.qty) "
				+ "FROM product p "
				+ "JOIN petorder o ON p.pnum = o.pnum "
				+ "WHERE p.mclass = ? AND o.state = 2";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mClass);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Msales = rs.getInt(1); // �ش� ��з��� �����
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return Msales;
	}
	
	//-- �ߺз��� ����ݾ� (sclass sales)
	public int getSSales(String sClass) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int Ssales = 0;
		try {
			con = pool.getConnection();
			
			sql = "SELECT SUM(o.price1*o.qty) "
				+ "FROM product p "
				+ "JOIN petorder o ON p.pnum = o.pnum "
				+ "WHERE p.sclass = ? AND o.state = 2";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, sClass);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Ssales = rs.getInt(1); // �ش� �ߺз��� �����
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return Ssales;
	}
	
	/*���̺�*/
	//-- �Ǹż��� top10 �׸� �Ǹŷ�, �ֿ� ����̼���, ��� ����̿���, �ֿ� ����
	public Vector<AdminSalesDataBean> getTopQtyInfo() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<AdminSalesDataBean> vlist = new Vector<AdminSalesDataBean>();
		try {
			con = pool.getConnection();
			sql = "SELECT p.pnum, p.pname, SUM(o.qty) AS sum, petgender, ROUND(avg(year(CURRENT_DATE())-YEAR(m.petage))) AS age, m.address "
				+ "FROM petorder o "
				+ "RIGHT JOIN product p ON p.pnum = o.pnum "
				+ "RIGHT JOIN member m ON m.id = o.oid "
				+ "WHERE pstat = 1 "
				+ "GROUP BY p.pnum "
				+ "ORDER BY sum DESC, p.pname limit 10";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				AdminSalesDataBean bean = new AdminSalesDataBean();
				bean.setPnum(rs.getInt(1));
				bean.setPname(rs.getString(2));
				bean.setQty(rs.getInt(3));
				bean.setPetGender(rs.getInt(4));
				bean.setPetAge(rs.getInt(5));
				bean.setAddress(rs.getString(6));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	/*����׷���*/
	// ����׷��� ����� ���� ����� ���� 1~10�� �̸� ��������
	public String getSalesDataName2(int index) { // getSalesRanking �޼ҵ� index������ ���� �ǹ�
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String pName = null;
		try {
			con = pool.getConnection();
			sql = "SELECT pname, SUM(price1*qty) as sum "
				+ "FROM petorder "
				+ "GROUP BY pname "
				+ "ORDER BY sum DESC LIMIT ?, 1 ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, index);
			rs = pstmt.executeQuery();
			if(rs.next())
				pName = rs.getString(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return pName;
	}	
	
	
	// ����׷��� ����� ���� ����� 1~10�� ���� ��������
	public int getSalesData(int index) { // getSalesRanking �޼ҵ� index������ ���� �ǹ�
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int sum = 0;
		try {
			con = pool.getConnection();
			sql = "SELECT SUM(price1*qty) as sum "
				+ "FROM petorder "
				+ "GROUP BY pname "
				+ "ORDER BY sum DESC LIMIT ?, 1";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, index);
			rs = pstmt.executeQuery();
			if(rs.next())
				sum = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return sum;
	}
	

	/*���̺�*/
	//-- �Ǹűݾ� top10 �׸� �Ǹž�, �ֿ� ����̼���, ��� ����̿���, �ֿ� ����
	public Vector<AdminSalesDataBean> getTopSalesInfo() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<AdminSalesDataBean> vlist = new Vector<AdminSalesDataBean>();
		try {
			con = pool.getConnection();
			sql = "SELECT p.pnum, p.pname, SUM(o.qty*o.price1) AS sum, petgender, ROUND(avg(year(CURRENT_DATE())-YEAR(m.petage))) AS age, m.address "
				+ "FROM petorder o "
				+ "RIGHT JOIN product p ON p.pnum = o.pnum "
				+ "RIGHT JOIN member m ON m.id = o.oid "
				+ "WHERE pstat = 1 "
				+ "GROUP BY p.pnum "
				+ "ORDER BY sum DESC, p.pname limit 10";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				AdminSalesDataBean bean = new AdminSalesDataBean();
				bean.setPnum(rs.getInt(1));
				bean.setPname(rs.getString(2));
				bean.setPrice1(rs.getInt(3));
				bean.setPetGender(rs.getInt(4));
				bean.setPetAge(rs.getInt(5));
				bean.setAddress(rs.getString(6));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	
	public static void main(String[] args) {
		AdminSalesDataMgr dMgr = new AdminSalesDataMgr();
		ProductBean pBean = dMgr.getSalesRanking(0);
		double percentage = dMgr.getSalesDataPnum(0);
		String standardYear = dMgr.getStandardYear(0);
		int sales = dMgr.getSales(standardYear);
		//System.out.println(dMgr.getSalesDataName(0));
	}
}
