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
import com.snackking.model.MemberDTO;
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
		

		//세션 사용 최근본 목록
		List<ProductDTO> viewedProductList = (List<ProductDTO>) session.getAttribute("viewedProductList");
		System.out.println(viewedProductList);
		if(viewedProductList == null) {
			viewedProductList = new ArrayList<ProductDTO>();
		}
		boolean flag = true;
		if(viewedProductList.size()==0) {
			viewedProductList.add(0, product);
		}else {
			for(ProductDTO viewedProduct : viewedProductList) {
				if(viewedProduct.getProduct_id() == product_id) {
					flag = false;
					System.out.println("같은이름 발생");
					break;
				}else {
					if(viewedProductList.size() == 5) {
						viewedProductList.remove(0);
						viewedProductList.add(0, product);
						flag = false;
						 System.out.println("1번째 삭제");
						break;
					}
				}
			}
			if(flag) viewedProductList.add(0, product);
		}
		
		session.setAttribute("viewedProductList", viewedProductList);
		model.addAttribute("product", product);
		model.addAttribute("review", review);
		model.addAttribute("reviewPageNum", reviewPageNum);
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

		;


		
		return "/product/productCart";	
	}
	
	@RequestMapping(value = "/cartUpdate", method = RequestMethod.POST)
	public String cartUpdate(HttpServletRequest request, Model model, RedirectAttributes rttr) {
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");
		log.info( memberId + "님 장바구니수정");
		MyBatisDTO mybatis = new MyBatisDTO();
		String code = request.getParameter("code");
		if(code.equals("1")) {
			int product_id = Integer.parseInt(request.getParameter("product_id"));
			int product_amount = Integer.parseInt(request.getParameter("product_amount"));
			mybatis.setStr1(memberId);
			mybatis.setInt1(product_amount);
			mybatis.setInt2(product_id);
			productService.cartUpdate(mybatis);
		}else if(code.equals("2")) {
			String product_ids = request.getParameter("product_ids");
			String[] arr_product_ids = product_ids.split(",");
			for(String product_id_str : arr_product_ids){
				int product_id = Integer.parseInt(product_id_str);
				mybatis.setStr1(memberId);
				mybatis.setInt1(product_id);
				productService.cartDeleteSe(mybatis);
			}
		}
		return "/product/productCart";
	}
	
	@RequestMapping(value = "/productOrder", method = RequestMethod.POST)
	public String productOrder(HttpServletRequest request, Model model, RedirectAttributes rttr) {
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("memberId");
		String product_id_str = request.getParameter("product_id");
		String product_id_arr[] = product_id_str.split(",");
		String purchase_amount_str = request.getParameter("purchase_amount");
		String product_amount_arr[] = purchase_amount_str.split(",");
		List<ProductDTO> product_list = new ArrayList<ProductDTO>();
		List<Integer> product_amount_list = new ArrayList<Integer>();
		
		for(String product_id : product_id_arr) {
			ProductDTO product = productService.getProduct(Integer.parseInt(product_id));
			product_list.add(product);
		}
		
		for(String product_amount : product_amount_arr) {
			product_amount_list.add(Integer.parseInt(product_amount));
		}

		MemberDTO member = productService.getOrderMember(id);
		
		model.addAttribute("product_list", product_list);
		model.addAttribute("product_amount_list", product_amount_list);
		model.addAttribute("member", member);
		
		return "/product/productOrder";
	}
}








