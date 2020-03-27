package app;

import dao.DeptDAO;
import vo.DeptVO;

public class Application {

	public static void main(String[] args) {
		DeptDAO dao = new DeptDAO();
		
//		dao.insertDept("메롱", "재영");
//		dao.deleteDept(52);
		for(DeptVO data :dao.deptList()) {
			System.out.printf("|%4d | %-12s| %-10s|\n", 
					data.getDeptno(), data.getDname(), data.getLoc());
		}
		
		System.out.println("END");
	}

}
