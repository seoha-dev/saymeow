package saymeow;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import saymeow.DBConnectionMgr;

public class RCommentMgr {
	
	private DBConnectionMgr pool;
	
	public RCommentMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	// ���� ��� �߰�
	public void insertRComment(RCommentBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "INSERT INTO rComment (rnum, cid, pnum, rcDate, comment) "
				+ "VALUES (?,?,?,now(),?) ";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, bean.getRnum());
			pstmt.setString(2, bean.getCid());
			pstmt.setInt(3, bean.getPnum());
			pstmt.setString(4, bean.getComment());
			
			pstmt.executeUpdate(); 
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	// ���� ��� ��ü����
	public Vector<RCommentBean> listRComment(int rnum /*�������*/) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<RCommentBean> cvlist = new Vector<RCommentBean>();
		try {
			con = pool.getConnection();
			sql = "SELECT * "
				+ "FROM rComment "
				+ "WHERE rnum = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, rnum);
			rs = pstmt.executeQuery();
			// �Ʒ� ���� ���߸��� �� �� 
			while(rs.next()) {
				RCommentBean rcBean = new RCommentBean();
				
				rcBean.setRcNum(rs.getInt("rcNum"));
				rcBean.setRnum(rs.getInt("rnum"));
				rcBean.setCid(rs.getString("cid"));
				rcBean.setPnum(rs.getInt("pnum"));
				rcBean.setRcDate(rs.getString("rcDate"));
				rcBean.setComment(rs.getString("comment"));
				
				cvlist.addElement(rcBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return cvlist;
	}
	
	// ���� ��� �� �� ����
	public void deleteRComment(int rcNum/*��۹�ȣ*/) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "DELETE FROM rComment "
				+ "WHERE rcNum = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, rcNum);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	// ���� ��� ��ü����
	public void deleteAllRComment(int rnum /*�����ȣ*/) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "DELETE FROM rComment "
				+ "WHERE rnum = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, rnum);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	// �� ���信 �޸� ��� �� ��������
	public int getRCommentCount(int rnum /*�������*/) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0; // ��� �� ����Ʈ�� 0
		try {
			con = pool.getConnection();
			// count(rcNum) vs count(*) �Ű����� rcNum�� null���� ������ �����ϹǷ� ��Ȯ�� ����
			sql = "SELECT COUNT(rcNum) "
				+ "FROM rComment "
				+ "WHERE rnum = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, rnum);
			rs = pstmt.executeQuery();
			if(rs.next())
				count = rs.getInt(1); // ������� 1���÷��� ������ (���� count�÷��� ����)
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return count; // ��� �� ����
	}
}
