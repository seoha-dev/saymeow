package saymeow;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class OrderMgr {
	private DBConnectionMgr pool;
	
	public OrderMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	/*orderProc flag="order" �� ��쿡 ����*/
	// state 1: ������, 2: �����Ϸ��̸鼭 ���ÿ� ��ۿϷ�, 3: ȯ�ҿϷ�
	public void insertOrder(OrderBean order) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert petorder(pnum, qty, price1, pname, oid, regdate, oaddress, state) values(?,?,?,?,?,now(),?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, order.getPnum());
			pstmt.setInt(2, order.getQty());
			pstmt.setInt(3, order.getPrice1());
			pstmt.setString(4, order.getPname());
			pstmt.setString(5, order.getOid());
			pstmt.setString(6, order.getOaddress());
			pstmt.setString(7, "1");
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}
	
	/*orderProc flag="cart"�� ��쿡 ����*/
	public void insertOrderFromCart(OrderBean order) { // ��ٱ��Ͽ��� �ֹ��ϸ� -> order���̺� �ٷ� state=2(�����Ϸ�)�� insert�Ǵ°ų� ��������
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert petorder(pnum, qty, price1, pname, oid, regdate, oaddress, state) values(?,?,?,?,?,now(),?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, order.getPnum());
			pstmt.setInt(2, order.getQty());
			pstmt.setInt(3, order.getPrice1());
			pstmt.setString(4, order.getPname());
			pstmt.setString(5, order.getOid());
			pstmt.setString(6, order.getOaddress());
			pstmt.setString(7, "2"); // �ٷ� �����Ϸ�� �߰���
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}
	
	public void updateDirectOrder(String state, String oid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "UPDATE petorder "
				+ "SET state = ? "
				+ "WHERE oid = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, state);
			pstmt.setString(2, oid);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}
	
	/* productDetail.jsp���� �ٷ� �ֹ��ϱ� ��ư ������ ����� ���� �Է� �� (���� ��)�̹Ƿ�
	address ����, state=1 ������ ���·� insert �Ǵ� �޼ҵ�*/
	public void insertDirectOrder(OrderBean oBean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert petorder(pnum, qty, price1, pname, oid, regdate, state) values(?,?,?,?,?,now(),?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, oBean.getPnum());
			pstmt.setInt(2, oBean.getQty());
			pstmt.setInt(3, oBean.getPrice1());
			pstmt.setString(4, oBean.getPname());
			pstmt.setString(5, oBean.getOid());
			// regDate�� ���� ��¥�� �Է�
			pstmt.setString(6, "1"); // ������
			pstmt.executeUpdate();
			//System.out.println("����");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}
	
	
	// �ٷ��ֹ��ϱ⿡�� ���� ����(direct.jsp) ���� �ֱ� �߰��� ������������ �ֹ����� 1�� �����ֱ�
	public OrderBean getDirectOrderList(String oid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		OrderBean oBean = new OrderBean();
		try {
			con = pool.getConnection();
			/*�ֱ� �ֹ���� �� ���� �ֱ� �ֹ����� ����*/
			sql = "SELECT onum, pnum, qty, price1, pname, oid, regdate, state "
				+ "FROM petorder "
				+ "WHERE oid = ? "
				+ "ORDER BY onum DESC "
				+ "LIMIT 1 ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, oid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				oBean.setOnum(rs.getInt(1));
				oBean.setPnum(rs.getInt(2));
				oBean.setQty(rs.getInt(3));
				oBean.setPrice1(rs.getInt(4));
				oBean.setPname(rs.getString(5));
				oBean.setOid(rs.getString(6));
				oBean.setRegdate(rs.getString(7)); // ���ó�¥�� �Էµ� �� ������
				oBean.setState(rs.getString(8));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return oBean;
	}

	
	//list
	public Vector<OrderBean> getOrderList(String oid){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<OrderBean> vlist = new Vector<OrderBean>();
		try {
			con = pool.getConnection();
			sql = "select * from petorder where oid=? order by onum desc";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, oid);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				OrderBean order = new OrderBean();
				order.setOnum(rs.getInt("onum"));
				order.setPnum(rs.getInt("pnum"));
				order.setQty(rs.getInt("qty"));
				order.setPrice1(rs.getInt("price1"));
				order.setPname(rs.getString("pname"));
				order.setOid(rs.getString("oid"));
				order.setRegdate(rs.getString("regdate"));
				order.setOaddress(rs.getString("oaddress"));
				order.setState(rs.getString("state"));
				vlist.addElement(order);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//cancle 
	public void cancleOrder(int onum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			//���⼭ for�� ������
			sql = "update petorder set state=? where onum=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "3"); // �ֹ���� ���·� ������Ʈ
			pstmt.setInt(2, onum);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	
	/*admin, orderList->cartProc */
	//detail
	public OrderBean getOrderDetail(int onum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		OrderBean order = new OrderBean();
		try {
			con = pool.getConnection();
			sql = "select * from petorder where onum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, onum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				order.setOnum(rs.getInt("onum"));
				order.setPnum(rs.getInt("pnum"));
				order.setQty(rs.getInt("qty"));
				order.setPrice1(rs.getInt("price1"));
				order.setPname(rs.getString("pname"));
				order.setOid(rs.getString("oid"));
				order.setRegdate(rs.getString("regdate"));
				order.setOaddress(rs.getString("oaddress"));
				order.setState(rs.getString("state"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return order;
	}
	
	//all list
	public Vector<OrderBean> getOrderAllList(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<OrderBean> vlist = new Vector<OrderBean>();
		try {
			con = pool.getConnection();
			sql = "select * from petorder order by onum desc";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				OrderBean order = new OrderBean();
				order.setOnum(rs.getInt("onum"));
				order.setPnum(rs.getInt("pnum"));
				order.setQty(rs.getInt("qty"));
				order.setPrice1(rs.getInt("price1"));
				order.setPname(rs.getString("pname"));
				order.setOid(rs.getString("oid"));
				order.setRegdate(rs.getString("regdate"));
				order.setOaddress(rs.getString("oaddress"));
				order.setState(rs.getString("state"));
				vlist.addElement(order);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	/*
	 * //update public boolean updateOrder(int onum, String state) { Connection con
	 * = null; PreparedStatement pstmt = null; String sql = null; boolean flag =
	 * false; try { con = pool.getConnection(); sql =
	 * "update petOrder set state = ? where onum = ?"; pstmt =
	 * con.prepareStatement(sql); pstmt.setString(1, state); pstmt.setInt(2, onum);
	 * if(pstmt.executeUpdate()==1) flag = true; } catch (Exception e) {
	 * e.printStackTrace(); } finally { pool.freeConnection(con, pstmt); } return
	 * flag; }
	 */
	
	//OrderProc.jsp ���� �����Ǹ� state=2�� update
	public boolean updateOrder(int onum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update petOrder set state = ? where onum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "2"); // �����Ϸ�� �ٲٱ�
			pstmt.setInt(2, onum);
			if(pstmt.executeUpdate()==1) 
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	//OrderProc.jsp ���� �����Ǹ� �ּҰ� �Է��ϰԵǹǷ� �ּҰ��� state=2�� update
	public boolean updateDirectOrder(int onum, String oaddress) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update petOrder set state = ?, oaddress = ? where onum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "2"); // �����Ϸ�� �ٲٱ�
			pstmt.setString(2, oaddress); // �����Ϸ�� �ٲٱ�
			pstmt.setInt(3, onum);
			if(pstmt.executeUpdate()==1) 
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	
	
	//order ���̺� Ư���� �ֹ����� ����
	public boolean deleteOrder(int onum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "delete from petorder where onum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, onum);
			if(pstmt.executeUpdate()==1) 
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	// �������� ��� ã�� = state���� 1�� ��� => ������ �� �ֵ��� 
	public boolean getState1(int onum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select * from petorder where onum=? and state=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, onum);
			pstmt.setString(2, "1"); // �����Ϸ��̸鼭 ��ۿϷ� ���� = ���� �ۼ� ������ ����
			rs = pstmt.executeQuery();
			if(rs.next()) {
				flag=true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
	//review �ۼ� ������ ��� ã�� = state���� 2�� ��� 
	public boolean reviewOrder(int onum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select * from petorder where onum=? and state=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, onum);
			pstmt.setString(2, "2"); // �����Ϸ��̸鼭 ��ۿϷ� ���� = ���� �ۼ� ������ ����
			rs = pstmt.executeQuery();
			if(rs.next()) {
				flag=true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
	
	// (ȸ����) �� �ֹ� �� SELECT : �˻��ϵ� ���ϵ� ���ǿ� �´� �� �ֹ� �� �������� �޼ҵ� 
	public int getTotalCountById(String keyField, String keyWord, String oid) { // keyField : id, subject, content ���� �� ����
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			// �˻��� �� �ƴ� �� �����ؼ� SELECT
			if(keyWord.trim().equals("") || keyWord==null) { // �˻��� �ƴ� ��
				sql = "SELECT COUNT(*) "
					+ "FROM petorder "
					+ "WHERE oid = ? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, oid);
			} else { // �˻��� ��
				sql = "SELECT COUNT(*) "
					+ "FROM petorder "
					+ "WHERE " + keyField + " like ? AND "
					+ "oid = ?"; // like '%test%'
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%"); // '' �ڵ����� �ٿ���
				pstmt.setString(2, oid);
			}
			rs = pstmt.executeQuery();
			if(rs.next())
				totalCount = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount; // ��ü �Խñ� �� ��ȯ
	}
	
	
	// ���� �ֹ������� ����
	// �������� ������ ������ŭ �ֹ����� ���� SELECT : �˻��ϵ� ���ϵ� �����ϰ� ����Ǵ� �޼ҵ� 
	public Vector<OrderBean> getOrderList(String keyField, String keyWord, int start, int cnt, String oid) { /*�� �ΰ��� limit - SQL��*/
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<OrderBean> vlist = new Vector<OrderBean>();
		try {
			con = pool.getConnection();
			if(keyWord==null||keyWord.trim().equals("")) { // �˻��� �ƴ� ��
				sql = "SELECT * "
					+ "FROM petorder "
					+ "WHERE oid = ? "
					+ "ORDER BY onum DESC "
					+ "LIMIT ?,? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, oid);
				pstmt.setInt(2, start);
				pstmt.setInt(3, cnt);
			} else { // �˻��� �� 
				sql = "SELECT * "
					+ "FROM petorder "
					+ "WHERE oid = ? AND " + keyField + " LIKE ? " // ������� �߿�!!
					+ "ORDER BY onum DESC "
					+ "LIMIT ?,? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, oid);
				pstmt.setString(2, "%"+keyWord+"%"); // 2��° �Ű����� �ڸ��� ���ڿ��� �ڵ����� ����ǥ ���� '%keyWord%'
				pstmt.setInt(3, start);
				pstmt.setInt(4, cnt);
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				OrderBean bean = new OrderBean();
				
				// ����¡ó���� �ʿ��� �͸� ��������
				bean.setOnum(rs.getInt("onum")); 
				bean.setPnum(rs.getInt("pnum")); 
				bean.setQty(rs.getInt("qty")); 
				bean.setPrice1(rs.getInt("price1"));
				bean.setPname(rs.getString("pname"));
				bean.setOid(rs.getString("oid")); 
				bean.setRegdate(rs.getString("regdate"));
				bean.setOaddress(rs.getString("oaddress"));
				bean.setState(rs.getString("state"));
				
				vlist.addElement(bean); // ���Ϳ� ��������� ���
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist; // ����Ʈ�� 10���� ��ȯ�ǰ�, ������ ��ȯ�� �� ����
	}
	
	// [������ �ּҰ��� �޼ҵ�]�ֹ��ϴ� ȸ�� ���̵��� ���� �ֱ� �ֹ� ������ּ� ��������
	public String getNewestAddress(String oid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String newestAddress = null;
		try {
			con = pool.getConnection();
			sql = "SELECT oaddress "
				+ "FROM petorder "
				+ "WHERE oid = ? AND state='2' "
				+ "ORDER BY onum DESC "
				+ "LIMIT 0,1 ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, oid);
			rs = pstmt.executeQuery();
			if(rs.next())
				newestAddress = rs.getString(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return newestAddress;
	}
	
    // �ֹ����� 1000�� �Է� �޼ҵ�
    public void order1000(int pnum, int qty, int price1){
       Connection con = null;
       PreparedStatement pstmt = null;
       String sql = null;
       try {
          con = pool.getConnection();
          sql = "INSERT petorder(pnum,qty,price1,pname,oid,regdate,oaddress,state) "
             + "VALUES(?,?,?,?,?,now(),?,?)";
          pstmt = con.prepareStatement(sql);
          // 1000�� �ݺ�
          for (int i = 1; i < 300; i++) {
             pstmt.setInt(1, pnum);
             pstmt.setInt(2, qty);
             pstmt.setInt(3, price1);
             pstmt.setString(4, "�ǽĻ��1");
             pstmt.setString(5, "aaa");
             pstmt.setString(6, "�ּ�"+i);
             pstmt.setString(7, "1");
             pstmt.executeUpdate(); // ����
          }
          System.out.println("Post1000 Success"); 
       } catch (Exception e) {
          e.printStackTrace();
       } finally {
          pool.freeConnection(con, pstmt);
       }
    }
    
    // ���θ޼ҵ�
    public static void main(String[] args) {
       OrderMgr oMgr = new OrderMgr();
       oMgr.order1000(1,2,33000); // �׽�Ʈ�� 1000�� ���ڵ� �Է� �޼ҵ� ȣ��
    }
	
}
