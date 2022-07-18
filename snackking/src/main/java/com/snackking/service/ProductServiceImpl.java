package com.snackking.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.snackking.controller.ProductController;
import com.snackking.mapper.ProductMapper;
import com.snackking.model.BuyDTO;
import com.snackking.model.CartDTO;
import com.snackking.model.MemberDTO;
import com.snackking.model.MyBatisDTO;
import com.snackking.model.ProductDTO;
import com.snackking.model.ReviewDTO;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Service
public class ProductServiceImpl implements ProductService{

	@Autowired
	ProductMapper productMapper;
	
	@Override
	public List<ProductDTO> getMainProductList(String str) {
		
		return productMapper.getMainProductList(str);
	}
	
	
	@Override
	public ProductDTO getProduct(int product_id) {
	
		return productMapper.getProduct(product_id);
	}

	@Override
	public int getCProductCount(ProductDTO product) {
		String category = product.getCategory();
		switch (category) { // 0,1,2,3,4,5,6 상품은 대분류로 지정 ex 1은 101, 102, 103 포함
		case "0": product.setCategory("%"); break;
		case "1": product.setCategory("1%"); break;
		case "2": product.setCategory("2%"); break;
		case "3": product.setCategory("3%"); break;
		case "4": product.setCategory("4%"); break;
		case "5": product.setCategory("5%"); break;
		case "6": product.setCategory("6%"); break;
		default: break;
		}
		if(category.equals("7") || category.equals("8")) {
			int productCount = productMapper.getCProductCount_sp(product);
			if(productCount <= 100) {
				return productCount;
			}else {
				return 100;
			}
		}else {
			return productMapper.getCProductCount(product);
		}
	}

	@Override
	public List<ProductDTO> getCProductList(ProductDTO product) {
		String category = product.getCategory();
		switch (category) {
		case "0": product.setCategory("%"); break;
		case "1": product.setCategory("1%"); break;
		case "2": product.setCategory("2%"); break;
		case "3": product.setCategory("3%"); break;
		case "4": product.setCategory("4%"); break;
		case "5": product.setCategory("5%"); break;
		case "6": product.setCategory("6%"); break;
		default: break;
		}
		if(category.equals("7") || category.equals("8")) {
			return productMapper.getCProductList_sp(product);
		}else {
			return productMapper.getCProductList(product);
		}	
	}

	public int getProductReviewCount(int product_id) {
		
		return productMapper.getProductReviewCount(product_id);
	}
	
	public List<ReviewDTO> getProductReviewList(MyBatisDTO mybatis) { 
	
		
		return productMapper.getProductReviewList(mybatis);
	}
	
	

	@Override
	public MemberDTO getOrderMember(String id) {
		
		return productMapper.getOrderMember(id);
	}


	@Override
	public int getCProductCount_sp(ProductDTO product) {
		
		return getCProductCount_sp(product);
	}


	@Override
	public List<ProductDTO> getCProductList_sp(ProductDTO product) {
		
		return productMapper.getCProductList_sp(product);
	}


	@Override
	public void productOrder(BuyDTO buy, List<Integer> product_id_list, List<Integer> product_amount_list, List<Integer> product_price_list, String id) {
		
		List<ProductDTO> product_list = new ArrayList<ProductDTO>();
		java.util.Date now = new java.util.Date();
	    SimpleDateFormat nowdate = new SimpleDateFormat("yyMMddHH");
	    String pre_id = nowdate.format(now);
	    int random = (int)(Math.random()*1000);
	    String sub_id = Integer.toString(random);
		for(int product_id : product_id_list) {
			ProductDTO product = productMapper.getProduct(product_id);
			product_list.add(product);
		}
		
		int cnt = 0;
		for(ProductDTO product : product_list) {
			int buy_amount = product_amount_list.get(cnt);
			int product_price = product.getProduct_sale_price();
			buy.setBuy_id(pre_id+sub_id);
			buy.setId(id);
			buy.setProduct_name(product.getProduct_name());
			buy.setProduct_image(product.getProduct_image());
			buy.setProduct_id(product.getProduct_id());
			buy.setBuy_amount(buy_amount);
			buy.setBuy_price(buy_amount * product_price); 
			buy.setProduct_qty(product.getProduct_qty());
			productMapper.insertOrder(buy);
			productMapper.updateQty(buy);
			cnt++;
			log.info(buy);
		}
	}





	

}
