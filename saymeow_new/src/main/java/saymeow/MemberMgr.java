package saymeow;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


public class MemberMgr {

	private DBConnectionMgr pool;
	
	public MemberMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//ID 중복확인
	public boolean checkId(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag  = false;
		try {
			con = pool.getConnection();
			sql = "select id from member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			flag = rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	

	//회원가입
	public boolean insertMember(MemberBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert member(id,pwd,name,birthday,phone,email,"
					+ "address,petName,petAge,petGender,petBreed)"
					+ "values(?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getId());
			pstmt.setString(2, bean.getPwd());
			pstmt.setString(3, bean.getName());
			pstmt.setString(4, bean.getBirthday());
			pstmt.setString(5, bean.getPhone());
			pstmt.setString(6, bean.getEmail());
			pstmt.setString(7, bean.getAddress());
			pstmt.setString(8, bean.getPetName());
			pstmt.setString(9, bean.getPetAge());
			pstmt.setInt(10, bean.getPetGender());
			pstmt.setString(11, bean.getPetBreed());
			if(pstmt.executeUpdate()==1)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	//로그인
	public int loginMember(String id, String pwd) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int mode = 2; // 회원정보없음 디폴트 2
		try {
			con = pool.getConnection();
			sql = "select id, pwd from member where id = ? and pwd = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if(rs.getString(1)=="admin" || rs.getString(1).trim().equals("admin")) {
					mode = 1; // 관리자모드
				} else {
					mode = 0; // 회원
				}
			} 
			// 조회값 없는 경우 mode = 2 유지된 채로 리턴됨
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return mode;
	}
	
	
	//회원정보 가져오기
	public MemberBean getMember(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		MemberBean bean = new MemberBean();
		try {
			con = pool.getConnection();
			sql = "select * from member where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setId(rs.getString("id"));
				bean.setPwd(rs.getString("pwd"));
				bean.setName(rs.getString("name"));
				bean.setBirthday(rs.getString("birthday"));
				bean.setPhone(rs.getString("phone"));
				bean.setEmail(rs.getString("email"));
				bean.setAddress(rs.getString("address"));
				bean.setGrade(rs.getInt("grade"));
				bean.setMode(rs.getInt("mode"));
				bean.setPetName(rs.getString("petName"));
				bean.setPetAge(rs.getString("petAge"));
				bean.setPetGender(rs.getInt("petGender"));
				bean.setPetBreed(rs.getString("petBreed"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	   //회원정보 수정
	   public boolean updateMember(MemberBean bean) {
	      Connection con = null;
	      PreparedStatement pstmt = null;
	      String sql = null;
	      boolean flag = false;
	      try {
	         con = pool.getConnection();
	         sql = "update member set pwd=?, name=?, birthday=?,"
	               + " phone=?, email=?, address=?,"
	               + " petName=?, petAge=?, petGender=?, petBreed=? where id=?";
	         pstmt = con.prepareStatement(sql);
	         pstmt.setString(1, bean.getPwd());
	         pstmt.setString(2, bean.getName());
	         pstmt.setString(3, bean.getBirthday());
	         pstmt.setString(4, bean.getPhone());
	         pstmt.setString(5, bean.getEmail());
	         pstmt.setString(6, bean.getAddress());
	         pstmt.setString(7, bean.getPetName());
	         pstmt.setString(8, bean.getPetAge());
	         pstmt.setInt(9, bean.getPetGender());
	         pstmt.setString(10, bean.getPetBreed());
	         pstmt.setString(11, bean.getId());
	         if(pstmt.executeUpdate()==1)
	            flag = true;
	      } catch (Exception e) {
	         e.printStackTrace();
	      } finally {
	         pool.freeConnection(con, pstmt);
	      }
	      return flag;
	   }
	//회원탈퇴
		public boolean deleteMember(String id) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			boolean flag = false;
			try {
				con = pool.getConnection();
				sql = "delete from member where id = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				if(pstmt.executeUpdate()==1);
				flag = true;
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return flag;
		}
		
		//아이디찾기
		public String findId(String name, String email) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			String mid = null;
			try {
				con = pool.getConnection();
				sql = "select id from member where name=? and email=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, name);
				pstmt.setString(2, email);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					mid = rs.getString("id");
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return mid;
		}
		
		//비밀번호 찾기
		public String findPwd(String mid, String email) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			String pwd = null;
			try {
				con = pool.getConnection();
				sql = "select pwd from member where id=? and email=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, mid);
				pstmt.setString(2, email);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					pwd = rs.getString("pwd");
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return pwd;
		}
		
	}