package kr.co.smf.system.agent;

import java.io.Serializable;

public class Agent implements Serializable {
	private String agentIpAddress;
	private int no;
	private String userPhoneNumber;
	private String agentName;

	@Override
	public String toString() {
		return "Agent [agentIpAddress=" + agentIpAddress + ", no=" + no + ", userPhoneNumber=" + userPhoneNumber
				+ ", agentName=" + agentName + "]";
	}

	public Agent() {
	}

	public String getAgentIpAddress() {
		return agentIpAddress;
	}

	public void setAgentIpAddress(String agentIpAddress) {
		this.agentIpAddress = agentIpAddress;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getUserPhoneNumber() {
		return userPhoneNumber;
	}

	public void setUserPhoneNumber(String userPhoneNumber) {
		this.userPhoneNumber = userPhoneNumber;
	}

	public String getAgentName() {
		return agentName;
	}

	public void setAgentName(String agentName) {
		this.agentName = agentName;
	}
}
