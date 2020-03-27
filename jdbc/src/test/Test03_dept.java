package test;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
//import java.util.Iterator;
import java.util.List;

import dao.DeptDAO;
import dao.UserDAO;
import util.JdbcUtil;
import vo.DeptVO;
import vo.UserVO;

public class Test03_dept {

	public static void main(String[] args) {
		
//		DeptDAO dao = new DeptDAO();
		
//		Iterator<DeptVO> it = deptList().iterator();
//		while(it.hasNext()) {
//			System.out.println(it.next());
//		}
//		for(DeptVO data :dao.deptList()) {
//			System.out.printf("|%4d | %-12s| %-10s|\n", 
//					data.getDeptno(), data.getDname(), data.getLoc());
//		}
		
		UserDAO udao = new UserDAO();
		UserVO user = udao.login("user01", "1234");
		if(user != null) {
			System.out.printf("|%2d | %-12s| %-12s| %b|\n", 
					user.getUser_no(), user.getUser_id(), 
					user.getName(),user.isRole()
					);
		}

	}
	
	public List<DeptVO> deptList() {
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;			// select 문
		
		String sql = "select * from dept";
		
		List<DeptVO> list = new ArrayList<DeptVO>();
		
		try {
			
			con = JdbcUtil.getConnection();
			ps = con.prepareStatement(sql);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				DeptVO vo = new DeptVO(
						Integer.parseInt(rs.getString("deptno")),
						rs.getString("dname"),
						rs.getString("loc")
						);
				list.add(vo);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(con, ps, rs);
		}
		
		return list;
		
	}

}
