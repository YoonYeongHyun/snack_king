package com.snackking.service;

import java.util.List;

import com.snackking.model.BuyDTO;
import com.snackking.model.MemberDTO;
import com.snackking.model.ReviewDTO;

public interface MemberService {

	public void memberJoin(MemberDTO member) throws Exception;
	public int idCheck(String id) throws Exception;

	public int memberLogin_id(MemberDTO member);
	public int memberLogin_id_pwd(MemberDTO member);
    
	public MemberDTO getMemberInfo(MemberDTO member);
	public List<BuyDTO> getBuyInfo_mypageMain(MemberDTO member);

	//회원정보 수정 관련
	public int confirmPassword(MemberDTO member);
	public void updateMemberInfo(MemberDTO member);
	public List<ReviewDTO> getReviewList(ReviewDTO review);
}
