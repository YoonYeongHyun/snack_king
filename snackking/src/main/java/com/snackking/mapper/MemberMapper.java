package com.snackking.mapper;

import java.util.HashMap;

import com.snackking.model.MemberDTO;

public interface MemberMapper {
	
	public void memberJoin(MemberDTO member);
	public int idCheck(String id);

	public int memberLogin(MemberDTO member);
}
