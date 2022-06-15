/*중요!!! rea*/
// 리뷰와 댓글에관한 DB연동 메소드
package saymeow;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;


public class ReviewMgr {
	// 수영장 튜브 공기 빼지 않고 재사용하는 것과 같은 원리
	private DBConnectionMgr pool; // pool 객체 생성
	
	/*리뷰 - 파일업로드*/
	// 1. 업로드 파일 저장 위치(안 변하므로 상수)
	public static final String SAVEFOLDER = "C:/Jsp/jspproject/src/main/webapp/saymeow/storage/"; // 상수는 대문자로 표기하는 것이 일반적

	// 2. 업로드 파일명 인코딩
	public static final String ENCODING = "EUC-KR";

	// 3. 업로드 파일 크기 제한
	public static final int MAXSIZE = 1024 * 1024 * 10; // 10mb
	
	// 생성자
	public ReviewMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	// 리뷰 작성 INSERT
	public boolean insertReview(HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			// 파일업로드 관련 코드
			File dir = new File(SAVEFOLDER); // 매개변수로 pathname을 받는다.
			if(!dir.exists()) { // 폴더가 없다면
				// mkdirs() : 상위폴더가 없어도 생성 가능 (폴더 미리 안만들면 조건과 셋트임)
				// mkdir() : 상위폴더가 없으면 생성 불가능
				dir.mkdirs(); 
			}
			// multi에 request 들어가므로 request = null 되어 multi 객체 사용하면 됨
			MultipartRequest multi = new MultipartRequest(req, SAVEFOLDER, MAXSIZE, 
					ENCODING, new DefaultFileRenamePolicy());
			
			// 제목이나 내용 작성하지 않았다면 
			if(multi.getParameter("subject").trim().equals("") || 
					multi.getParameter("content").trim().equals("")) {
				return flag; // false 반환
			}
			
			
			// 파일업로드 안했다면 디폴트로 filename = null, filesize = 0이 DB에 저장됨
			String filename = null;
			int filesize = 0;
			
			// ReviewForm.jsp 파일업로드된 파일의 name = filename
			if(multi.getFilesystemName("filename")!=null) {// 파일업로드 했다면
				filename = multi.getFilesystemName("filename");
				filesize = (int)multi.getFile("filename").length(); // long -> int 캐스팅하여 파일크기 가져오기
			}
			
			con = pool.getConnection();
			sql = "INSERT INTO review(onum,rid,pnum,date,subject,content,score,filename,filesize) "
				+ "VALUES(?,?,?,now(),?,?,?,?,?) ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(multi.getParameter("onum"))); // multi는 object로 리턴되므로 형변환해서 받아주기
			pstmt.setString(2, multi.getParameter("rid"));
			pstmt.setInt(3, Integer.parseInt(multi.getParameter("pnum"))); 
			pstmt.setString(4, multi.getParameter("subject"));
			pstmt.setString(5, multi.getParameter("content"));
			pstmt.setDouble(6, Double.parseDouble(multi.getParameter("score"))/2); // 0.5점단위로 받기
			pstmt.setString(7, filename);
			pstmt.setInt(8, filesize);
			
			// 정상적인 저장이면 1(영향받은 행 갯수) 리턴, 비정상이면 0 리턴
			if(pstmt.executeUpdate()==1) 
				flag = true; 
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	
	//////////////////////////////////////////////////// reviewBoard.jsp 게시판 관련 메소드
	
	
	// rnum의 최대값 SELECT : 최신글이 가장 위에 올 수 있도록 만드는 메소드
	public int getMaxNum() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int maxNum = 0;
		try {
			con = pool.getConnection();
			sql = "SELECT MAX(rnum) "
				+ "FROM review ";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) 
				maxNum = rs.getInt(1); // 불러온 max num값을 넣음
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return maxNum;
	}
	
