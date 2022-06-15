package saymeow;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class AdminMgr {
	
	private DBConnectionMgr pool;
	
	public AdminMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//매출관리 - sellAllProduct
	public Vector<OrderBean> showAllOrder() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<OrderBean> vlist = new Vector<OrderBean>();
		try {
			con = pool.getConnection();
			sql = "select pnum, pname, sum(qty) from petorder where state!=? group by pnum order by regdate desc, pnum asc";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "6");//주문 취소는 제외
			rs = pstmt.executeQuery();
			while(rs.next()) {
				OrderBean order = new OrderBean();
				order.setPnum(rs.getInt("pnum"));
				order.setPname(rs.getString("pname"));
				order.setQty(rs.getInt("sum(qty)"));
				vlist.addElement(order);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//order top 10
	public Vector<OrderBean> top10Order(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<OrderBean> vlist = new Vector<OrderBean>();
		try {
			con = pool.getConnection();
			sql = "select pname, sum(qty) from petorder group by pnum order by sum(qty) desc limit 10";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				OrderBean order = new OrderBean();
				order.setPname(rs.getString("pname"));
				order.setQty(rs.getInt("sum(qty)"));
				vlist.addElement(order);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//월년 정하기
	public Vector<OrderBean> selectYMRegdate(int year, int month) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<OrderBean> vlist = new Vector<OrderBean>();
		try {

			con = pool.getConnection();
			sql = "select pnum, pname, sum(qty) from petorder where year(regdate)=? and month(regdate)=? group by pnum order by regdate desc, pnum asc";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,year);
			pstmt.setInt(2,month);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				OrderBean order = new OrderBean();
				order.setPnum(rs.getInt("pnum"));
				order.setPname(rs.getString("pname"));
				order.setQty(rs.getInt("sum(qty)"));
				vlist.addElement(order);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	//year 단일
	public Vector<OrderBean> selectYRegdate(int year) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<OrderBean> vlist = new Vector<OrderBean>();
		try {

			con = pool.getConnection();
			sql = "select pnum, pname, sum(qty) from petorder where year(regdate)=? group by pnum order by regdate desc, pnum asc";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,year);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				OrderBean order = new OrderBean();
				order.setPnum(rs.getInt("pnum"));
				order.setPname(rs.getString("pname"));
				order.setQty(rs.getInt("sum(qty)"));
				vlist.addElement(order);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
}
