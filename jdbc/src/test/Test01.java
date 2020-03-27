package test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class Test01 {

	public static void main(String[] args) {
		System.out.println("JDBC TEST START");
		
		// 0. Driver Setting.
		//	 project - RClick - Build Path - Configure Build Path...
		//	  - Libraries - Add External JARs...
		
		// .properties
		String driver = "oracle.jdbc.OracleDriver";	// class path?
		String url = "jdbc:oracle:thin:@127.0.0.1:1521:xe";
		String user = "SCOTT";
		String pw = "TIGER";
		
		String sql = "select * from dept";
//		sql = "select * from emp where deptno = ?";	// val binding 	// ? - process by ps(PreparedStatement)
																	// Statement : impossible
										// Test01_emp.java
		
		Connection con = null;
//		Statement st = null;			// parent	
		PreparedStatement ps = null;	// child	// management sqls
		ResultSet rs = null;			// result	// rowSet
		
		
		try {
			// 1. Driver Loading
			Class.forName(driver);		// on Memory	// not at compile
										// not New		// Singleton
			// 2. Request Connection
			con = DriverManager.getConnection(url, user, pw);
			
			// 3. Create Statment from connection
			ps = con.prepareStatement(sql);
			
			// 4. Execution sql by Statment (execute, executeUpdate, executeQuery)
			rs = ps.executeQuery();
			
			// 5. Process result (ResultSet, int)
			while(rs.next()) {
				System.out.printf("|%-4s|%12s|%10s|\n", rs.getString("deptno"),
						rs.getString("dname"), rs.getString("loc"));
			}
			
			System.out.println(con);
			
		} catch (Exception e) {
			// 6. Try Catch
			System.out.println(e);
			
		} finally {
			// 7. Return Resource
			try {
				if(rs != null) rs.close();
				if(ps != null) ps.close();
				if(con != null) con.close();
			} catch (Exception e2) {
				System.out.println(e2);
			}
			
		}
		
		System.out.println("JDBC TEST END");
		
	}

}
