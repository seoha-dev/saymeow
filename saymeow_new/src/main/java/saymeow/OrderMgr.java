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
	
	/*orderProc flag="order" 인 경우에 실행*/
	// state 1: 결제전, 2: 결제완료이면서 동시에 배송완료, 3: 환불완료
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
	
	/*orderProc flag="cart"인 경우에 실행*/
	public void insertOrderFromCart(OrderBean order) { // 장바구니에서 주문하면 -> order테이블에 바로 state=2(결제완료)로 insert되는거나 마찬가지
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
			pstmt.setString(7, "2"); // 바로 결제완료로 추가됨
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
	
	/* productDetail.jsp에서 바로 주문하기 버튼 누르면 배송지 정보 입력 전 (결제 전)이므로
	address 빼고, state=1 결제전 상태로 insert 되는 메소드*/
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
			// regDate는 오늘 날짜로 입력
			pstmt.setString(6, "1"); // 결제전
			pstmt.executeUpdate();
			//System.out.println("성공");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}
	
	
	// 바로주문하기에서 결제 전에(direct.jsp) 가장 최근 추가된 결제전상태의 주문내역 1개 보여주기
	public OrderBean getDirectOrderList(String oid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		OrderBean oBean = new OrderBean();
		try {
			con = pool.getConnection();
			/*최근 주문목록 중 가장 최근 주문내역 삭제*/
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
				oBean.setRegdate(rs.getString(7)); // 오늘날짜로 입력된 것 들고오기
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
			//여기서 for문 돌리기
			sql = "update petorder set state=? where onum=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "3"); // 주문취소 상태로 업데이트
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
	
	//OrderProc.jsp 에서 결제되면 state=2로 update
	public boolean updateOrder(int onum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update petOrder set state = ? where onum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "2"); // 결제완료로 바꾸기
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
	
	//OrderProc.jsp 에서 결제되면 주소값 입력하게되므로 주소값과 state=2로 update
	public boolean updateDirectOrder(int onum, String oaddress) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update petOrder set state = ?, oaddress = ? where onum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "2"); // 결제완료로 바꾸기
			pstmt.setString(2, oaddress); // 결제완료로 바꾸기
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
	
	
	
	//order 테이블 특정인 주문내역 삭제
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
	
	// 결제전인 사람 찾기 = state값이 1인 사람 => 결제할 수 있도록 
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
			pstmt.setString(2, "1"); // 결제완료이면서 배송완료 상태 = 리뷰 작성 가능한 상태
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
	
	//review 작성 가능한 사람 찾기 = state값이 2인 사람 
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
			pstmt.setString(2, "2"); // 결제완료이면서 배송완료 상태 = 리뷰 작성 가능한 상태
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
	
	
	// (회원용) 총 주문 수 SELECT : 검색하든 안하든 조건에 맞는 총 주문 수 가져오는 메소드 
	public int getTotalCountById(String keyField, String keyWord, String oid) { // keyField : id, subject, content 들어올 수 있음
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
					+ "FROM petorder "
					+ "WHERE oid = ? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, oid);
			} else { // 검색일 때
				sql = "SELECT COUNT(*) "
					+ "FROM petorder "
					+ "WHERE " + keyField + " like ? AND "
					+ "oid = ?"; // like '%test%'
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%"); // '' 자동으로 붙여줌
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
		return totalCount; // 전체 게시글 수 반환
	}
	
	
	// 나의 주문내역만 보기
	// 페이지별 정해진 개수만큼 주문내역 보기 SELECT : 검색하든 안하든 동일하게 적용되는 메소드 
	public Vector<OrderBean> getOrderList(String keyField, String keyWord, int start, int cnt, String oid) { /*뒤 두개는 limit - SQL문*/
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<OrderBean> vlist = new Vector<OrderBean>();
		try {
			con = pool.getConnection();
			if(keyWord==null||keyWord.trim().equals("")) { // 검색이 아닐 때
				sql = "SELECT * "
					+ "FROM petorder "
					+ "WHERE oid = ? "
					+ "ORDER BY onum DESC "
					+ "LIMIT ?,? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, oid);
				pstmt.setInt(2, start);
				pstmt.setInt(3, cnt);
			} else { // 검색일 때 
				sql = "SELECT * "
					+ "FROM petorder "
					+ "WHERE oid = ? AND " + keyField + " LIKE ? " // 띄워쓰기 중요!!
					+ "ORDER BY onum DESC "
					+ "LIMIT ?,? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, oid);
				pstmt.setString(2, "%"+keyWord+"%"); // 2번째 매개변수 자리의 문자열에 자동으로 따옴표 생성 '%keyWord%'
				pstmt.setInt(3, start);
				pstmt.setInt(4, cnt);
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				OrderBean bean = new OrderBean();
				
				// 페이징처리에 필요한 것만 가져오기
				bean.setOnum(rs.getInt("onum")); 
				bean.setPnum(rs.getInt("pnum")); 
				bean.setQty(rs.getInt("qty")); 
				bean.setPrice1(rs.getInt("price1"));
				bean.setPname(rs.getString("pname"));
				bean.setOid(rs.getString("oid")); 
				bean.setRegdate(rs.getString("regdate"));
				bean.setOaddress(rs.getString("oaddress"));
				bean.setState(rs.getString("state"));
				
				vlist.addElement(bean); // 벡터에 빈즈단위로 담기
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist; // 디폴트로 10개씩 반환되고, 나머지 반환될 수 있음
	}
	
	// [결제시 주소관련 메소드]주문하는 회원 아이디의 가장 최근 주문 배송지주소 가져오기
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
	
    // 주문내역 1000개 입력 메소드
    public void order1000(int pnum, int qty, int price1){
       Connection con = null;
       PreparedStatement pstmt = null;
       String sql = null;
       try {
          con = pool.getConnection();
          sql = "INSERT petorder(pnum,qty,price1,pname,oid,regdate,oaddress,state) "
             + "VALUES(?,?,?,?,?,now(),?,?)";
          pstmt = con.prepareStatement(sql);
          // 1000번 반복
          for (int i = 1; i < 300; i++) {
             pstmt.setInt(1, pnum);
             pstmt.setInt(2, qty);
             pstmt.setInt(3, price1);
             pstmt.setString(4, "건식사료1");
             pstmt.setString(5, "aaa");
             pstmt.setString(6, "주소"+i);
             pstmt.setString(7, "1");
             pstmt.executeUpdate(); // 실행
          }
          System.out.println("Post1000 Success"); 
       } catch (Exception e) {
          e.printStackTrace();
       } finally {
          pool.freeConnection(con, pstmt);
       }
    }
    
    // 메인메소드
    public static void main(String[] args) {
       OrderMgr oMgr = new OrderMgr();
       oMgr.order1000(1,2,33000); // 테스트용 1000개 레코드 입력 메소드 호출
    }
	
}
