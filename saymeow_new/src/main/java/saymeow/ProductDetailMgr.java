package saymeow;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class ProductDetailMgr {

	private DBConnectionMgr pool;
	public static final String SAVEFOLDER = "C:/Jsp/wepapp/src/main/webapp/saymeow/storage/";
	public static final String ENCODING = "EUC-KR";
	public static final int MAXPOSTSIZE = 10 * 1024 * 1024;

	public ProductDetailMgr() {
		pool = DBConnectionMgr.getInstance();
	}

	// pnum에 따른 제품정보 조회
	public ProductBean getProduct(int pnum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ProductBean bean = new ProductBean();
		try {
			con = pool.getConnection();
			sql = "select * from product where pnum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, pnum);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				
				// bean에 설정한 자료 타입에 맞게 변수 세팅.
				bean.setPnum(rs.getInt(1));
				bean.setPname(rs.getString(2));
				bean.setMclass(rs.getString(3));
				bean.setSclass(rs.getString(4));
				bean.setPrice1(rs.getInt(5));
				bean.setPrice2(rs.getInt(6));
				bean.setPrice3(rs.getInt(7));
				bean.setImage(rs.getString(8));
				bean.setDetail(rs.getString(9));
				bean.setPstat(rs.getInt(10));
				bean.setStock(rs.getInt(11));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}

		//System.out.println("bean " + bean.toString());
		return bean;
	}

	// 제품에 관련된 리뷰를 조회한다
	public Vector<ReviewBean> getReviewListByPnum(int pnum) { 
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ReviewBean> vlist = new Vector<ReviewBean>();
		try {
			con = pool.getConnection();
				sql = "SELECT * "
					+ "FROM review "
					+ "WHERE pnum = ? "
					+ "ORDER BY rnum DESC ";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, pnum);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ReviewBean bean = new ReviewBean();
				
				bean.setRnum(rs.getInt("rnum"));
				bean.setRid(rs.getString("rid")); 
				bean.setPnum(rs.getInt("pnum")); 
				bean.setDate(rs.getString("date"));
				bean.setSubject(rs.getString("subject"));
				bean.setContent(rs.getString("content"));
				bean.setScore(rs.getDouble("score"));
				bean.setFilename(rs.getString("filename"));
				
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
