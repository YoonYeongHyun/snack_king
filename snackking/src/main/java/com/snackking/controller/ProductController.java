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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.snackking.model.CartDTO;
import com.snackking.model.MyBatisDTO;
import com.snackking.model.ProductDTO;
import com.snackking.model.ReviewDTO;
import com.snackking.service.ProductService;
import lombok.extern.log4j.Log4j2;

@Log4j2
@Controller
@RequestMapping(value = "/")
public class ProductController {
	
	@Autowired
	private ProductService productService;
	
	
	//메인 페이지 이동
	@RequestMapping("/main")
	public String main(Model model) {
		log.info("메인 페이지 진입");

		
		List<ProductDTO> list1 = productService.getMainProductList1();
		List<ProductDTO> list2 = productService.getMainProductList2();
		model.addAttribute("list1", list1);
		model.addAttribute("list2", list2);
		
		return "main";
	}
	

	@RequestMapping(value = "/productList", method = RequestMethod.GET)
	public String productListPOST(HttpServletRequest request, Model model, RedirectAttributes rttr) {
		int productCount = 0;
		String category = request.getParameter("category");
		if (category == null) { 
			category = "0";
		}
		productCount = productService.getCProductCount(category);
		
		String pageNum = request.getParameter("pageNum");
		if (pageNum == null) pageNum = "1";
		int start = ((Integer.parseInt(pageNum))-1)*20;
		
		MyBatisDTO mybatis = new MyBatisDTO();
		mybatis.setInt1(start);
		mybatis.setStr1(category);
		
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");
		log.info( "님 상품 리스트 보기 진입");

		List<ProductDTO> list = new ArrayList<ProductDTO>();
		list = productService.getCProductList(mybatis);
		
		model.addAttribute("list", list);
		model.addAttribute("category", category);
		model.addAttribute("count", productCount);
		model.addAttribute("pageNum", pageNum);
		return "/product/productList";		
	}
	
	@RequestMapping(value = "/productContent", method = RequestMethod.GET)
	public String productContentGET(HttpServletRequest request, Model model, RedirectAttributes rttr) {
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");
		log.info( memberId + "님 상품 보기 진입");

		String reviewPageNum = request.getParameter("reviewPageNum");
		if (reviewPageNum == null) reviewPageNum = "1";
		int start = ((Integer.parseInt(reviewPageNum))-1)*10;
		
		
		int product_id = Integer.parseInt(request.getParameter("product_id"));
		ProductDTO product = new ProductDTO();
		product = productService.getProduct(product_id);

		MyBatisDTO mybatis = new MyBatisDTO();
		mybatis.setInt1(product_id); //리뷰의 상품번호
		mybatis.setInt2(start); //리뷰글의 시작번호	
		List<ReviewDTO> review = productService.getProductReviewList(mybatis);
		int reviewCount = productService.getProductReviewCount(product_id);
		
		model.addAttribute("product", product);
		model.addAttribute("review", review);
		model.addAttribute("reviewCount", reviewCount);
		return "/product/productContent";	
	}
	

	@RequestMapping(value = "/cartInsert", method = {RequestMethod.GET, RequestMethod.POST})
	public String cartInsert(HttpServletRequest request, Model model, RedirectAttributes rttr) {
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");
		
		String id =memberId;
		int product_id = Integer.parseInt(request.getParameter("product_id"));
		int product_amount = Integer.parseInt(request.getParameter("product_amount"));
		MyBatisDTO mybatis = new MyBatisDTO();
		mybatis.setStr1(id);		
		mybatis.setInt1(product_id);
		mybatis.setInt2(product_amount);	
		productService.cartInsert(mybatis);
		log.info( memberId + "님 장바구니 추가");
		return "/product/productCart";	
	}
	
	@RequestMapping(value = "/productCart", method = {RequestMethod.GET, RequestMethod.POST})
	public String productCart(HttpServletRequest request, Model model, RedirectAttributes rttr) {
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");
		log.info( memberId + "님 장바구니 보기 진입");
		String id =memberId;
		List<CartDTO> cartList = productService.getCartList(id);
		List<ProductDTO> productList = new ArrayList<ProductDTO>();
		
		for(CartDTO cart : cartList) {
			productList.add(productService.getProduct(cart.getProduct_id()));
		}
		model.addAttribute("cartList", cartList);
		model.addAttribute("productList", productList);
		model.addAttribute("cart_cnt", cartList.size());


		
		return "/product/productCart";	
	}
}








