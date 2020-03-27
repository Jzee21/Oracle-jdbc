package proc_test01;

public class UserVO {
	
	private int user_no;
	private String user_id;
	private String user_pw;
	private String name;
	private boolean role;
	
	public UserVO() {
		super();
	}

	public UserVO(int user_no, String user_id, String user_pw, String name, boolean role) {
		super();
		this.user_no = user_no;
		this.user_id = user_id;
		this.user_pw = user_pw;
		this.name = name;
		this.role = role;
	}

	public int getUser_no() {
		return user_no;
	}
	
	// 사용 금지
//	public void setUser_no(int user_no) {
//		this.user_no = user_no;
//	}

	public String getUser_id() {
		return user_id;
	}

	// 사용 금지
//	public void setUser_id(String user_id) {
//		this.user_id = user_id;
//	}

	public String getUser_pw() {
		return user_pw;
	}

	public void setUser_pw(String user_pw) {
		this.user_pw = user_pw;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public boolean isRole() {
		return role;
	}

	public void setRole(boolean role) {
		this.role = role;
	}

	@Override
	public String toString() {
		return "UserVO [user_no=" + user_no + ", user_id=" + user_id + ", user_pw=" + user_pw + ", name=" + name
				+ ", role=" + role + "]";
	}
	
}