	// 총 리뷰 수 SELECT : 검색하든 안하든 조건에 맞는 총 리뷰 수 가져오는 메소드 
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
					+ "FROM review ";
				pstmt = con.prepareStatement(sql);
			} else { // 검색일 때
				sql = "SELECT COUNT(*) "
					+ "FROM review "
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
	
	
	// 총 리뷰 수 SELECT : 검색하든 안하든 조건에 맞는 총 리뷰 수 가져오는 메소드 
	public int getTotalCountByPnum(String keyField, String keyWord, int pnum) { // keyField : id, subject, content 들어올 수 있음
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
					+ "FROM review "
					+ "WHERE pnum = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, pnum);
			} else { // 검색일 때
				sql = "SELECT COUNT(*) "
					+ "FROM review "
					+ "WHERE " + keyField + " like ? AND " // like '%test%'
					+ "pnum = ? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%"); // '' 자동으로 붙여줌
				pstmt.setInt(2, pnum);
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
	
	// 특정id가 쓴 총 리뷰 수 SELECT 
	public int getTotalCountById(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			sql = "SELECT COUNT(*) "
				+ "FROM review "
				+ "WHERE rid = ? ";
			pstmt = con.prepareStatement(sql); 
			pstmt.setString(1, id);
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
	
	// 페이지별 정해진 개수만큼 리뷰 보기 SELECT : 검색하든 안하든 동일하게 적용되는 메소드 
	public Vector<ReviewBean> getReviewListByPnum(String keyField, String keyWord, int start, int cnt, int pnum) { /*뒤 두개는 limit - SQL문*/
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ReviewBean> vlist = new Vector<ReviewBean>();
		try {
			con = pool.getConnection();
			if(keyWord==null||keyWord.trim().equals("")) { // 검색이 아닐 때
				sql = "SELECT * "
					+ "FROM review "
					+ "WHERE pnum = ? "
					+ "ORDER BY rnum DESC "
					+ "LIMIT ?,? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, pnum);
				pstmt.setInt(2, start);
				pstmt.setInt(3, cnt);
			} else { // 검색일 때 
				sql = "SELECT * "
					+ "FROM review "
					+ "WHERE " + keyField + " LIKE ? AND " // 띄워쓰기 중요!!
					+ "pnum = ? " 
					+ "ORDER BY rnum DESC "
					+ "LIMIT ?,? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+keyWord+"%"); // 2번째 매개변수 자리의 문자열에 자동으로 따옴표 생성 '%keyWord%'
				pstmt.setInt(2, pnum);
				pstmt.setInt(3, start);
				pstmt.setInt(4, cnt);
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ReviewBean bean = new ReviewBean();
				
				// 페이징처리에 필요한 것만 가져오기
				bean.setRnum(rs.getInt("rnum")); // 리뷰순번
				bean.setRid(rs.getString("rid")); // 리뷰 작성자 id 
				bean.setPnum(rs.getInt("pnum")); // 상품번호 
				bean.setDate(rs.getString("date"));
				bean.setSubject(rs.getString("subject"));
				bean.setContent(rs.getString("content"));
				bean.setScore(rs.getDouble("score"));
				bean.setFilename(rs.getString("filename"));
				
				vlist.addElement(bean); // 벡터에 빈즈단위로 담기
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist; // 디폴트로 10개씩 반환되고, 나머지 반환될 수 있음
	}
	
	
	// 페이지별 정해진 개수만큼 리뷰 보기 SELECT : 검색하든 안하든 동일하게 적용되는 메소드 
	public Vector<ReviewBean> getReviewList(String keyField, String keyWord, int start, int cnt) { /*뒤 두개는 limit - SQL문*/
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ReviewBean> vlist = new Vector<ReviewBean>();
		try {
			con = pool.getConnection();
			if(keyWord==null||keyWord.trim().equals("")) { // 검색이 아닐 때
				sql = "SELECT * "
					+ "FROM review "
					+ "ORDER BY rnum DESC "
					+ "LIMIT ?,? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, cnt);
			} else { // 검색일 때 
				sql = "SELECT * "
					+ "FROM review "
					+ "WHERE " + keyField + " LIKE ? " // 띄워쓰기 중요!!
					+ "ORDER BY rnum DESC "
					+ "LIMIT ?,? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+keyWord+"%"); // 2번째 매개변수 자리의 문자열에 자동으로 따옴표 생성 '%keyWord%'
				pstmt.setInt(2, start);
				pstmt.setInt(3, cnt);
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ReviewBean bean = new ReviewBean();
				
				// 페이징처리에 필요한 것만 가져오기
				bean.setRnum(rs.getInt("rnum")); // 리뷰순번
				bean.setRid(rs.getString("rid")); // 리뷰 작성자 id 
				bean.setPnum(rs.getInt("pnum")); // 상품번호 
				bean.setDate(rs.getString("date"));
				bean.setSubject(rs.getString("subject"));
				bean.setContent(rs.getString("content"));
				bean.setScore(rs.getDouble("score"));
				bean.setFilename(rs.getString("filename"));
				
				vlist.addElement(bean); // 벡터에 빈즈단위로 담기
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist; // 디폴트로 10개씩 반환되고, 나머지 반환될 수 있음
	}
	
	
	// myReview만 보기
	// 페이지별 정해진 개수만큼 리뷰 보기 SELECT : 검색하든 안하든 동일하게 적용되는 메소드 
	public Vector<ReviewBean> getReviewList(String keyField, String keyWord, int start, int cnt, String id) { /*뒤 두개는 limit - SQL문*/
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ReviewBean> vlist = new Vector<ReviewBean>();
		try {
			con = pool.getConnection();
			if(keyWord==null||keyWord.trim().equals("")) { // 검색이 아닐 때
				sql = "SELECT * "
					+ "FROM review "
					+ "WHERE rid = ? "
					+ "ORDER BY rnum DESC "
					+ "LIMIT ?,? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setInt(2, start);
				pstmt.setInt(3, cnt);
			} else { // 검색일 때 
				sql = "SELECT * "
					+ "FROM review "
					+ "WHERE rid = ? AND " + keyField + " LIKE ? " // 띄워쓰기 중요!!
					+ "ORDER BY rnum DESC "
					+ "LIMIT ?,? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setString(2, "%"+keyWord+"%"); // 2번째 매개변수 자리의 문자열에 자동으로 따옴표 생성 '%keyWord%'
				pstmt.setInt(3, start);
				pstmt.setInt(4, cnt);
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ReviewBean bean = new ReviewBean();
				
				// 페이징처리에 필요한 것만 가져오기
				bean.setRnum(rs.getInt("rnum")); // 리뷰순번
				bean.setRid(rs.getString("rid")); // 리뷰 작성자 id 
				bean.setPnum(rs.getInt("pnum")); // 상품번호 
				bean.setDate(rs.getString("date"));
				bean.setSubject(rs.getString("subject"));
				bean.setContent(rs.getString("content"));
				bean.setScore(rs.getDouble("score"));
				bean.setFilename(rs.getString("filename"));
				
				vlist.addElement(bean); // 벡터에 빈즈단위로 담기
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist; // 디폴트로 10개씩 반환되고, 나머지 반환될 수 있음
	}
	
	
	// 한 개의 리뷰 읽기 SELECT 
	public ReviewBean getReview(int rnum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ReviewBean bean = new ReviewBean();
		try {
			con = pool.getConnection();
			sql = "SELECT * "
				+ "FROM review "
				+ "WHERE rnum = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, rnum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				// 빈즈에 모든 컬럼 셋팅해야만 빠짐없는 리뷰 읽기 가능
				bean.setRnum(rs.getInt("rnum"));
				bean.setOnum(rs.getInt("onum"));
				bean.setRid(rs.getString("rid"));
				bean.setPnum(rs.getInt("pnum"));
				bean.setDate(rs.getString("date"));
				bean.setSubject(rs.getString("subject"));
				bean.setContent(rs.getString("content"));
				bean.setScore(rs.getDouble("score"));
				bean.setFilename(rs.getString("filename"));
				bean.setFilesize(rs.getInt("filesize"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean; // 리뷰읽기에 필요한 빈즈 리턴
	}
	
	
	// 리뷰 삭제 DELETE : 업로드 파일 있든 없든 삭제
	public void deleteReview(int rnum, String filename/*DB 조회 안하고, 이클립스 stroage 폴더 조회*/) {
		// DB조회 안하는 이유 : 어차피 삭제할 때도 DB 거치면서 관련 레코드 다 삭제하는데, filename 조회할 때 DB 거치면 이중으로 거치므로 저장폴더 조회
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			if(filename!=null&&!filename.equals("")) { // 업로드 파일 있는 리뷰라면
				File f = new File(SAVEFOLDER+filename); // 파일 객체 생성
				if(f.exists()) { // storage 폴더에 파일이 존재한다면
					f.delete(); // 삭제
				}
			}
			con = pool.getConnection();
			sql = "DELETE FROM review "
				+ "WHERE rnum = ? "; // 게시글 순번으로 조회하여 삭제
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, rnum);
			pstmt.executeUpdate(); // 실행
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	
	// 수정버튼 누르면 다시 reviewForm.jsp 이동해서 누르면 새로운 multi 객체가 넘어가는 원리
	// 리뷰 수정 : 업로드 파일까지 수정 가능
	public void updateReview(MultipartRequest multi) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			
			// reviewForm.jsp에서 rnum 받아서 int형 변환 <- SQL 조건문에 필요
			int rnum = Integer.parseInt(multi.getParameter("rnum")); 
			
			// 새로운 리뷰 속성들
			String subject = multi.getParameter("subject");
			String content = multi.getParameter("content");
			double score = (Double.parseDouble(multi.getParameter("score"))/2);// 0.5점단위로 받기
			String filename = multi.getFilesystemName("filename"); // !!새로운 파일명!!
			
			if(filename!=null&&!filename.equals("")) { // 같은 파일명 업로드할 수 있으니 기존파일은 무조건 삭제함
				ReviewBean bean = getReview(rnum); // DB 조회하여 기존 리뷰 정보를 빈즈로 가져오기
				String originFile = bean.getFilename(); // !!기존 파일명!!
				if(originFile!=null&&!originFile.equals("")) { // 기존 파일 존재했다면
					File f = new File(SAVEFOLDER+originFile);
					if(f.exists()) { 
						f.delete(); // storage폴더의 기존 파일 삭제 (DB안거침)
					}
				}
				// 새로운 업로드 파일크기 
				int filesize = (int)multi.getFile("filename").length();
				
				sql = "UPDATE review "
					+ "SET subject=?, content=?, score=?, filename=?, filesize=? "
					+ "WHERE rnum = ? ";
				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, subject);
				pstmt.setString(2, content);
				pstmt.setDouble(3, score);
				pstmt.setString(4, filename);
				pstmt.setInt(5, filesize);
				pstmt.setInt(6, rnum);
			} else { // 파일 업로드 안했다면 나머지만 수정
				sql = "UPDATE review "
					+ "SET subject=?, content=?, score=? "
					+ "WHERE rnum = ? ";
					pstmt = con.prepareStatement(sql);

					pstmt.setString(1, subject);
					pstmt.setString(2, content);
					pstmt.setDouble(3, score);
					pstmt.setInt(4, rnum);
			}
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	
	// 관리자 댓글 작성
	public void insertRComment(RCommentBean rBean) { // jsp 측에서 bean.setXXX 
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "INSERT INTO rComment(rcNum, cid, pnum, rcDate, comment) "
				+ "VALUES(?,?,?,now(),?) ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, rBean.getRnum());
			pstmt.setString(2, rBean.getCid());
			pstmt.setInt(3, rBean.getPnum());
			pstmt.setString(4, rBean.getRcDate());
			pstmt.setString(5, rBean.getComment());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}
	
	// 이미 리뷰썼는지 onum으로 확인하는 메소드
	public boolean checkReivewInsert(int onum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flagForCheckReviewInsert = false;
		try {
			con = pool.getConnection();
			sql = "SELECT * "
				+ "FROM review "
				+ "WHERE onum = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, onum);
			rs = pstmt.executeQuery();
			if(rs.next())
				flagForCheckReviewInsert = true; // 이미 적었다면 true 반환
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flagForCheckReviewInsert;
	}
	
	
	
	
	// (테스트용 메소드) Post 1000 : (한 페이지당 10개의 게시글)1000개의 게시물 입력 
	public void post1000(){
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "INSERT review(onum,rid,pnum,date,subject,content,score,filename,filesize) "
				+ "VALUES (?, 'bbb', 1, now(),'Hello','World!', 3, null, 0);";
			pstmt = con.prepareStatement(sql);
			// 1000번 반복
			for (int i = 0; i < 500; i++) {
				pstmt.setInt(1, i+1);
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
		ReviewMgr rMgr = new ReviewMgr(); 
		rMgr.post1000(); // 테스트용 1000개 레코드 입력 메소드 호출
	}
	
}
