package com.snackking.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.snackking.model.ProductDTO;
import com.snackking.service.ProductService;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Controller
public class HomeController {

	@Autowired
	private ProductService productService;
	HttpSession session;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model, HttpServletRequest requset){ 
		
		log.info("snackking 실행");
		return "redirect:main"; 
	}
	
	
	@RequestMapping(value = "/manager", method = RequestMethod.GET)
	public String managerHome(Model model, HttpServletRequest requset){ 
		log.info("매니저 관리 페이지 진입");
		session = requset.getSession();
		if(session.getAttribute("memberId") == null) {
			model.addAttribute("memberId", "");
		} else {
			model.addAttribute("memberId", session.getAttribute("memberId"));
		}
		return "manager/login"; 
	}
}
