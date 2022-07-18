package com.snackking.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.snackking.mapper.MemberMapper;
import com.snackking.model.BuyDTO;
import com.snackking.model.MemberDTO;

@Service
public class MemberServiceImpl implements MemberService{

	@Autowired
	MemberMapper memberMapper;
	
	@Override
	public void memberJoin(MemberDTO member) {
		memberMapper.memberJoin(member);
	}

	@Override
	public int idCheck(String id) throws Exception{

		return memberMapper.idCheck(id);
	}

	@Override
	public int memberLogin_id(MemberDTO member) {	
		return memberMapper.memberLogin_id(member);
	}
	
	@Override
	public int memberLogin_id_pwd(MemberDTO member) {	
		return memberMapper.memberLogin_id_pwd(member);
	}

	@Override
	public MemberDTO getMemberInfo(String id) {

		return memberMapper.getMemberInfo(id);
	}
	
	@Override
	public List<BuyDTO> getBuyInfo_mypageMain(String id) {
		return memberMapper.getBuyInfo_mypageMain(id);
	}

	@Override
	public int confirmPassword(MemberDTO member) {

		return memberMapper.confirmPassword(member);
	}

	@Override
	public void updateMemberInfo(MemberDTO member) {
		memberMapper.updateMemberInfo(member);
	}

}
