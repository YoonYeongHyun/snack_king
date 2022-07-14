package com.snackking.controller;


import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.snackking.model.BuyDTO;
import com.snackking.model.MemberDTO;
import com.snackking.model.ProductDTO;
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
		
		return "redirect:/main";
	}
	
	@RequestMapping(value="/memberIdChk", method = RequestMethod.POST)
	@ResponseBody
	public String memberIdChkPOST(String id) throws Exception{
		log.info("아이디 중복확인 실행");
		
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
	
	/*로그인 페이지 처리
	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String loginDoPOST(HttpServletRequest request, MemberDTO member, RedirectAttributes rttr) {
		log.info("로그인");
		HttpSession session = request.getSession(); //세션 선언 및초기화
	    System.out.println(member);
		int cnt = memberService.memberLogin(member);
		if(cnt==1) {
			session.setAttribute("memberId", member.getId());
		}
	    
		return "redirect:/main";		
	}
	*/
	@ResponseBody
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String cartDelete(HttpServletRequest request, @RequestParam(value="id") String id, @RequestParam(value="pwd") String pwd, MemberDTO member) {
		log.info("로그인 처리");
		HttpSession session = request.getSession();
		int cnt_id = memberService.memberLogin_id(member);
		String result = "";
		System.out.println(member);
		if(cnt_id==1) {
			int cnt_id_pwd = memberService.memberLogin_id_pwd(member);
			if(cnt_id_pwd == 1) {
				session.setAttribute("memberId", member.getId());
				result = "success";
			}else {
				result = "error_password";
			}
		}else {
			result = "error_id";
		}
		System.out.println(result);
		return result;
	}
	
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request) {
		log.info("로그아웃");
		HttpSession session = request.getSession(); //세션 선언 및초기화
		session.setAttribute("memberId", null);
		session.setMaxInactiveInterval(0);
		return "redirect:/main";
	}
	
	@RequestMapping(value = "myPage", method = RequestMethod.GET)
	public String myPageGET(HttpServletRequest request, Model model, MemberDTO member) {
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("memberId");
		log.info(id + "님 마이 페이지 진입");
		member = memberService.getMemberInfo(id);
		List<BuyDTO> buy_list = memberService.getBuyInfo_mypageMain(id);
		log.info(member);
		log.info(buy_list);
		
		model.addAttribute("member", member);
		model.addAttribute("buy_list", buy_list);
		return "/member/myPage";
	}
}