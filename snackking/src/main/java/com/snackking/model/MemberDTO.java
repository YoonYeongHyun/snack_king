package com.snackking.model;

import java.sql.Timestamp;
import lombok.Data;

@Data
public class MemberDTO {
	private String id;
	private String pwd;
	private String name;
	private String email;
	private String tel;
	private String addrNum;
	private String addr1;
	private String addr2;
	private Timestamp regDate;
		
}
