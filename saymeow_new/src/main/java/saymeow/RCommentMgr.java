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
	
	// 리뷰 댓글 추가
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
	
	// 리뷰 댓글 전체보기
	public Vector<RCommentBean> listRComment(int rnum /*리뷰순번*/) {
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
			// 아래 과정 빠뜨리지 말 것 
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
	
	// 리뷰 댓글 한 개 삭제
	public void deleteRComment(int rcNum/*댓글번호*/) {
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
	
	// 리뷰 댓글 전체삭제
	public void deleteAllRComment(int rnum /*리뷰번호*/) {
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
	
	// 한 리뷰에 달린 댓글 수 가져오기
	public int getRCommentCount(int rnum /*리뷰순번*/) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0; // 댓글 수 디폴트는 0
		try {
			con = pool.getConnection();
			// count(rcNum) vs count(*) 매개변수 rcNum은 null값이 있으면 제외하므로 정확성 높임
			sql = "SELECT COUNT(rcNum) "
				+ "FROM rComment "
				+ "WHERE rnum = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, rnum);
			rs = pstmt.executeQuery();
			if(rs.next())
				count = rs.getInt(1); // 결과값의 1번컬럼을 들고오기 (현재 count컬럼만 있음)
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return count; // 댓글 수 리턴
	}
}
