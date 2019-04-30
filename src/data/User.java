package data;

public class User {
//	`id` int(16) NOT NULL AUTO_INCREMENT,
//	  `username` varchar(128) NOT NULL,
//	  `password` varchar(128) NOT NULL,
//	  `email` varchar(255) DEFAULT NULL,
	private Integer id;
	private String username;
	private String password;
	private String email;
	private String weixin;
	private String simpleDesc;
	private String identity;
	
	public String getWeixin() {
		return weixin;
	}
	public void setWeixin(String weixin) {
		this.weixin = weixin;
	}
	public String getSimpleDesc() {
		return simpleDesc;
	}
	public void setSimpleDesc(String simpleDesc) {
		this.simpleDesc = simpleDesc;
	}
	public String getIdentity() {
		return identity;
	}
	public void setIdentity(String identity) {
		this.identity = identity;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	

}
