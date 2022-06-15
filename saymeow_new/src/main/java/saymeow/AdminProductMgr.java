// 관리자기능: 상품관리
package saymeow;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class AdminProductMgr {
	
	private DBConnectionMgr pool;
	public static final String SAVEDIRECTORY = 
			"C:/Jsp/jspproject/src/main/webapp/saymeow/image/"; //경로주의 
	public static final String ENCODING = "EUC-KR";
	public static final int MAXPOSTSIZE = 10*1024*1024;//10mb

	public AdminProductMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	
	// 전체 상품 리스트
	public Vector<ProductBean> getAllP() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ProductBean> vlist = new Vector<ProductBean>();
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM product";
			pstmt = con.prepareStatement(sql);
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
		//System.out.println("[AdminProductMgr] getAllP실행");
		return vlist;
	}
		
	// 상품 등록	
	public boolean insertProduct(HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			MultipartRequest multi = 
					new MultipartRequest (req, SAVEDIRECTORY, MAXPOSTSIZE, ENCODING, 
							new DefaultFileRenamePolicy());
			con = pool.getConnection();
			sql = "INSERT product(pname, mclass, sclass, price1, price2, price3, image, detail, stock)"
				+ "VALUES(?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, multi.getParameter("pname"));
			pstmt.setString(2, multi.getParameter("mclass"));
			pstmt.setString(3, multi.getParameter("sclass"));
			pstmt.setInt(4, Integer.parseInt(multi.getParameter("price1"))); 
			pstmt.setInt(5, Integer.parseInt(multi.getParameter("price2"))); 
			pstmt.setInt(6, Integer.parseInt(multi.getParameter("price3"))); 
			if(multi.getFilesystemName("image")!=null)
				pstmt.setString(7, multi.getFilesystemName("image"));
			else
				pstmt.setString(7, "ready.png");
			if(multi.getFilesystemName("detail")!=null) 
				pstmt.setString(8, multi.getFilesystemName("detail"));
			else 
				pstmt.setString(8, "ready.png");
			pstmt.setInt(9, Integer.parseInt(multi.getParameter("stock")));     
			if(pstmt.executeUpdate()==1) 
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		System.out.println("[AdminProductMgr] insertProduct 실행");
		return flag;
	}
	
	
	// 상품 수정
	public boolean updateProduct(HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
	
		try {
			
			MultipartRequest multi = new MultipartRequest
					(req, SAVEDIRECTORY, MAXPOSTSIZE, ENCODING,
							new DefaultFileRenamePolicy());
			String image = null; 
			if(multi.getFilesystemName("image")!=null) {
				image = multi.getFilesystemName("image"); // 교체될 이미지
			}
			String detail = null; 
			if(multi.getFilesystemName("detail")!=null){
				detail = multi.getFilesystemName("detail"); // 교체될 디테일 
			}
			
			con = pool.getConnection();
			
			// 썸네일&디테일 이미지 둘 다 수정
			if(image!=null && detail!=null) {
			//	System.out.println("[AdminProductMgr] 썸네일&디테일 이미지 둘 다 수정");
				sql = "update product set pname=?, mclass=?, sclass=?, price1=?, price2=?, price3=?, "
					+ "image=?, detail=?, pstat=?, stock=? where pnum=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, multi.getParameter("pname"));
				pstmt.setString(2, multi.getParameter("mclass"));
				pstmt.setString(3, multi.getParameter("sclass"));
				pstmt.setInt(4, Integer.parseInt(multi.getParameter("price1"))); 
				pstmt.setInt(5, Integer.parseInt(multi.getParameter("price2"))); 
				pstmt.setInt(6, Integer.parseInt(multi.getParameter("price3"))); 
				pstmt.setString(7, multi.getFilesystemName("image"));
				pstmt.setString(8, multi.getFilesystemName("detail"));
				pstmt.setInt(9, Integer.parseInt(multi.getParameter("pstat")));
				pstmt.setInt(10, Integer.parseInt(multi.getParameter("stock"))); 
				pstmt.setInt(11, Integer.parseInt(multi.getParameter("pnum")));
				
			// 썸네일 이미지만 수정 (디테일은 그대로)
			}else if (image!=null) { 
				sql = "update product set pname=?, mclass=?, sclass=?, price1=?, price2=?, price3=?, "
					+ "image=?, pstat=?, stock=? where pnum=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, multi.getParameter("pname"));
				pstmt.setString(2, multi.getParameter("mclass"));
				pstmt.setString(3, multi.getParameter("sclass"));
				pstmt.setInt(4, Integer.parseInt(multi.getParameter("price1"))); 
				pstmt.setInt(5, Integer.parseInt(multi.getParameter("price2"))); 
				pstmt.setInt(6, Integer.parseInt(multi.getParameter("price3"))); 
				pstmt.setString(7, multi.getFilesystemName("image"));
				pstmt.setInt(8, Integer.parseInt(multi.getParameter("pstat")));
				pstmt.setInt(9, Integer.parseInt(multi.getParameter("stock"))); 
				pstmt.setInt(10, Integer.parseInt(multi.getParameter("pnum"))); 
			//	System.out.println("[AdminProductMgr] 썸네일수정");
		
			//디테일 이미지만 수정 (썸네일은 그대로)	
			}else if (detail!=null) {
				sql = "update product set pname=?, mclass=?, sclass=?, price1=?, price2=?, price3=?, "
					+ "detail=?, pstat=?, stock=? where pnum=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, multi.getParameter("pname"));
					pstmt.setString(2, multi.getParameter("mclass"));
					pstmt.setString(3, multi.getParameter("sclass"));
					pstmt.setInt(4, Integer.parseInt(multi.getParameter("price1"))); 
					pstmt.setInt(5, Integer.parseInt(multi.getParameter("price2"))); 
					pstmt.setInt(6, Integer.parseInt(multi.getParameter("price3"))); 
					pstmt.setString(7, multi.getFilesystemName("detail"));
					pstmt.setInt(8, Integer.parseInt(multi.getParameter("pstat")));
					pstmt.setInt(9, Integer.parseInt(multi.getParameter("stock"))); 
					pstmt.setInt(10, Integer.parseInt(multi.getParameter("pnum"))); 
			//		System.out.println("[AdminProductMgr] 디테일 수정");		
			// 썸네일&디테일 이미지 둘 다 수정X
			}else if (image==null && detail==null) {
				sql = "update product set pname=?, mclass=?, sclass=?, price1=?, price2=?, price3=?, "
					+ "pstat=?, stock=? where pnum=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, multi.getParameter("pname"));
					pstmt.setString(2, multi.getParameter("mclass"));
					pstmt.setString(3, multi.getParameter("sclass"));
					pstmt.setInt(4, Integer.parseInt(multi.getParameter("price1"))); 
					pstmt.setInt(5, Integer.parseInt(multi.getParameter("price2"))); 
					pstmt.setInt(6, Integer.parseInt(multi.getParameter("price3"))); 
					pstmt.setInt(7, Integer.parseInt(multi.getParameter("pstat")));
					pstmt.setInt(8, Integer.parseInt(multi.getParameter("stock"))); 
					pstmt.setInt(9, Integer.parseInt(multi.getParameter("pnum"))); 
			//		System.out.println("[AdminProductMgr] 이미지 수정X");
			}
			if(pstmt.executeUpdate()==1) 
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	// 상품삭제 (이미지는 놔둠)
	public boolean deleteProduct(int pnum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "delete from product where pnum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, pnum);
			System.out.println("pnum:"+pnum);
			if(pstmt.executeUpdate()==1) flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		System.out.println("[AdminProductMgr] deleteProduct 실행");
		return flag;
	}
	
	// 특정 상품검색 (상품번호로)
	public ProductBean getProduct(int pnum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ProductBean bean = new ProductBean();
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM product where pnum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, pnum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
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
		return bean;
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
				+ "WHERE pname LIKE ?";  
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
				System.out.println("keyword="+keyWord);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		System.out.println("[AdminProductMgr] getPList실행");
		return vlist;
	}
	
	// 총 상품 개수 SELECT : 검색하든 안하든 조건에 맞는 총 주문 수 가져오는 메소드 
	public int getTotalCount(String keyField, String keyWord) { // keyField : id, subject, content 들어올 수 있음
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			// 검색일 때 아닐 때 구분해서 SELECT
			if(keyWord.trim().equals("") || keyWord==null) { // 검색이 아닐 때
				sql = "SELECT COUNT(*) "
					+ "FROM product ";
				pstmt = con.prepareStatement(sql);
			} else { // 검색일 때
				sql = "SELECT COUNT(*) "
					+ "FROM product "
					+ "WHERE " + keyField + " like ? "; // like '%test%'
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%"); // '' 자동으로 붙여줌
			}
			rs = pstmt.executeQuery();
			if(rs.next())
				totalCount = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount; // 전체 게시글 수 반환
	}
	
}
	
	
	
	
	
	
	
	
	

	
	
	
	
	
	
	
	
	

