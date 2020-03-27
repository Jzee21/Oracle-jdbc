package test;

import java.sql.Connection;
import java.sql.PreparedStatement;
//import java.sql.Statement;
import java.sql.ResultSet;
//import java.sql.DriverManager;

import javax.swing.JOptionPane;

import util.JdbcUtil;

public class Test02_emp2_simple {

	public static void main(String[] args) {

		String sql = "select * from emp";
		sql = "select * from emp where deptno = ?";

		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;		
		
		try {
			
			con = JdbcUtil.getConnection();
			
			ps = con.prepareStatement(sql);
			
			
			String deptno_s = JOptionPane.showInputDialog("deptno"); 
			ps.setInt(1, Integer.parseInt(deptno_s));
			
			rs = ps.executeQuery();
			while(rs.next()) {
				System.out.printf("|%6s|%12s|%10s|\n", rs.getString("empno"),
						rs.getString("ename"), rs.getString("sal"));
				System.out.println(rs.getDate("hiredate"));		// date
			}
			
			System.out.println(con);
			
		} catch (Exception e) {
			System.out.println(e);
			
		} finally {
			JdbcUtil.close(con, ps, rs);
		}
		
		System.out.println("JDBC TEST END");
		
	}

}
