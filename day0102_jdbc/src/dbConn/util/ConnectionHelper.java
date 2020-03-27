package dbConn.util;

import java.sql.Connection;
//import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/*
 * 반복적인 DB 연결 정보 해결
 * 다른 클래스에서 아래의 코드를 구현하지 않도록 설꼐
*/



public class ConnectionHelper {
	
	// Tester
//	public static void main(String[] args) {
//		Connection conn = ConnectionHelper.getConnection("oracle");
//	}
	
	public static Connection getConnection(String dsn) {
		
		Connection conn = null;
		
		try {
			
			if(dsn.equals("mysql")) {
				
				Class.forName("com.mysql.jdbc.Driver");
				conn = DriverManager.getConnection(
						"jdbc:mysql://localhost:3306/{db_name}", 
						"jzee", "1234");
				
			} else if(dsn.equals("oracle")) {
				
				Class.forName("oracle.jdbc.driver.OracleDriver");
				conn = DriverManager.getConnection(
						"jdbc:oracle:thin:@localhost:1521:xe", 
						"jzee", "1234");
				System.out.println("success");
				
			} // if
			
		} catch (Exception e) {

		} finally {
			return conn;
		} // try
				
	} // getConnection()
	
	public static Connection getConnection(String dsn, String user, String pwd) {
		
		Connection conn = null;
		
		try {
			
			if(dsn.equals("mysql")) {
				
				Class.forName("com.mysql.jdbc.Driver");
				conn = DriverManager.getConnection(
						"jdbc:mysql://localhost:3306/{db_name}", 
						user, pwd);
				
			} else if(dsn.equals("oracle")) {
				
				Class.forName("oracle.jdbc.driver.OracleDriver");
				conn = DriverManager.getConnection(
						"jdbc:oracle:thin:@localhost:1521:xe", 
						user, pwd);
				System.out.println("success");
				
			} // if
			
		} catch (Exception e) {

		} finally {
			return conn;
		} // try
				
	} // getConnection()
	
	
} // class ConnectionHelper


/*
aaaaa
//*/

//*		<- add front /
//aaaaa
//*/

/*
public static void main(String[] args) {
	try {
	
		Class.forName("oracle.jdbc.driver.OracleDriver");
		System.out.println("Load Success");
		
		Connection conn = DriverManager.getConnection(
				"jdbc:oracle:thin:@localhost:1521:xe", 
				"jzee", "1234");
		System.out.println("Conn Success");
		
		//------/
		ConnvtionHelper.getConnection("mysql") or ("oracle")
		dsn ==> data source name


	} catch (ClassNotFoundException e) {
		System.out.println("Driver Load Fail");
		System.out.println(e.getMessage());
		e.printStackTrace();
	} catch (SQLException e) {
		System.out.println("Connection Fail");
		System.out.println(e.getMessage());
		e.printStackTrace();
		System.out.println(e.getStackTrace());
	}
}
//*/