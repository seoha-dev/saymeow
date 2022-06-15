package saymeow;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class AdminOrderMgr {
	private DBConnectionMgr pool;
	
	public AdminOrderMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	// ��ü ���ڵ� �� ī��Ʈ
	public int getCountRecord(String keyField, String keyWord, String interval) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int recordCnt = 0;
		try {
			con = pool.getConnection();
			
			// interval = 12, 6, 3, 1, all �� �� ����
			if(interval.equals("12")) {
				if(keyWord.trim().equals("") || keyWord==null) { // �˻��ƴ� ��
					sql = "SELECT count(*) "
						+ "FROM petorder "
						+ "WHERE regdate > DATE_SUB(now(), INTERVAL ? MONTH) ";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, Integer.parseInt(interval));
				} else { // �˻��� ��
					sql = "SELECT count(*) "
						+ "FROM petorder "
						+ "WHERE " + keyField + " LIKE ? "
						+ "AND regdate > DATE_SUB(now(), INTERVAL ? MONTH) ";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%" + keyWord + "%"); // %�Ⱥ��̴� ���� ����
					pstmt.setInt(2, Integer.parseInt(interval));
				}
				rs = pstmt.executeQuery();
				if(rs.next())
					recordCnt = rs.getInt(1);
			} else if(interval.equals("6")) {
				if(keyWord.trim().equals("") || keyWord==null) { // �˻��ƴ� ��
					sql = "SELECT count(*) "
						+ "FROM petorder "
						+ "WHERE regdate > DATE_SUB(now(), INTERVAL ? MONTH) ";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, Integer.parseInt(interval));
				} else { // �˻��� ��
					sql = "SELECT count(*) "
						+ "FROM petorder "
						+ "WHERE " + keyField + " LIKE ? "
						+ "AND regdate > DATE_SUB(now(), INTERVAL ? MONTH) ";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%" + keyWord + "%"); // %�Ⱥ��̴� ���� ����
					pstmt.setInt(2, Integer.parseInt(interval));
				}
				rs = pstmt.executeQuery();
				if(rs.next())
					recordCnt = rs.getInt(1);
			} else if(interval.equals("3")) {
				if(keyWord.trim().equals("") || keyWord==null) { // �˻��ƴ� ��
					sql = "SELECT count(*) "
						+ "FROM petorder "
						+ "WHERE regdate > DATE_SUB(now(), INTERVAL ? MONTH) ";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, Integer.parseInt(interval));
				} else { // �˻��� ��
					sql = "SELECT count(*) "
						+ "FROM petorder "
						+ "WHERE " + keyField + " LIKE ? "
						+ "AND regdate > DATE_SUB(now(), INTERVAL ? MONTH) ";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%" + keyWord + "%"); // %�Ⱥ��̴� ���� ����
					pstmt.setInt(2, Integer.parseInt(interval));
				}
				rs = pstmt.executeQuery();
				if(rs.next())
					recordCnt = rs.getInt(1);	
			} else if(interval.equals("1")) {
				if(keyWord.trim().equals("") || keyWord==null) { // �˻��ƴ� ��
					sql = "SELECT count(*) "
						+ "FROM petorder "
						+ "WHERE regdate > DATE_SUB(now(), INTERVAL ? MONTH) ";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, Integer.parseInt(interval));
				} else { // �˻��� ��
					sql = "SELECT count(*) "
						+ "FROM petorder "
						+ "WHERE " + keyField + " LIKE ? "
						+ "AND regdate > DATE_SUB(now(), INTERVAL ? MONTH) ";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%" + keyWord + "%"); // %�Ⱥ��̴� ���� ����
					pstmt.setInt(2, Integer.parseInt(interval));
				}
				rs = pstmt.executeQuery();
				if(rs.next())
					recordCnt = rs.getInt(1);
			} else if(interval.equals("all")) {
				if(keyWord.trim().equals("") || keyWord==null) { // �˻� �ƴ� ��
					sql = "SELECT count(*) "
						+ "FROM petorder ";
					pstmt = con.prepareStatement(sql);
				} else { // �˻��� ��
					sql = "SELECT count(*) "
						+ "FROM petorder "
						+ "WHERE " + keyField + " LIKE ? ";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%" + keyWord + "%"); // %�Ⱥ��̴� ���� ����
				}
				rs = pstmt.executeQuery();
				if(rs.next())
					recordCnt = rs.getInt(1);
			} else if(interval.trim().equals("") || interval == null /*�Ⱓ�˻�X*/) {
				if(keyWord.trim().equals("") || keyWord==null) { // �˻� �ƴ� ��
					sql = "SELECT count(*) "
						+ "FROM petorder ";
					pstmt = con.prepareStatement(sql);
				} else { // �˻��� ��
					sql = "SELECT count(*) "
						+ "FROM petorder "
						+ "WHERE " + keyField + " LIKE ? ";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%" + keyWord + "%"); // %�Ⱥ��̴� ���� ����
				}
				rs = pstmt.executeQuery();
				if(rs.next())
					recordCnt = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return recordCnt; // ���� ��ȯ
	}
	
	// �Ⱓ�� �ֹ���� ��������
	public Vector<OrderBean> getOrderList(String keyField, String keyWord, int start, int cnt, String interval){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<OrderBean> vlist = new Vector<OrderBean>();
		try {
			con = pool.getConnection();
			if(keyWord==null||keyWord.trim().equals("")) { // Ű���� �˻�X 
				if(!interval.trim().equals("")) { // Ű���� �˻�X + �Ⱓ�� �˻�O
					if(interval.trim().equals("1")) { // 1����
						sql = "SELECT * "
							+ "FROM petorder "
							+ "WHERE regdate > DATE_SUB(now(), INTERVAL ? MONTH) "
							+ "ORDER BY onum DESC "
							+ "LIMIT ?, ? ";
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1, Integer.parseInt(interval));
						pstmt.setInt(2, start);
						pstmt.setInt(3, cnt);
					} else if(interval.trim().equals("3")) { // 3����
						sql = "SELECT * "
							+ "FROM petorder "
							+ "WHERE regdate > DATE_SUB(now(), INTERVAL ? MONTH) "
							+ "ORDER BY onum DESC "
							+ "LIMIT ?, ? ";
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1, Integer.parseInt(interval));
						pstmt.setInt(2, start);
						pstmt.setInt(3, cnt);
					} else if(interval.trim().equals("6")) { // 6����
						sql = "SELECT * "
							+ "FROM petorder "
							+ "WHERE regdate > DATE_SUB(now(), INTERVAL ? MONTH) "
							+ "ORDER BY onum DESC "
							+ "LIMIT ?, ? ";
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1, Integer.parseInt(interval));
						pstmt.setInt(2, start);
						pstmt.setInt(3, cnt);
					} else if(interval.trim().equals("12")) { // 1��
						sql = "SELECT * "
							+ "FROM petorder "
							+ "WHERE regdate > DATE_SUB(now(), INTERVAL ? MONTH) "
							+ "ORDER BY onum DESC "
							+ "LIMIT ?, ? ";
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1, Integer.parseInt(interval));
						pstmt.setInt(2, start);
						pstmt.setInt(3, cnt);
					} else if(interval.trim().equals("all")) { // ��ü�Ⱓ��ȸ
						sql = "SELECT * "
							+ "FROM petorder "
							+ "ORDER BY onum DESC " 
							+ "LIMIT ?, ? ";
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1, start);
						pstmt.setInt(2, cnt);
					} else {
						System.out.println("error");
					}
				} else if(interval.trim().equals("")) { // Ű����˻�X + �Ⱓ���˻�X
					sql = "SELECT * "
						+ "FROM petorder "
						+ "ORDER BY onum DESC " 
						+ "LIMIT ?, ? ";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, start);
					pstmt.setInt(2, cnt);
				}
			} else if(keyWord!=null){ // Ű���� �˻�O
				if(!interval.trim().equals("")) { // Ű���� �˻�O + �Ⱓ�� �˻�O
					if(interval.trim().equals("1")) { // 1����
						sql = "SELECT * "
							+ "FROM petorder "
							+ "WHERE " + keyField + " LIKE ? AND "
							+ "regdate > DATE_SUB(now(), INTERVAL ? MONTH)" 
							+ "ORDER BY onum DESC "
							+ "LIMIT ?, ? ";
							pstmt = con.prepareStatement(sql);
							pstmt.setString(1, keyWord);
							pstmt.setInt(2, Integer.parseInt(interval));
							pstmt.setInt(3, start);
							pstmt.setInt(4, cnt);
					} else if(interval.trim().equals("3")) { // 3����
						sql = "SELECT * "
							+ "FROM petorder "
							+ "WHERE " + keyField + " LIKE ? AND "
							+ "regdate > DATE_SUB(now(), INTERVAL ? MONTH)" 
							+ "ORDER BY onum DESC "
							+ "LIMIT ?, ? ";
							pstmt = con.prepareStatement(sql);
							pstmt.setString(1, keyWord);
							pstmt.setInt(2, Integer.parseInt(interval));
							pstmt.setInt(3, start);
							pstmt.setInt(4, cnt);
					} else if(interval.trim().equals("6")) { // 6����
						sql = "SELECT * "
							+ "FROM petorder "
							+ "WHERE " + keyField + " LIKE ? AND "
							+ "regdate > DATE_SUB(now(), INTERVAL ? MONTH)" 
							+ "ORDER BY onum DESC "
							+ "LIMIT ?, ? ";
							pstmt = con.prepareStatement(sql);
							pstmt.setString(1, keyWord);
							pstmt.setInt(2, Integer.parseInt(interval));
							pstmt.setInt(3, start);
							pstmt.setInt(4, cnt);
					} else if(interval.trim().equals("12")) { // 1��
						sql = "SELECT * "
							+ "FROM petorder "
							+ "WHERE " + keyField + " LIKE ? AND "
							+ "regdate > DATE_SUB(now(), INTERVAL ? MONTH)" 
							+ "ORDER BY onum DESC "
							+ "LIMIT ?, ? ";
							pstmt = con.prepareStatement(sql);
							pstmt.setString(1, keyWord);
							pstmt.setInt(2, Integer.parseInt(interval));
							pstmt.setInt(3, start);
							pstmt.setInt(4, cnt);
					} else if(interval.trim().equals("all")) { // ��ü�Ⱓ 
						sql = "SELECT * "
							+ "FROM petorder "
							+ "WHERE " + keyField + " LIKE ? "
							+ "ORDER BY onum DESC " 
							+ "LIMIT ?, ? ";
						pstmt = con.prepareStatement(sql);
						pstmt.setString(1, "%" + keyWord +"%");
						pstmt.setInt(2, start);
						pstmt.setInt(3, cnt);
					}
				} else if(interval.trim().equals("")){ // Ű���� �˻�O + �Ⱓ�� �˻�X
					sql = "SELECT * "
						+ "FROM petorder "
						+ "WHERE " + keyField + " LIKE ? "
						+ "ORDER BY onum DESC " 
						+ "LIMIT ?, ? ";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%" + keyWord +"%");
					pstmt.setInt(2, start);
					pstmt.setInt(3, cnt);
				} 
			}
			rs = pstmt.executeQuery(); // ����
			
			while(rs.next()) {
				OrderBean bean = new OrderBean();
				
				bean.setOnum(rs.getInt(1));
				bean.setPnum(rs.getInt(2));
				bean.setQty(rs.getInt(3));
				bean.setPrice1(rs.getInt(4));
				bean.setPname(rs.getString(5));
				bean.setOid(rs.getString(6));
				bean.setRegdate(rs.getString(7));
				bean.setOaddress(rs.getString(8));
				bean.setState(rs.getString(9));
				
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	// �ֹ����� �Ϻ� ����
	public void deleteOrder(String onum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
				con = pool.getConnection();
				sql = "DELETE FROM petorder "
					+ "WHERE onum = ? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, Integer.parseInt(onum));
				pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}
	
	
	
	// �� �ֹ� �� SELECT : �˻��ϵ� ���ϵ� ���ǿ� �´� �� �ֹ� �� �������� �޼ҵ� 
	public int getTotalCount(String keyField, String keyWord) { // keyField : id, subject, content ���� �� ����
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
					+ "FROM petorder ";
				pstmt = con.prepareStatement(sql);
			} else { // �˻��� ��
				sql = "SELECT COUNT(*) "
					+ "FROM petorder "
					+ "WHERE " + keyField + " like ? "; // like '%test%'
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%"); // '' �ڵ����� �ٿ���
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
	
	
	// (�׽�Ʈ�� �޼ҵ�) Post 1000 : (�� �������� 10���� �Խñ�)1000���� �Խù� �Է� 
	public void post1000(){
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "INSERT petorder(pnum,qty,price1,pname,oid,regdate,oaddress,state) "
				+ "VALUES (1, 22, 33000, '�ǽĻ��1', 'aaa', now(),'�λ�', 2);";
			pstmt = con.prepareStatement(sql);
			// 1000�� �ݺ�
			for (int i = 0; i < 1000; i++) {
				pstmt.executeUpdate(); // ����
			}
			System.out.println("Post1000 Success"); 
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	
	public static void main(String[] args) {
		AdminOrderMgr aoMgr = new AdminOrderMgr(); 
		aoMgr.post1000(); // �׽�Ʈ�� 1000�� ���ڵ� �Է� �޼ҵ� ȣ��
	}
	
	
	
	
}
