package com.snackking.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.snackking.mapper.MemberMapper;
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

}
