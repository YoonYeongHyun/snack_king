package com.snackking.service;

import java.util.List;

import com.snackking.model.CartDTO;
import com.snackking.model.MemberDTO;
import com.snackking.model.MyBatisDTO;
import com.snackking.model.ProductDTO;
import com.snackking.model.ReviewDTO;

public interface ProductService {
	
	public List<ProductDTO> getMainProductList(String str);
	
	
	public ProductDTO getProduct(int product_id); //상품 1건 검색
	
	public int getCProductCount(MyBatisDTO mybatis);  //카테고리별 상품 개수 확인 (페이징 처리에 사용)
	public List<ProductDTO> getCProductList(MyBatisDTO mybatis); //카테고리별 리스트 검색(Mybatis 사용상 DTO로 매개변수 한번에 받아 사용)

	public int getCProductCount_sp(ProductDTO product);
	public List<ProductDTO> getCProductList_sp(ProductDTO product);

	public int getProductReviewCount(int product_id);  //상품별 리뷰 개수 확인 (페이징 처리에 사용)
	public List<ReviewDTO> getProductReviewList(MyBatisDTO mybatis);  //상품별 리뷰리스트 받기 (페이징 처리에 사용)

	
	public MemberDTO getOrderMember(String id);
	

}
