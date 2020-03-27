package test;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.JdbcUtil;

public class Jdbc_Template {

	public static void main(String[] args) {
		
	}
	
	// JDBC Template
	public void temp() {
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;			// select 문
		int row = 0;					// insert, delete, update	// ? row inserted*
		
		String sql = "";
		
		try {
			
			con = JdbcUtil.getConnection();
			ps = con.prepareStatement(sql);
			// ? value setting
//			ps.setInt(1, Integer.parseInt(deptno_s));
			
			rs = ps.executeQuery();
			row = ps.executeUpdate();	// dml
			
			// result use
			
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(con, ps, rs);
		}
		//
	}
	
	
}
