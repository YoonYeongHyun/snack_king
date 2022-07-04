package com.snackking.controller;

import java.text.SimpleDateFormat;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.snackking.model.BuyDTO;
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
		List<ProductDTO> list1 = productService.getMainProductList("1");
		List<ProductDTO> list2 = productService.getMainProductList("2");
		model.addAttribute("list1", list1);
		model.addAttribute("list2", list2);
		
		return "main";
	}
	

	@RequestMapping(value = "/productList", method = RequestMethod.GET)
	public String productListPOST(HttpServletRequest request, Model model, RedirectAttributes rttr) {
		log.info( "상품 리스트 보기 진입");
		HttpSession session = request.getSession();
		String memberId = (String) session.getAttribute("memberId");
		
		MyBatisDTO mybatis = new MyBatisDTO();
		String category = request.getParameter("category");
		if (category == null) { 
			category = "0";
		}
		
		String search = request.getParameter("search");
		if(!(search == null) && !("null".equals(search))) {
			mybatis.setStr2("%" + search + "%");
		}
		
		String pageNum = request.getParameter("pageNum");
		if (pageNum == null) pageNum = "1";
		
		int start = ((Integer.parseInt(pageNum))-1)*20;
		
		
		mybatis.setInt1(start);
		mybatis.setStr1(category);
		
		int productCount = productService.getCProductCount(mybatis);
		List<ProductDTO> list = new ArrayList<ProductDTO>();
		list = productService.getCProductList(mybatis);
		
		model.addAttribute("list", list);
		model.addAttribute("category", category);
		model.addAttribute("search", search);
		model.addAttribute("count", productCount);
		model.addAttribute("pageNum", pageNum);
		return "/product/productList";		
	}
	
	
	@RequestMapping(value = "/productContent", method = RequestMethod.GET)
	public String productContentGET(HttpServletRequest request, Model model, RedirectAttributes rttr) {
		HttpSession session = request.getSession();
		log.info("상품 보기 진입");
		
		String memberId = (String) session.getAttribute("memberId");
		

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
				}
			}
			if(flag) {
				if(viewedProductList.size() == 5) {
					viewedProductList.remove(4);
					viewedProductList.add(0, product);
					flag = false;
					System.out.println("1번째 삭제");
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
	
	@RequestMapping(value = "/productOrderCart", method = RequestMethod.POST)
	public String productOrder(HttpServletRequest request, Model model, @RequestParam(value="chk_product_id") List<Integer> product_id_list, 
			@RequestParam(value="chk_product_amount") List<Integer> product_amount_list, @RequestParam(value="chk_product_price") List<Integer> product_price_list,
			RedirectAttributes rttr) {
		log.info("장바구니 주문창 진입");
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("memberId");
		
		
		List<ProductDTO> product_list = new ArrayList<ProductDTO>();
		for(int product_id : product_id_list) {
			ProductDTO product = productService.getProduct(product_id);
			product_list.add(product);
		}
		
		MemberDTO member = productService.getOrderMember(id);
		
		model.addAttribute("product_list", product_list);
		model.addAttribute("product_amount_list", product_amount_list);
		model.addAttribute("member", member);
		System.out.println(product_id_list);
		
		return "/product/productOrder";		
	}
	
	@RequestMapping(value = "/productOrderOne", method = RequestMethod.POST)
	public String productOrder(HttpServletRequest request, Model model, RedirectAttributes rttr) {
		log.info("개별상품 주문창 진입");
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("memberId");
		
		int product_id = Integer.parseInt((request.getParameter("product_id")));
		int product_amount = Integer.parseInt((request.getParameter("purchase_amount")));
		log.info(product_id);
		log.info(product_amount);
		
		List<ProductDTO> product_list = new ArrayList<ProductDTO>();
		List<Integer> product_amount_list = new ArrayList<Integer>();
		product_list.add(productService.getProduct(product_id));
		product_amount_list.add(product_amount);
		
		MemberDTO member = productService.getOrderMember(id);
		
		model.addAttribute("product_list", product_list);
		model.addAttribute("product_amount_list", product_amount_list);
		model.addAttribute("member", member);
		return "/product/productOrder";		
	}
	

	@RequestMapping(value = "/orderComple", method = RequestMethod.POST)
	public String orderComple(HttpServletRequest request, Model model, BuyDTO buy, RedirectAttributes rttr, @RequestParam(value="buy_product_id") List<Integer> product_id_list, 
			@RequestParam(value="buy_product_amount") List<Integer> product_amount_list, @RequestParam(value="buy_product_price") List<Integer> product_price_list) {
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("memberId");
		log.info("주문완료창 진입");
		
		String total_product_price = request.getParameter("total_product_price");
		String delivery_fee = request.getParameter("delivery_fee");
		String total_order_price = request.getParameter("total_order_price");
		List<ProductDTO> product_list = new ArrayList<ProductDTO>();
		
		java.util.Date now = new java.util.Date();
	    SimpleDateFormat nowdate = new SimpleDateFormat("yyMMddHH");
	    String pre_id = nowdate.format(now);
	    int random = (int)(Math.random()*1000);
	    String sub_id = Integer.toString(random);
		for(int product_id : product_id_list) {
			ProductDTO product = productService.getProduct(product_id);
			product_list.add(product);
		}
		
		int cnt = 0;
		for(ProductDTO product : product_list) {
			int product_amount = product_amount_list.get(cnt);
			int product_price = product.getProduct_sale_price();
			buy.setBuy_id(pre_id+sub_id);
			buy.setId(id);
			buy.setProduct_name(product.getProduct_name());
			buy.setProduct_image(product.getProduct_image());
			buy.setProduct_id(product.getProduct_id());
			buy.setBuy_amount(product_amount);
			buy.setBuy_price(product_amount * product_price); 
			productService.insertOrder(buy);
			cnt++;
			log.info(buy);
		}
		
		model.addAttribute("buy", buy);
		model.addAttribute("total_product_price", total_product_price);
		model.addAttribute("delivery_fee", delivery_fee);
		model.addAttribute("total_order_price", total_order_price);
		log.info(total_product_price);
		log.info( delivery_fee);
		log.info(total_order_price);
		return "/product/orderComple";
	}
	
	
}








