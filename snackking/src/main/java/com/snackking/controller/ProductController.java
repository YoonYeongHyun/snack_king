package com.snackking.controller;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import com.snackking.model.ProductDTO;
import com.snackking.service.ProductService;
import lombok.extern.log4j.Log4j2;

@Log4j2
@Controller
public class ProductController {
	
	@Autowired
	private ProductService productService;
	
	
	//메인 페이지 이동
	@RequestMapping("main")
	public String main(Model model) {
		log.info("메인 페이지 진입");

		
		List<ProductDTO> list1 = productService.getMainProductList1();
		List<ProductDTO> list2 = productService.getMainProductList2();
		model.addAttribute("list1", list1);
		model.addAttribute("list2", list2);
		
		return "main";
	}
}








