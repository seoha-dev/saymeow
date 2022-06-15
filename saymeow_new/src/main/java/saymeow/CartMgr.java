/* 1. insertDirectOrder 에서는 state insert 안되는지?
 * 2. */

package saymeow;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class CartMgr {
	private DBConnectionMgr pool;
	
	public CartMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//insert
	public void insertCart(CartBean cart) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert cart(oid,pnum,pname,price1,qty) values(?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, cart.getOid());
			pstmt.setInt(2, cart.getPnum());
			pstmt.setString(3, cart.getPname());
			pstmt.setInt(4, cart.getPrice1());
			pstmt.setInt(5, cart.getQty());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}
	
	//list
	public Vector<CartBean> getCartList(String oid){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<CartBean> vlist = new Vector<CartBean>();
		try {
			con = pool.getConnection();
			sql = "select * from cart where oid=? order by cnum asc";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, oid);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				CartBean cart = new CartBean();
				cart.setCnum(rs.getInt("cnum"));
				cart.setOid(rs.getString("oid"));
				cart.setPnum(rs.getInt("pnum"));
				cart.setPname(rs.getString("pname"));
				cart.setPrice1(rs.getInt("price1"));
				cart.setQty(rs.getInt("qty"));
				cart.setImage(rs.getString("image"));
				vlist.addElement(cart);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//update
	public void updateCart(int qty,int pnum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update cart set qty=qty+? where pnum=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, qty);
			pstmt.setInt(2, pnum);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}
	
	//delete
	public boolean deleteCart(int cnum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "delete from cart where cnum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, cnum);
			if(pstmt.executeUpdate()==1)
				flag =true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	//장바구니에 담겨있는지 조회 search
	public boolean searchCartList(String oid,int pnum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select * from cart where oid=? and pnum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, oid);
			pstmt.setInt(2, pnum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
	//order check
	public CartBean checkCart(int cnum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		CartBean cart = new CartBean();
		try {
			con = pool.getConnection();
			sql = "select * from cart where cnum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, cnum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				cart.setCnum(rs.getInt("cnum"));
				cart.setOid(rs.getString("oid"));
				cart.setPnum(rs.getInt("pnum"));
				cart.setPname(rs.getString("pname"));
				cart.setPrice1(rs.getInt("price1"));
				cart.setQty(rs.getInt("qty"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return cart;
	}
	
	// 카트 특정 선택상품의 가격*수량 들고오기
	public int getCheckedTotalPrice(String oid, int index) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int checkedTotalPrice = 0;
		try {
			con = pool.getConnection();
			sql = "SELECT qty*price1 "
				+ "FROM cart "
				+ "WHERE oid = ? "
				+ "LIMIT ?,1";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, oid);
			pstmt.setInt(2, index);
			rs = pstmt.executeQuery();
			if(rs.next())
				checkedTotalPrice = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return checkedTotalPrice;
	}
}
