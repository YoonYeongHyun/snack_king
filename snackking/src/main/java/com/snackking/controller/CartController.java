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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.snackking.model.CartDTO;
import com.snackking.model.ProductDTO;
import com.snackking.service.CartService;
import com.snackking.service.ProductService;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Controller
public class CartController {
	
	@Autowired
	private CartService cartService;
	@Autowired
	private ProductService productService;
	
	@ResponseBody
	@RequestMapping(value = "/cartInsert", method = {RequestMethod.GET, RequestMethod.POST})
	public String cartInsert(HttpServletRequest request, CartDTO cart) {
		log.info("장바구니 추가");
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("memberId");
		int result = cartService.cartConfirm(cart);
		String result_str;
		if(result==0) {
			cart.setId(id);	
			cartService.cartInsert(cart);
			result_str = "success";
		}else {
			result_str = "fail";
		}
		return result_str;	
	}
	

	@RequestMapping(value = "/productCart", method = {RequestMethod.GET, RequestMethod.POST})
	public String productCart(HttpServletRequest request, Model model, RedirectAttributes rttr) {
		log.info("장바구니 보기 진입");
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("memberId");
		List<CartDTO> cartList = cartService.getCartList(id);
		List<ProductDTO> productList = new ArrayList<ProductDTO>();
		
		for(CartDTO cart : cartList) {
			productList.add(productService.getProduct(cart.getProduct_id()));
		}
		model.addAttribute("cartList", cartList);
		model.addAttribute("productList", productList);
		model.addAttribute("cart_cnt", cartList.size());

		return "/product/productCart";	
	}
	
	@ResponseBody
	@RequestMapping(value = "/cartUpdate", method = RequestMethod.POST)
	public void cartUpdate(HttpServletRequest request, CartDTO cart) {
		log.info("장바구니 수정 진입");
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");
		cart.setId(memberId);
		cartService.cartUpdate(cart);
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/cartDelete", method = RequestMethod.POST)
	public void cartDelete(HttpServletRequest request, @RequestParam(value="product_ids[]") List<Integer> product_ids) {
		log.info("장바구니삭제 진입");
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");
		CartDTO cart = new CartDTO();
		cart.setId(memberId);
		for(int product_id : product_ids) {
			cart.setProduct_id(product_id);
			cartService.cartDeleteSe(cart);
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "/cartNone")
	public String cartNone() {
		log.info("테스트1 진입");
		return "Oh Yeah";
	}
}
