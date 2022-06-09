package com.snackking.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.snackking.mapper.MemberMapper;
import com.snackking.model.MemberDTO;

@Service
public class MemberServiceImpl implements MemberService{

	@Autowired
	MemberMapper memberMapper;
	
	@Override
	public void memberJoin(MemberDTO member) throws Exception {
		memberMapper.memberJoin(member);
	}

}
