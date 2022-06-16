package com.snackking.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.snackking.mapper.ProductMapper;
import com.snackking.model.CartDTO;
import com.snackking.model.MemberDTO;
import com.snackking.model.MyBatisDTO;
import com.snackking.model.ProductDTO;
import com.snackking.model.ReviewDTO;

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
	public int getCProductCount(MyBatisDTO mybatis) {
		switch (mybatis.getStr1()) { // 0,1,2,3,4,5,6 상품은 대분류로 지정 ex 1은 101, 102, 103 포함
		case "0": mybatis.setStr1("%"); break;
		case "1": mybatis.setStr1("1%"); break;
		case "2": mybatis.setStr1("2%"); break;
		case "3": mybatis.setStr1("3%"); break;
		case "4": mybatis.setStr1("4%"); break;
		case "5": mybatis.setStr1("5%"); break;
		case "6": mybatis.setStr1("6%"); break;
		default: ; break;
		}
		return productMapper.getCProductCount(mybatis);
	}

	@Override
	public List<ProductDTO> getCProductList(MyBatisDTO mybatis) {

		switch (mybatis.getStr1()) {
		case "0": mybatis.setStr1("%"); break;
		case "1": mybatis.setStr1("1%"); break;
		case "2": mybatis.setStr1("2%"); break;
		case "3": mybatis.setStr1("3%"); break;
		case "4": mybatis.setStr1("4%"); break;
		case "5": mybatis.setStr1("5%"); break;
		case "6": mybatis.setStr1("6%"); break;
		default: ; break;}
		return productMapper.getCProductList(mybatis);
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

	

}
