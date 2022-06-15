// �����ڱ��: ȸ������
package saymeow;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class AdminMemberMgr {

		private DBConnectionMgr pool;
		public static final String SAVEDIRECTORY = 
				"C:/Jsp/jspproject/src/main/webapp/saymeow/image/"; //�������
		public static final String ENCODING = "EUC-KR";
		public static final int MAXPOSTSIZE = 10*1024*1024;//10mb

		public AdminMemberMgr() {
			pool = DBConnectionMgr.getInstance();
		}

	
	// 1. ��ü ȸ�� ����Ʈ��
	public Vector<MemberBean> getAllM() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<MemberBean> vlist = new Vector<MemberBean>();
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM member";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				MemberBean bean = new MemberBean();
				bean.setId(rs.getString(1));				
				bean.setPwd(rs.getString(2));
				bean.setName(rs.getString(3));
				bean.setBirthday(rs.getString(4));
				bean.setPhone(rs.getString(5));
				bean.setEmail(rs.getString(6));
				bean.setAddress(rs.getString(7));
				bean.setGrade(rs.getInt(8));
				bean.setMode(rs.getInt(9));
				bean.setPetName(rs.getString(10));
				bean.setPetAge(rs.getString(11));
				bean.setPetGender(rs.getInt(12));
				bean.setPetBreed(rs.getString(13));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		//System.out.println("[AdminMemberMgr] getAllM ����");
		return vlist;
	}
	
	// 2. ȸ�� �˻� (id������ �˻�)
	public Vector<MemberBean> searchM(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<MemberBean> vlist = new Vector<MemberBean>();
		try {
			con = pool.getConnection();
			sql = "SELECT * "
				+ "FROM member "
				+ "WHERE id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				MemberBean bean = new MemberBean();
				bean.setId(rs.getString(1));				
				bean.setPwd(rs.getString(2));
				bean.setName(rs.getString(3));
				bean.setBirthday(rs.getString(4));
				bean.setPhone(rs.getString(5));
				bean.setEmail(rs.getString(6));
				bean.setAddress(rs.getString(7));
				bean.setGrade(rs.getInt(8));
				bean.setMode(rs.getInt(9));
				bean.setPetName(rs.getString(10));
				bean.setPetAge(rs.getString(11));
				bean.setPetGender(rs.getInt(12));
				bean.setPetBreed(rs.getString(13));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		//System.out.println("[AdminMemberMgr] searchM ����");
		return vlist;
	}
	
	
	//3. [�����ڿ�] ȸ�� grade ����	
	public void updateMemberGrade(int grade, String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "UPDATE member "
				+ "SET grade = ? "
				+ "WHERE id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, grade);
			pstmt.setString(2, id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}
	
	// 4. ȸ�� ����
	public Vector<MemberBean> getSortMember(String arrow) { // arrow.equals("up") : DESC, arrow.equals("down") : ASC
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<MemberBean> vlist = new Vector<MemberBean>();
		try {
			con = pool.getConnection();
			if(arrow.equals("up")) {
				sql = "SELECT * "
					+ "FROM member "
					+ "ORDER BY name DESC ";
			} else if(arrow.equals("down")) {
				sql = "SELECT * "
					+ "FROM member "
					+ "ORDER BY name ASC";
			}
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				MemberBean bean = new MemberBean();
				bean.setId(rs.getString(1));				
				bean.setPwd(rs.getString(2));
				bean.setName(rs.getString(3));
				bean.setBirthday(rs.getString(4));
				bean.setPhone(rs.getString(5));
				bean.setEmail(rs.getString(6));
				bean.setAddress(rs.getString(7));
				bean.setGrade(rs.getInt(8));
				bean.setMode(rs.getInt(9));
				bean.setPetName(rs.getString(10));
				bean.setPetAge(rs.getString(11));
				bean.setPetGender(rs.getInt(12));
				bean.setPetBreed(rs.getString(13));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	
}


