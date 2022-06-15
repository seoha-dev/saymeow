/*�߿�!!! rea*/
// ����� ��ۿ����� DB���� �޼ҵ�
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
	// ������ Ʃ�� ���� ���� �ʰ� �����ϴ� �Ͱ� ���� ����
	private DBConnectionMgr pool; // pool ��ü ����
	
	/*���� - ���Ͼ��ε�*/
	// 1. ���ε� ���� ���� ��ġ(�� ���ϹǷ� ���)
	public static final String SAVEFOLDER = "C:/Jsp/jspproject/src/main/webapp/saymeow/storage/"; // ����� �빮�ڷ� ǥ���ϴ� ���� �Ϲ���

	// 2. ���ε� ���ϸ� ���ڵ�
	public static final String ENCODING = "EUC-KR";

	// 3. ���ε� ���� ũ�� ����
	public static final int MAXSIZE = 1024 * 1024 * 10; // 10mb
	
	// ������
	public ReviewMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	// ���� �ۼ� INSERT
	public boolean insertReview(HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			// ���Ͼ��ε� ���� �ڵ�
			File dir = new File(SAVEFOLDER); // �Ű������� pathname�� �޴´�.
			if(!dir.exists()) { // ������ ���ٸ�
				// mkdirs() : ���������� ��� ���� ���� (���� �̸� �ȸ���� ���ǰ� ��Ʈ��)
				// mkdir() : ���������� ������ ���� �Ұ���
				dir.mkdirs(); 
			}
			// multi�� request ���Ƿ� request = null �Ǿ� multi ��ü ����ϸ� ��
			MultipartRequest multi = new MultipartRequest(req, SAVEFOLDER, MAXSIZE, 
					ENCODING, new DefaultFileRenamePolicy());
			
			// �����̳� ���� �ۼ����� �ʾҴٸ� 
			if(multi.getParameter("subject").trim().equals("") || 
					multi.getParameter("content").trim().equals("")) {
				return flag; // false ��ȯ
			}
			
			
			// ���Ͼ��ε� ���ߴٸ� ����Ʈ�� filename = null, filesize = 0�� DB�� �����
			String filename = null;
			int filesize = 0;
			
			// ReviewForm.jsp ���Ͼ��ε�� ������ name = filename
			if(multi.getFilesystemName("filename")!=null) {// ���Ͼ��ε� �ߴٸ�
				filename = multi.getFilesystemName("filename");
				filesize = (int)multi.getFile("filename").length(); // long -> int ĳ�����Ͽ� ����ũ�� ��������
			}
			
			con = pool.getConnection();
			sql = "INSERT INTO review(onum,rid,pnum,date,subject,content,score,filename,filesize) "
				+ "VALUES(?,?,?,now(),?,?,?,?,?) ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(multi.getParameter("onum"))); // multi�� object�� ���ϵǹǷ� ����ȯ�ؼ� �޾��ֱ�
			pstmt.setString(2, multi.getParameter("rid"));
			pstmt.setInt(3, Integer.parseInt(multi.getParameter("pnum"))); 
			pstmt.setString(4, multi.getParameter("subject"));
			pstmt.setString(5, multi.getParameter("content"));
			pstmt.setDouble(6, Double.parseDouble(multi.getParameter("score"))/2); // 0.5�������� �ޱ�
			pstmt.setString(7, filename);
			pstmt.setInt(8, filesize);
			
			// �������� �����̸� 1(������� �� ����) ����, �������̸� 0 ����
			if(pstmt.executeUpdate()==1) 
				flag = true; 
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	
	//////////////////////////////////////////////////// reviewBoard.jsp �Խ��� ���� �޼ҵ�
	
	
	// rnum�� �ִ밪 SELECT : �ֽű��� ���� ���� �� �� �ֵ��� ����� �޼ҵ�
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
				maxNum = rs.getInt(1); // �ҷ��� max num���� ����
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return maxNum;
	}
	
	// �� ���� �� SELECT : �˻��ϵ� ���ϵ� ���ǿ� �´� �� ���� �� �������� �޼ҵ� 
	public int getTotalCount(String keyField, String keyWord) { // keyField : id, subject, content ���� �� ����
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			// �˻��� �� �ƴ� �� �����ؼ� SELECT
			if(keyWord.trim().equals("") || keyWord==null) { // �˻��� �ƴ� ��
				sql = "SELECT COUNT(*) "
					+ "FROM review ";
				pstmt = con.prepareStatement(sql);
			} else { // �˻��� ��
				sql = "SELECT COUNT(*) "
					+ "FROM review "
					+ "WHERE " + keyField + " like ? "; // like '%test%'
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%"); // '' �ڵ����� �ٿ���
			}
			rs = pstmt.executeQuery();
			if(rs.next())
				totalCount = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount; // ��ü �Խñ� �� ��ȯ
	}
	
	
	// �� ���� �� SELECT : �˻��ϵ� ���ϵ� ���ǿ� �´� �� ���� �� �������� �޼ҵ� 
	public int getTotalCountByPnum(String keyField, String keyWord, int pnum) { // keyField : id, subject, content ���� �� ����
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			// �˻��� �� �ƴ� �� �����ؼ� SELECT
			if(keyWord.trim().equals("") || keyWord==null) { // �˻��� �ƴ� ��
				sql = "SELECT COUNT(*) "
					+ "FROM review "
					+ "WHERE pnum = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, pnum);
			} else { // �˻��� ��
				sql = "SELECT COUNT(*) "
					+ "FROM review "
					+ "WHERE " + keyField + " like ? AND " // like '%test%'
					+ "pnum = ? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%"); // '' �ڵ����� �ٿ���
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
		return totalCount; // ��ü �Խñ� �� ��ȯ
	}
	
	// Ư��id�� �� �� ���� �� SELECT 
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
		return totalCount; // ��ü �Խñ� �� ��ȯ
	}
	
	// �������� ������ ������ŭ ���� ���� SELECT : �˻��ϵ� ���ϵ� �����ϰ� ����Ǵ� �޼ҵ� 
	public Vector<ReviewBean> getReviewListByPnum(String keyField, String keyWord, int start, int cnt, int pnum) { /*�� �ΰ��� limit - SQL��*/
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ReviewBean> vlist = new Vector<ReviewBean>();
		try {
			con = pool.getConnection();
			if(keyWord==null||keyWord.trim().equals("")) { // �˻��� �ƴ� ��
				sql = "SELECT * "
					+ "FROM review "
					+ "WHERE pnum = ? "
					+ "ORDER BY rnum DESC "
					+ "LIMIT ?,? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, pnum);
				pstmt.setInt(2, start);
				pstmt.setInt(3, cnt);
			} else { // �˻��� �� 
				sql = "SELECT * "
					+ "FROM review "
					+ "WHERE " + keyField + " LIKE ? AND " // ������� �߿�!!
					+ "pnum = ? " 
					+ "ORDER BY rnum DESC "
					+ "LIMIT ?,? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+keyWord+"%"); // 2��° �Ű����� �ڸ��� ���ڿ��� �ڵ����� ����ǥ ���� '%keyWord%'
				pstmt.setInt(2, pnum);
				pstmt.setInt(3, start);
				pstmt.setInt(4, cnt);
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ReviewBean bean = new ReviewBean();
				
				// ����¡ó���� �ʿ��� �͸� ��������
				bean.setRnum(rs.getInt("rnum")); // �������
				bean.setRid(rs.getString("rid")); // ���� �ۼ��� id 
				bean.setPnum(rs.getInt("pnum")); // ��ǰ��ȣ 
				bean.setDate(rs.getString("date"));
				bean.setSubject(rs.getString("subject"));
				bean.setContent(rs.getString("content"));
				bean.setScore(rs.getDouble("score"));
				bean.setFilename(rs.getString("filename"));
				
				vlist.addElement(bean); // ���Ϳ� ��������� ���
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist; // ����Ʈ�� 10���� ��ȯ�ǰ�, ������ ��ȯ�� �� ����
	}
	
	
	// �������� ������ ������ŭ ���� ���� SELECT : �˻��ϵ� ���ϵ� �����ϰ� ����Ǵ� �޼ҵ� 
	public Vector<ReviewBean> getReviewList(String keyField, String keyWord, int start, int cnt) { /*�� �ΰ��� limit - SQL��*/
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ReviewBean> vlist = new Vector<ReviewBean>();
		try {
			con = pool.getConnection();
			if(keyWord==null||keyWord.trim().equals("")) { // �˻��� �ƴ� ��
				sql = "SELECT * "
					+ "FROM review "
					+ "ORDER BY rnum DESC "
					+ "LIMIT ?,? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, cnt);
			} else { // �˻��� �� 
				sql = "SELECT * "
					+ "FROM review "
					+ "WHERE " + keyField + " LIKE ? " // ������� �߿�!!
					+ "ORDER BY rnum DESC "
					+ "LIMIT ?,? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+keyWord+"%"); // 2��° �Ű����� �ڸ��� ���ڿ��� �ڵ����� ����ǥ ���� '%keyWord%'
				pstmt.setInt(2, start);
				pstmt.setInt(3, cnt);
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ReviewBean bean = new ReviewBean();
				
				// ����¡ó���� �ʿ��� �͸� ��������
				bean.setRnum(rs.getInt("rnum")); // �������
				bean.setRid(rs.getString("rid")); // ���� �ۼ��� id 
				bean.setPnum(rs.getInt("pnum")); // ��ǰ��ȣ 
				bean.setDate(rs.getString("date"));
				bean.setSubject(rs.getString("subject"));
				bean.setContent(rs.getString("content"));
				bean.setScore(rs.getDouble("score"));
				bean.setFilename(rs.getString("filename"));
				
				vlist.addElement(bean); // ���Ϳ� ��������� ���
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist; // ����Ʈ�� 10���� ��ȯ�ǰ�, ������ ��ȯ�� �� ����
	}
	
	
	// myReview�� ����
	// �������� ������ ������ŭ ���� ���� SELECT : �˻��ϵ� ���ϵ� �����ϰ� ����Ǵ� �޼ҵ� 
	public Vector<ReviewBean> getReviewList(String keyField, String keyWord, int start, int cnt, String id) { /*�� �ΰ��� limit - SQL��*/
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ReviewBean> vlist = new Vector<ReviewBean>();
		try {
			con = pool.getConnection();
			if(keyWord==null||keyWord.trim().equals("")) { // �˻��� �ƴ� ��
				sql = "SELECT * "
					+ "FROM review "
					+ "WHERE rid = ? "
					+ "ORDER BY rnum DESC "
					+ "LIMIT ?,? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setInt(2, start);
				pstmt.setInt(3, cnt);
			} else { // �˻��� �� 
				sql = "SELECT * "
					+ "FROM review "
					+ "WHERE rid = ? AND " + keyField + " LIKE ? " // ������� �߿�!!
					+ "ORDER BY rnum DESC "
					+ "LIMIT ?,? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setString(2, "%"+keyWord+"%"); // 2��° �Ű����� �ڸ��� ���ڿ��� �ڵ����� ����ǥ ���� '%keyWord%'
				pstmt.setInt(3, start);
				pstmt.setInt(4, cnt);
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ReviewBean bean = new ReviewBean();
				
				// ����¡ó���� �ʿ��� �͸� ��������
				bean.setRnum(rs.getInt("rnum")); // �������
				bean.setRid(rs.getString("rid")); // ���� �ۼ��� id 
				bean.setPnum(rs.getInt("pnum")); // ��ǰ��ȣ 
				bean.setDate(rs.getString("date"));
				bean.setSubject(rs.getString("subject"));
				bean.setContent(rs.getString("content"));
				bean.setScore(rs.getDouble("score"));
				bean.setFilename(rs.getString("filename"));
				
				vlist.addElement(bean); // ���Ϳ� ��������� ���
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist; // ����Ʈ�� 10���� ��ȯ�ǰ�, ������ ��ȯ�� �� ����
	}
	
	
	// �� ���� ���� �б� SELECT 
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
				// ��� ��� �÷� �����ؾ߸� �������� ���� �б� ����
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
		return bean; // �����б⿡ �ʿ��� ���� ����
	}
	
	
	// ���� ���� DELETE : ���ε� ���� �ֵ� ���� ����
	public void deleteReview(int rnum, String filename/*DB ��ȸ ���ϰ�, ��Ŭ���� stroage ���� ��ȸ*/) {
		// DB��ȸ ���ϴ� ���� : ������ ������ ���� DB ��ġ�鼭 ���� ���ڵ� �� �����ϴµ�, filename ��ȸ�� �� DB ��ġ�� �������� ��ġ�Ƿ� �������� ��ȸ
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			if(filename!=null&&!filename.equals("")) { // ���ε� ���� �ִ� ������
				File f = new File(SAVEFOLDER+filename); // ���� ��ü ����
				if(f.exists()) { // storage ������ ������ �����Ѵٸ�
					f.delete(); // ����
				}
			}
			con = pool.getConnection();
			sql = "DELETE FROM review "
				+ "WHERE rnum = ? "; // �Խñ� �������� ��ȸ�Ͽ� ����
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, rnum);
			pstmt.executeUpdate(); // ����
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	
	// ������ư ������ �ٽ� reviewForm.jsp �̵��ؼ� ������ ���ο� multi ��ü�� �Ѿ�� ����
	// ���� ���� : ���ε� ���ϱ��� ���� ����
	public void updateReview(MultipartRequest multi) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			
			// reviewForm.jsp���� rnum �޾Ƽ� int�� ��ȯ <- SQL ���ǹ��� �ʿ�
			int rnum = Integer.parseInt(multi.getParameter("rnum")); 
			
			// ���ο� ���� �Ӽ���
			String subject = multi.getParameter("subject");
			String content = multi.getParameter("content");
			double score = (Double.parseDouble(multi.getParameter("score"))/2);// 0.5�������� �ޱ�
			String filename = multi.getFilesystemName("filename"); // !!���ο� ���ϸ�!!
			
			if(filename!=null&&!filename.equals("")) { // ���� ���ϸ� ���ε��� �� ������ ���������� ������ ������
				ReviewBean bean = getReview(rnum); // DB ��ȸ�Ͽ� ���� ���� ������ ����� ��������
				String originFile = bean.getFilename(); // !!���� ���ϸ�!!
				if(originFile!=null&&!originFile.equals("")) { // ���� ���� �����ߴٸ�
					File f = new File(SAVEFOLDER+originFile);
					if(f.exists()) { 
						f.delete(); // storage������ ���� ���� ���� (DB�Ȱ�ħ)
					}
				}
				// ���ο� ���ε� ����ũ�� 
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
			} else { // ���� ���ε� ���ߴٸ� �������� ����
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
	
	
	// ������ ��� �ۼ�
	public void insertRComment(RCommentBean rBean) { // jsp ������ bean.setXXX 
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
	
	// �̹� �������� onum���� Ȯ���ϴ� �޼ҵ�
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
				flagForCheckReviewInsert = true; // �̹� �����ٸ� true ��ȯ
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flagForCheckReviewInsert;
	}
	
	
	
	
	// (�׽�Ʈ�� �޼ҵ�) Post 1000 : (�� �������� 10���� �Խñ�)1000���� �Խù� �Է� 
	public void post1000(){
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "INSERT review(onum,rid,pnum,date,subject,content,score,filename,filesize) "
				+ "VALUES (?, 'bbb', 1, now(),'Hello','World!', 3, null, 0);";
			pstmt = con.prepareStatement(sql);
			// 1000�� �ݺ�
			for (int i = 0; i < 500; i++) {
				pstmt.setInt(1, i+1);
				pstmt.executeUpdate(); // ����
			}
			System.out.println("Post1000 Success"); 
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	// ���θ޼ҵ�
	public static void main(String[] args) {
		ReviewMgr rMgr = new ReviewMgr(); 
		rMgr.post1000(); // �׽�Ʈ�� 1000�� ���ڵ� �Է� �޼ҵ� ȣ��
	}
	
}
