package com.snackking.service;

import java.util.List;

import com.snackking.model.BuyDTO;
import com.snackking.model.MemberDTO;

public interface MemberService {

	public void memberJoin(MemberDTO member) throws Exception;
	public int idCheck(String id) throws Exception;

	public int memberLogin_id(MemberDTO member);
	public int memberLogin_id_pwd(MemberDTO member);
    
	public MemberDTO getMemberInfo(String id);
	public List<BuyDTO> getBuyInfo_mypageMain(String id);
}
