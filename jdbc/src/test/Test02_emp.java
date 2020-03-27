package test;

import java.sql.Connection;
import java.sql.PreparedStatement;
//import java.sql.Statement;
import java.sql.ResultSet;
//import java.sql.DriverManager;

import javax.swing.JOptionPane;

import util.JdbcUtil;

public class Test02_emp {

	public static void main(String[] args) {
		System.out.println("JDBC TEST START");

		// .properties
//		String driver = "oracle.jdbc.OracleDriver";
//		String url = "jdbc:oracle:thin:@127.0.0.1:1521:xe";
//		String user = "SCOTT";
//		String pw = "TIGER";
		
		String sql = "select * from emp";
		sql = "select * from emp where deptno = ?";		// ? : PreparedStatement O
														//	 : Statement X
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;		
		
		try {
			
//			Class.forName(driver);		
//			con = DriverManager.getConnection(url, user, pw);
			
			// line 19-22, 34-35
			con = JdbcUtil.getConnection();
			
			ps = con.prepareStatement(sql);
			
			
			// Setting ?** value
			String deptno_s = JOptionPane.showInputDialog("deptno"); 
			ps.setInt(1, Integer.parseInt(deptno_s));
//			ps.setInt(1, 20);
//			ps.setInt(2, 20);	// 등으로 사용 가능
			
			rs = ps.executeQuery();
			
			// data converting
			// rs -> Java class
			// row -> int
						
			// rs has cursor.
			// rs.next()		// true or false
			
			while(rs.next()) {
				System.out.printf("|%6s|%12s|%10s|\n", rs.getString("empno"),
						rs.getString("ename"), rs.getString("sal"));
				System.out.println(rs.getDate("hiredate"));		// date
			}
			
			System.out.println(con);
			
		} catch (Exception e) {
			System.out.println(e);
			
		} finally {
//			try {
//				if(rs != null) rs.close();
//				if(ps != null) ps.close();
//				if(con != null) con.close();
//			} catch (Exception e2) {
//				System.out.println(e2);
//			}
			
			JdbcUtil.close(con, ps, rs);
			
		}
		
		System.out.println("JDBC TEST END");
		
	}

}
