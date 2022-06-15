package saymeow;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class ProductMgr {
	
	private DBConnectionMgr pool;
	public static final String SAVEDIRECTORY = 
			"C:/Jsp/jspproject/src/main/webapp/saymeow/image/"; //경로주의(혜빈경로)
	public static final String ENCODING = "EUC-KR";
	public static final int MAXPOSTSIZE = 10*1024*1024;//10mb

	public ProductMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	// 카테고리별 상품리스트업
	public Vector<ProductBean> getP(String mClass, String sClass) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ProductBean> vlist = new Vector<ProductBean>();
		try {
			con = pool.getConnection();
			if(sClass!=null) { // 중분류 선택
				sql = "SELECT pnum, pname, price1, image "
					+ "FROM product "
					+ "WHERE (sclass = ? AND pstat = 1) "
					+ "ORDER BY pnum DESC";	
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, sClass);	
			}else if(sClass==null) {
				sql = "SELECT pnum, pname, price1, image "
					+ "FROM product "
					+ "WHERE ( mclass = ? AND pstat = 1) "
					+ "ORDER BY pnum DESC";	
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, mClass);	
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ProductBean bean = new ProductBean();
				bean.setPnum(rs.getInt(1));
				bean.setPname(rs.getString(2));
				bean.setPrice1(rs.getInt(3));
				bean.setImage(rs.getString(4));
				vlist.addElement(bean);
			}	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		// System.out.println("[Mgr.getP] mClass:"+mClass+" /sClass:"+sClass);
		return vlist;
	}
	
	// 카테고리 및 정렬별 상품리스트업 <상품페이지>
	public Vector<ProductBean> getP2(String mClass, String sClass, String sort) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql1 = null;
		String sql2 = null;
		String sql3 = null;
		
		Vector<ProductBean> vlist = new Vector<ProductBean>();
		try {
			
			con = pool.getConnection();
			sql1 = "SELECT pnum, pname, price1, image "
				 + "FROM product ";
			if(sort==null || sort.equals("0") || sort.equals("null")) { // 최신순
				if(sClass==null || sClass.equals("null")) { //중분류X
					sql2 = "WHERE (mclass = ? AND pstat = 1) ";
					sql3 = "ORDER BY pnum DESC";
					pstmt = con.prepareStatement(sql1+sql2+sql3);
					pstmt.setString(1, mClass);	
				}else { // 중분류O
					sql2 = "WHERE (sclass = ? AND pstat = 1) ";
					sql3 = "ORDER BY pnum DESC";
					pstmt = con.prepareStatement(sql1+sql2+sql3);
					pstmt.setString(1, sClass);	
				}
			}else if (sort.equals("1")) { // 높은 가격순
				if(sClass==null || sClass.equals("null")) { //중분류X
					sql2 = "WHERE (mclass = ? AND pstat = 1) ";
					sql3 = "ORDER BY price1 DESC";
					pstmt = con.prepareStatement(sql1+sql2+sql3);
					pstmt.setString(1, mClass);	
				}else { // 중분류O
					sql2 = "WHERE (sclass = ? AND pstat = 1) ";
					sql3 = "ORDER BY price1 DESC";
					pstmt = con.prepareStatement(sql1+sql2+sql3);
					pstmt.setString(1, sClass);	
				}
			}else if (sort.equals("2")) { // 낮은 가격순 
				if(sClass==null || sClass.equals("null")) { //중분류X
					sql2 = "WHERE (mclass = ? AND pstat = 1) ";
					sql3 = "ORDER BY price1 ASC";
					pstmt = con.prepareStatement(sql1+sql2+sql3);
					pstmt.setString(1, mClass);	
				}else { // 중분류O
					sql2 = "WHERE (sclass = ? AND pstat = 1) ";
					sql3 = "ORDER BY price1 ASC";
					pstmt = con.prepareStatement(sql1+sql2+sql3);
					pstmt.setString(1, sClass);	
				}
			}else if (sort.equals("3")) { //리뷰 많은순
				if(sClass==null || sClass.equals("null")) { //중분류X
					sql1 = "SELECT p.pnum, pname, price1, image, COUNT(r.pnum) AS cnt "
						 + "FROM review r "
						 + "RIGHT JOIN product p ON p.pnum = r.pnum ";
					sql2 = "WHERE (mclass = ? AND pstat = 1) ";
					sql3 = "GROUP BY p.pnum "
						 + "ORDER BY cnt DESC";
					pstmt = con.prepareStatement(sql1+sql2+sql3);
					pstmt.setString(1, mClass);	
				}else { // 중분류O
					sql1 = "SELECT p.pnum, pname, price1, image, COUNT(r.pnum) AS cnt "
						 + "FROM review r "
						 + "RIGHT JOIN product p ON p.pnum = r.pnum ";
					sql2 = "WHERE (sclass = ? AND pstat = 1) ";
					sql3 = "GROUP BY p.pnum "
						 + "ORDER BY cnt DESC";
					pstmt = con.prepareStatement(sql1+sql2+sql3);
					pstmt.setString(1, sClass);	
				}
			}else if(sort.equals("4")) { // 리뷰높은순 (리뷰평균으로 계산)
				if(sClass==null || sClass.equals("null")) { //중분류X
					sql1 = "SELECT p.pnum, pname, price1, image, AVG(r.score) AS avg "
						 + "FROM review r "
						 + "RIGHT JOIN product p ON p.pnum = r.pnum ";
					sql2 = "WHERE (mclass = ? AND pstat = 1) ";
					sql3 = "GROUP BY p.pnum "
						 + "ORDER BY avg DESC";
					pstmt = con.prepareStatement(sql1+sql2+sql3);
					pstmt.setString(1, mClass);	
				}else { // 중분류O
					sql1 = "SELECT p.pnum, pname, price1, image, AVG(r.score) AS avg "
						 + "FROM review r "
						 + "RIGHT JOIN product p ON p.pnum = r.pnum ";
					sql2 = "WHERE (sclass = ? AND pstat = 1) ";
					sql3 = "GROUP BY p.pnum "
						 + "ORDER BY avg DESC";
					pstmt = con.prepareStatement(sql1+sql2+sql3);
					pstmt.setString(1, sClass);
				}
			}else if(sort.equals("5")) { // 판매량순 (인기순)
				if(sClass==null || sClass.equals("null")) { //중분류X
					sql1 = "SELECT p.pnum, p.pname, p.price1, image, SUM(o.qty) AS sum "
						 + "FROM petorder o "
						 + "RIGHT JOIN product p ON p.pnum = o.pnum ";
					sql2 = "WHERE (mclass = ? AND pstat = 1) ";
					sql3 = "GROUP BY p.pnum "
						 + "ORDER BY sum DESC";
					pstmt = con.prepareStatement(sql1+sql2+sql3);
					pstmt.setString(1, mClass);	
				}else { // 중분류O
					sql1 = "SELECT p.pnum, p.pname, p.price1, image, SUM(o.qty) AS sum "
						 + "FROM petorder o "
						 + "RIGHT JOIN product p ON p.pnum = r.pnum ";
					sql2 = "WHERE (sclass = ? AND pstat = 1) ";
					sql3 = "GROUP BY p.pnum "
						 + "ORDER BY sum DESC";
					pstmt = con.prepareStatement(sql1+sql2+sql3);
					pstmt.setString(1, sClass);
				}						
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ProductBean bean = new ProductBean();
				bean.setPnum(rs.getInt(1));
				bean.setPname(rs.getString(2));
				bean.setPrice1(rs.getInt(3));
				bean.setImage(rs.getString(4));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		//System.out.println("[Mgr.getP2] mClass:"+mClass+" /sClass:"+sClass+" /sort:"+sort);
		return vlist;
	}	

	
	// 메인화면 상품리스트업 (신상품순)
	public Vector<ProductBean> getP3() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ProductBean> vlist = new Vector<ProductBean>();
		try {
			con = pool.getConnection();
			sql = "select pnum, pname, price1, image from product "
				+ "WHERE pstat = 1 "					
				+ "order by pnum desc limit 10";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ProductBean bean = new ProductBean();
				bean.setPnum(rs.getInt(1));
				bean.setPname(rs.getString(2));
				bean.setPrice1(rs.getInt(3));
				bean.setImage(rs.getString(4));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
		
	}
	
	// 메인화면 상품리스트업 (인기상품순)
	public Vector<ProductBean> getP4() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ProductBean> vlist = new Vector<ProductBean>();
		try {
			con = pool.getConnection();
			sql = "SELECT p.pnum, p.pname, p.price1, p.image, SUM(o.qty) AS sum "
				+ "FROM petorder o "
				+ "RIGHT JOIN product p ON p.pnum = o.pnum "
				+ "WHERE pstat = 1 "
				+ "GROUP BY p.pnum "
				+ "ORDER BY sum DESC limit 10";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ProductBean bean = new ProductBean();
				bean.setPnum(rs.getInt(1));
				bean.setPname(rs.getString(2));
				bean.setPrice1(rs.getInt(3));
				bean.setImage(rs.getString(4));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}	
	
	
	
	// 특정 상품검색 (상품이름으로)
	public Vector<ProductBean> getPList(String keyWord){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ProductBean> vlist = new Vector<ProductBean>();
		try {
			con = pool.getConnection();
			sql = "SELECT * From product "
				+ "WHERE pname LIKE ? "
				+ "AND pstat = 1";  
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%"+keyWord+"%");
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ProductBean bean = new ProductBean();
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
				vlist.addElement(bean); 
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		// System.out.println("[ProductMgr] getPList실행");
		return vlist;
	}
	
	//pnum의 price1 호출: 장바구니에서 쓰는용
	public static int getPrice(int pnum) {

		DBConnectionMgr pool;
		pool = DBConnectionMgr.getInstance();	
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int price1 = 0;
		try {
			con = pool.getConnection();
			sql = "select price1 from product where pnum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, pnum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				price1 = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return price1;
	}
	
	//pnum으로 image 호출: 장바구니에서 쓰는용
	public static String getPImage(int pnum) {

		DBConnectionMgr pool;
		pool = DBConnectionMgr.getInstance();	
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String image = "ready.png";
		try {
			con = pool.getConnection();
			sql = "select image from product where pnum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, pnum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				image = rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return image;
	}
	
	
	// 주문완료시 상품 stock qty 갯수만큼 줄어들게 (안씀)
	public boolean stockMinus2(int pnum, int qty) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "UPDATE product SET stock = stock - ? WHERE pnum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, pnum);
			pstmt.setInt(2, qty);
			//System.out.println("[stock]pnum:"+pnum);
			//System.out.println("[stock]qty:"+qty);
			if(pstmt.executeUpdate()==1) flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		//System.out.println("[stock] 재고조정 실행");
		return flag;
	}
	
	
	// 주문번호 onum으로 qty만큼 stock 줄이는 메소드 
	public boolean stockMinus(int onum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "UPDATE product p JOIN petorder o "
				+ "ON p.pnum = o.pnum "
				+ "SET p.stock = p.stock-o.qty " 
				+ "WHERE onum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, onum);
			if(pstmt.executeUpdate()==1) flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		//System.out.println("[stock] 재고조정 실행 onum:"+onum);
		return flag;
	}
}




