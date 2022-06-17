package com.snackking.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.logging.SimpleFormatter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.snackking.model.ManagerDTO;
import com.snackking.model.MyBatisDTO;
import com.snackking.model.ProductDTO;
import com.snackking.service.ManagerService;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Controller
@RequestMapping(value = "/manager")
public class ManagerController {

	@Autowired
	private ManagerService managerService;
	HttpSession session;
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String loginPOST(HttpServletRequest request, ManagerDTO manager, Model model, RedirectAttributes rttr) {
		log.info("관리자 계정 로그인");
		HttpSession session = request.getSession();
	    System.out.println(manager);
		int cnt = managerService.managerLogin(manager);
		log.info("cnt : " + cnt);
		if(cnt==1) {
			session.setAttribute("manager_id", manager.getManager_id());
			return "redirect:/manager/productManagement";	
			
		} else { 
			return "/manager/login";
		}		
	}
	

	@RequestMapping(value = "/productManagement", method = RequestMethod.GET)
	public String managementPOST(HttpServletRequest request, Model model, RedirectAttributes rttr) {
		HttpSession session = request.getSession();
		String str = (String) session.getAttribute("manager_id");
		log.info( "상품 관리 진입");
		
		
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
		
		int start = ((Integer.parseInt(pageNum))-1)*10;
		
		
		mybatis.setInt1(start);
		mybatis.setStr1(category);

		int productCount = managerService.getMCProductCount(mybatis);
		List<ProductDTO> list = new ArrayList<ProductDTO>();
		list = managerService.getMCProductList(mybatis);
		
		model.addAttribute("list", list);
		model.addAttribute("category", category);
		model.addAttribute("search", search);
		model.addAttribute("count", productCount);
		model.addAttribute("pageNum", pageNum);
		return "/manager/productManagement";		
	}

	@RequestMapping(value = "productInsert", method = RequestMethod.GET)
	public String productInsertGET(HttpServletRequest request, ProductDTO product, RedirectAttributes rttr) {
		HttpSession session = request.getSession();
		String str = (String) session.getAttribute("manager_id");
		log.info( "상품 등록 진입");
		
		return "/manager/productInsert";		
	}
	
	@RequestMapping(value = "productInsert", method = RequestMethod.POST)
	public String productInsertPOST(@RequestParam("product_kind") String product_kind, @RequestParam("product_name") String product_name, @RequestParam("product_price") String product_price,
			@RequestParam("product_sale_price") String product_sale_price, @RequestParam("product_qty") String product_qty, @RequestParam("product_brand") String product_brand,
			@RequestParam(value = "product_content",  required = false) String product_content, @RequestParam(value = "product_image", required = false) MultipartFile product_image, 
			@RequestParam(value= "product_content_image1", required = false) MultipartFile product_content_image1,
			@RequestParam(value= "product_content_image2", required = false) MultipartFile product_content_image2,
			@RequestParam(value= "product_content_image3", required = false) MultipartFile product_content_image3,
			@RequestParam(value= "product_content_image4", required = false) MultipartFile product_content_image4,
			@RequestParam(value= "product_content_image5", required = false) MultipartFile product_content_image5,
			HttpServletRequest request, RedirectAttributes rttr) {
		
		ProductDTO product = new ProductDTO();
		int product_price_int = Integer.parseInt(product_price);
		int product_sale_price_int = Integer.parseInt(product_sale_price);
		int discount_rate = (int)((1 - (float)product_sale_price_int/product_price_int)*100);
		int product_qty_int = Integer.parseInt(product_qty);
		product.setProduct_kind(product_kind);
		product.setProduct_name(product_name);
		product.setProduct_price(product_price_int);
		product.setDiscount_rate(discount_rate);
		product.setProduct_sale_price(product_sale_price_int);
		product.setProduct_qty(product_qty_int);
		product.setProduct_brand(product_brand);
		product.setProduct_content(product_content);
		
		List<String> pc_imgs = new ArrayList<String>();
		String realPath = "c:/images_yhmall";
		String pc_img = "";
		try {
			downloadImage(product, product_image, realPath, pc_imgs);
			downloadImage(product, product_content_image1, realPath, pc_imgs);
			downloadImage(product, product_content_image2, realPath, pc_imgs);
			downloadImage(product, product_content_image3, realPath, pc_imgs);
			downloadImage(product, product_content_image4, realPath, pc_imgs);
			downloadImage(product, product_content_image5, realPath, pc_imgs);
			pc_img =  String.join(",", pc_imgs);
			product.setProduct_content_image(pc_img);
			managerService.insertProduct(product);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		System.out.println("----------------------------------------------");
		//managerService.insertProduct(product);
		log.info( "상품 등록");
		
		return "redirect:/manager/productManagement";		
	}
	
	private void downloadImage(ProductDTO product, MultipartFile multipartFile, String realPath, List<String> pc_imgs ) throws Exception {
		
		String date;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		Date nowDate = new Date();
		date = sdf.format(nowDate);
		realPath += "/"+ date; 
		
		File fileDir = new File(realPath);     //해당경로가 없으면 디렉토리를 생성
		if(!fileDir.exists()) fileDir.mkdir();
		
		if(!(multipartFile.getSize() == 0) && (multipartFile.getSize() < (5 *1024 * 1024))) { //파일의 사이즈가 0이 아닐경우(파일이 존재) + 5mb이하
			if(multipartFile.getName().equals("product_image")) {
				product.setProduct_image("/"+ date + "/" + multipartFile.getOriginalFilename());
				File saveFile = new File(realPath, multipartFile.getOriginalFilename());
				multipartFile.transferTo(saveFile);
			}else{
				pc_imgs.add("/"+ date + "/" + multipartFile.getOriginalFilename());
				File saveFile = new File(realPath, multipartFile.getOriginalFilename());
				multipartFile.transferTo(saveFile);
			}
		}
	}

	
	@RequestMapping(value = "productUpdate", method = RequestMethod.GET)
	public String productUpdateGET(HttpServletRequest request, ProductDTO product, RedirectAttributes rttr, Model model) {
		HttpSession session = request.getSession();
		String str = (String) session.getAttribute("manager_id");
		log.info( "님 상품 수정 진입");
		product = managerService.getProduct(product);
		model.addAttribute("product", product);
		
		return "/manager/productUpdate";	
	}
	

	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logoutGET(HttpServletRequest request) {
		if(!(session==null)) {
			session.setAttribute("manager_id", null);
			session.setMaxInactiveInterval(0);
			log.info("관리자 계정 로그아웃");
		}
		return "/manager/login";
	}
	
}
