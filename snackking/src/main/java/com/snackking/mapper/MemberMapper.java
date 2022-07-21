package com.snackking.mapper;

import java.util.List;

import com.snackking.model.BuyDTO;
import com.snackking.model.MemberDTO;
import com.snackking.model.ReviewDTO;

public interface MemberMapper {
	
	public void memberJoin(MemberDTO member);
	public int idCheck(String id);

	public int memberLogin_id(MemberDTO member);
	public int memberLogin_id_pwd(MemberDTO member);
	
	public MemberDTO getMemberInfo(MemberDTO member);
	public List<BuyDTO> getBuyInfo_mypageMain(MemberDTO member);
	
	public int confirmPassword(MemberDTO member);
	public void updateMemberInfo(MemberDTO member);
	
	public List<ReviewDTO> getReviewList(ReviewDTO review);
	
}
