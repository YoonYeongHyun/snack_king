package com.snackking.service;

import java.util.HashMap;

import org.apache.ibatis.annotations.Param;

import com.snackking.model.MemberDTO;

public interface MemberService {

	public void memberJoin(MemberDTO member) throws Exception;
	public int idCheck(String id) throws Exception;

	public int memberLogin_id(MemberDTO member);
	public int memberLogin_id_pwd(MemberDTO member);
    
}
