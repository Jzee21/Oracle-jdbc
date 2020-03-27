package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.JdbcUtil;
import vo.UserVO;

public class UserDAO {
	
	public UserVO login(String id,String pw) {
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		String sql =
				"select * from USERS " + 
				"where user_id = ? and user_pw = ?";
		
		UserVO user = null;
		
		try {
			
			con = JdbcUtil.getConnection();
			ps = con.prepareStatement(sql);

			ps.setString(1, id);
			ps.setString(2, pw);
			
			rs = ps.executeQuery();
			
			if(rs.next()) {
				user = new UserVO(
						Integer.parseInt(rs.getString("user_no")),
						rs.getString("user_id"),
						rs.getString("user_pw"),
						rs.getString("name"),
						rs.getString("role").equals("1") ? true : false
						);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(con, ps, rs);
		}
		
		return user;
	}
	
	// after login~
	
	public void setPW(UserVO user, String pw) {
		// Change PW
	}
	
	public void setRole(UserVO user, boolean bool) {
		// Change role
		// true  : 1 : admin 
		// false : 0 : general user
	}
	
}
