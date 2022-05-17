package kr.co.smf.system.agent;

import java.io.Serializable;

public class Agent implements Serializable {
	private String agentIpAddress;
	private int uniqueNumber;
	private String userPhoneNumber;
	private String name;

	public Agent() {
	}

	public int getUniqueNumber() {
		return uniqueNumber;
	}

	public void setUniqueNumber(int uniqueNumber) {
		this.uniqueNumber = uniqueNumber;
	}

	public String getAgentIpAddress() {
		return agentIpAddress;
	}

	public void setAgentIpAddress(String agentIpAddress) {
		this.agentIpAddress = agentIpAddress;
	}

	public String getUserPhoneNumber() {
		return userPhoneNumber;
	}

	public void setUserPhoneNumber(String userPhoneNumber) {
		this.userPhoneNumber = userPhoneNumber;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
}
