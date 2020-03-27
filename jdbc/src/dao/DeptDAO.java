package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.JdbcUtil;
import vo.DeptVO;

public class DeptDAO {
	
	public void insertDept(String dname, String loc) {
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;			// select 문
		int row = 0;					// insert, delete, update	// ? row inserted*
		
		String sql = 
				"insert into dept (deptno, dname, loc) " 
				+ "values((select nvl(max(deptno), 0)+1 from dept), ?, ?)";
		
		try {
			
			con = JdbcUtil.getConnection();
			ps = con.prepareStatement(sql);
			// ? value setting
			ps.setString(1, dname);
			ps.setString(2, loc);
			row = ps.executeUpdate();	// dml
			
			System.out.printf("[%d row data inserted]\n", row);
			
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(con, ps, rs);
		}
		//
	}
	
	public void deleteDept(int deptno) {
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;			// select 문
		int row = 0;					// insert, delete, update	// ? row inserted*
		
		String sql = "delete from dept where deptno = ?";
		
		try {
			
			con = JdbcUtil.getConnection();
			ps = con.prepareStatement(sql);
			// ? value setting
			ps.setInt(1, deptno);
			
			row = ps.executeUpdate();	// dml
			
			// result use
			System.out.printf("[%d row data deleted]\n", row);
			
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(con, ps, rs);
		}
		//
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
