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
	
	// 전체 레코드 수 카운트
	public int getCountRecord(String keyField, String keyWord, String interval) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int recordCnt = 0;
		try {
			con = pool.getConnection();
			
			// interval = 12, 6, 3, 1, all 올 수 있음
			if(interval.equals("12")) {
				if(keyWord.trim().equals("") || keyWord==null) { // 검색아닐 때
					sql = "SELECT count(*) "
						+ "FROM petorder "
						+ "WHERE regdate > DATE_SUB(now(), INTERVAL ? MONTH) ";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, Integer.parseInt(interval));
				} else { // 검색일 때
					sql = "SELECT count(*) "
						+ "FROM petorder "
						+ "WHERE " + keyField + " LIKE ? "
						+ "AND regdate > DATE_SUB(now(), INTERVAL ? MONTH) ";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%" + keyWord + "%"); // %안붙이는 오류 주의
					pstmt.setInt(2, Integer.parseInt(interval));
				}
				rs = pstmt.executeQuery();
				if(rs.next())
					recordCnt = rs.getInt(1);
			} else if(interval.equals("6")) {
				if(keyWord.trim().equals("") || keyWord==null) { // 검색아닐 때
					sql = "SELECT count(*) "
						+ "FROM petorder "
						+ "WHERE regdate > DATE_SUB(now(), INTERVAL ? MONTH) ";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, Integer.parseInt(interval));
				} else { // 검색일 때
					sql = "SELECT count(*) "
						+ "FROM petorder "
						+ "WHERE " + keyField + " LIKE ? "
						+ "AND regdate > DATE_SUB(now(), INTERVAL ? MONTH) ";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%" + keyWord + "%"); // %안붙이는 오류 주의
					pstmt.setInt(2, Integer.parseInt(interval));
				}
				rs = pstmt.executeQuery();
				if(rs.next())
					recordCnt = rs.getInt(1);
			} else if(interval.equals("3")) {
				if(keyWord.trim().equals("") || keyWord==null) { // 검색아닐 때
					sql = "SELECT count(*) "
						+ "FROM petorder "
						+ "WHERE regdate > DATE_SUB(now(), INTERVAL ? MONTH) ";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, Integer.parseInt(interval));
				} else { // 검색일 때
					sql = "SELECT count(*) "
						+ "FROM petorder "
						+ "WHERE " + keyField + " LIKE ? "
						+ "AND regdate > DATE_SUB(now(), INTERVAL ? MONTH) ";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%" + keyWord + "%"); // %안붙이는 오류 주의
					pstmt.setInt(2, Integer.parseInt(interval));
				}
				rs = pstmt.executeQuery();
				if(rs.next())
					recordCnt = rs.getInt(1);	
			} else if(interval.equals("1")) {
				if(keyWord.trim().equals("") || keyWord==null) { // 검색아닐 때
					sql = "SELECT count(*) "
						+ "FROM petorder "
						+ "WHERE regdate > DATE_SUB(now(), INTERVAL ? MONTH) ";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, Integer.parseInt(interval));
				} else { // 검색일 때
					sql = "SELECT count(*) "
						+ "FROM petorder "
						+ "WHERE " + keyField + " LIKE ? "
						+ "AND regdate > DATE_SUB(now(), INTERVAL ? MONTH) ";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%" + keyWord + "%"); // %안붙이는 오류 주의
					pstmt.setInt(2, Integer.parseInt(interval));
				}
				rs = pstmt.executeQuery();
				if(rs.next())
					recordCnt = rs.getInt(1);
			} else if(interval.equals("all")) {
				if(keyWord.trim().equals("") || keyWord==null) { // 검색 아닐 때
					sql = "SELECT count(*) "
						+ "FROM petorder ";
					pstmt = con.prepareStatement(sql);
				} else { // 검색일 때
					sql = "SELECT count(*) "
						+ "FROM petorder "
						+ "WHERE " + keyField + " LIKE ? ";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%" + keyWord + "%"); // %안붙이는 오류 주의
				}
				rs = pstmt.executeQuery();
				if(rs.next())
					recordCnt = rs.getInt(1);
			} else if(interval.trim().equals("") || interval == null /*기간검색X*/) {
				if(keyWord.trim().equals("") || keyWord==null) { // 검색 아닐 때
					sql = "SELECT count(*) "
						+ "FROM petorder ";
					pstmt = con.prepareStatement(sql);
				} else { // 검색일 때
					sql = "SELECT count(*) "
						+ "FROM petorder "
						+ "WHERE " + keyField + " LIKE ? ";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%" + keyWord + "%"); // %안붙이는 오류 주의
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
		return recordCnt; // 개수 반환
	}
	
	// 기간별 주문목록 가져오기
	public Vector<OrderBean> getOrderList(String keyField, String keyWord, int start, int cnt, String interval){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<OrderBean> vlist = new Vector<OrderBean>();
		try {
			con = pool.getConnection();
			if(keyWord==null||keyWord.trim().equals("")) { // 키워드 검색X 
				if(!interval.trim().equals("")) { // 키워드 검색X + 기간별 검색O
					if(interval.trim().equals("1")) { // 1개월
						sql = "SELECT * "
							+ "FROM petorder "
							+ "WHERE regdate > DATE_SUB(now(), INTERVAL ? MONTH) "
							+ "ORDER BY onum DESC "
							+ "LIMIT ?, ? ";
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1, Integer.parseInt(interval));
						pstmt.setInt(2, start);
						pstmt.setInt(3, cnt);
					} else if(interval.trim().equals("3")) { // 3개월
						sql = "SELECT * "
							+ "FROM petorder "
							+ "WHERE regdate > DATE_SUB(now(), INTERVAL ? MONTH) "
							+ "ORDER BY onum DESC "
							+ "LIMIT ?, ? ";
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1, Integer.parseInt(interval));
						pstmt.setInt(2, start);
						pstmt.setInt(3, cnt);
					} else if(interval.trim().equals("6")) { // 6개월
						sql = "SELECT * "
							+ "FROM petorder "
							+ "WHERE regdate > DATE_SUB(now(), INTERVAL ? MONTH) "
							+ "ORDER BY onum DESC "
							+ "LIMIT ?, ? ";
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1, Integer.parseInt(interval));
						pstmt.setInt(2, start);
						pstmt.setInt(3, cnt);
					} else if(interval.trim().equals("12")) { // 1년
						sql = "SELECT * "
							+ "FROM petorder "
							+ "WHERE regdate > DATE_SUB(now(), INTERVAL ? MONTH) "
							+ "ORDER BY onum DESC "
							+ "LIMIT ?, ? ";
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1, Integer.parseInt(interval));
						pstmt.setInt(2, start);
						pstmt.setInt(3, cnt);
					} else if(interval.trim().equals("all")) { // 전체기간조회
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
				} else if(interval.trim().equals("")) { // 키워드검색X + 기간별검색X
					sql = "SELECT * "
						+ "FROM petorder "
						+ "ORDER BY onum DESC " 
						+ "LIMIT ?, ? ";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, start);
					pstmt.setInt(2, cnt);
				}
			} else if(keyWord!=null){ // 키워드 검색O
				if(!interval.trim().equals("")) { // 키워드 검색O + 기간별 검색O
					if(interval.trim().equals("1")) { // 1개월
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
					} else if(interval.trim().equals("3")) { // 3개월
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
					} else if(interval.trim().equals("6")) { // 6개월
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
					} else if(interval.trim().equals("12")) { // 1년
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
					} else if(interval.trim().equals("all")) { // 전체기간 
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
				} else if(interval.trim().equals("")){ // 키워드 검색O + 기간별 검색X
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
			rs = pstmt.executeQuery(); // 실행
			
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
	
	// 주문내역 일부 삭제
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
	
	
	
	// 총 주문 수 SELECT : 검색하든 안하든 조건에 맞는 총 주문 수 가져오는 메소드 
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
					+ "FROM petorder ";
				pstmt = con.prepareStatement(sql);
			} else { // 검색일 때
				sql = "SELECT COUNT(*) "
					+ "FROM petorder "
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
	
	
	// (테스트용 메소드) Post 1000 : (한 페이지당 10개의 게시글)1000개의 게시물 입력 
	public void post1000(){
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "INSERT petorder(pnum,qty,price1,pname,oid,regdate,oaddress,state) "
				+ "VALUES (1, 22, 33000, '건식사료1', 'aaa', now(),'부산', 2);";
			pstmt = con.prepareStatement(sql);
			// 1000번 반복
			for (int i = 0; i < 1000; i++) {
				pstmt.executeUpdate(); // 실행
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
		aoMgr.post1000(); // 테스트용 1000개 레코드 입력 메소드 호출
	}
	
	
	
	
}
