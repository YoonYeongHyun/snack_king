package com.snackking.model;

public class ManagerDTO {
	private String managerId;
	private String managerPwd;
	
	public String getManagerId() {
		return managerId;
	}
	public void setManagerId(String managerId) {
		this.managerId = managerId;
	}
	public String getManagerPwd() {
		return managerPwd;
	}
	public void setManagerPwd(String managerPwd) {
		this.managerPwd = managerPwd;
	}
	@Override
	public String toString() {
		return "ManagerDTO [managerId=" + managerId + ", managerPwd=" + managerPwd + "]";
	}
}
