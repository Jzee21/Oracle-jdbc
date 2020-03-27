package proc_test01;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.sql.ResultSet;

public class JdbcUtil {
	
	public static Connection getConnection() {
		
		String driver = "oracle.jdbc.OracleDriver";
		String url = "jdbc:oracle:thin:@127.0.0.1:1521:xe";
//		String url = "jdbc:oracle:thin:@70.12.60.92:1521:xe";
		String user = "SCOTT";
		String pw = "TIGER";
		
		Connection con = null;
		
		try {
			
			Class.forName(driver);		
			
			con = DriverManager.getConnection(url, user, pw);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return con;
	}
	
	public static void close(Connection con, Statement ps, ResultSet rs ) {
		
		try {
			if(rs != null) rs.close();
			if(ps != null) ps.close();
			if(con != null) con.close();
		} catch (Exception e2) {
			System.out.println(e2);
		}
		
	}
	
	
}
