package kr.co.smf.system.user;

import java.io.Serializable;

public class User implements Serializable {
	private String phoneNumber;
	private int no;
	private String password;
	private String name;
	private String mail;
	private char permission;

	
	
	@Override
	public String toString() {
		return "User [phoneNumber=" + phoneNumber + ", no=" + no + ", password=" + password + ", name=" + name
				+ ", mail=" + mail + ", permission=" + permission + "]";
	}

	public User() {
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getMail() {
		return mail;
	}

	public void setMail(String mail) {
		this.mail = mail;
	}

	public char getPermission() {
		return permission;
	}

	public void setPermission(char permission) {
		this.permission = permission;
	}
}
