package com.snackking.mapper;

import java.util.List;

import com.snackking.model.BuyDTO;
import com.snackking.model.MemberDTO;

public interface MemberMapper {
	
	public void memberJoin(MemberDTO member);
	public int idCheck(String id);

	public int memberLogin_id(MemberDTO member);
	public int memberLogin_id_pwd(MemberDTO member);
	
	public MemberDTO getMemberInfo(String id);
	public List<BuyDTO> getBuyInfo_mypageMain(String id);
}
