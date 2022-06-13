package com.snackking.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.snackking.model.MemberDTO;
import com.snackking.service.MemberService;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Controller
@RequestMapping(value = "/member")
public class MemberController {

	@Autowired
	private MemberService memberService;
	
	//회원가입 페이지 이동
	@RequestMapping(value = "join", method = RequestMethod.GET)
	public void joinGET() {
		log.info("회원가입 페이지 진입");
	}
	
	//회원가입
	@RequestMapping(value = "join", method = RequestMethod.POST)
	public String JoinPOST(MemberDTO member) throws Exception{
		log.info("회원가입 시작");
		memberService.memberJoin(member);
		
		log.info("회원가입 성공");
		return "redirect:/main";
	}
	
	@RequestMapping(value="/memberIdChk", method = RequestMethod.POST)
	@ResponseBody
	public String memberIdChkPOST(String id) throws Exception{
		log.info("아이디 중복확인 진입");
		System.out.println("----------------------------");
		System.out.println(id);
		int result = memberService.idCheck(id);
		if(result != 0) {
			return "No";	// 중복 아이디가 존재
		}
		else {
			return "Okay";	// 중복 아이디 x
		}
	}
	
	//로그인 페이지 이동
	@RequestMapping(value = "login", method = RequestMethod.GET)
	public void loginGET() {
		log.info("로그인 페이지 진입");
	}
	
	//로그인 페이지 처리
	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String loginDoPOST(HttpServletRequest request, MemberDTO member, RedirectAttributes rttr) {
		log.info("로그인");
		HttpSession session = request.getSession(); //세션 선언 및초기화
	    System.out.println(member);
		int cnt = memberService.memberLogin(member);
		log.info("cnt : " + cnt);
		if(cnt==1) {
			session.setAttribute("memberId", member.getId());
		}
	    
		return "redirect:/main";		
	}
	
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request) {
		log.info("로그아웃");
		HttpSession session = request.getSession(); //세션 선언 및초기화
		session.setAttribute("memberId", null);
		session.setMaxInactiveInterval(0);
		return "redirect:/main";		
	}
}