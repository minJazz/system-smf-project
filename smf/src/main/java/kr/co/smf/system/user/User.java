package kr.co.smf.system.user;

import java.io.Serializable;

public class User implements Serializable {
	private int uniqueNumber;
	private String phoneNumber;
	private String password;
	private String name;
	private String mail;
	private char permission;

	public User() {
	}

	public int getUniqueNumber() {
		return uniqueNumber;
	}

	public void setUniqueNumber(int uniqueNumber) {
		this.uniqueNumber = uniqueNumber;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
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
