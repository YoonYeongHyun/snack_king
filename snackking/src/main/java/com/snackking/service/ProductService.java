package com.snackking.service;

import java.util.List;

import com.snackking.model.BuyDTO;
import com.snackking.model.CartDTO;
import com.snackking.model.MemberDTO;
import com.snackking.model.MyBatisDTO;
import com.snackking.model.ProductDTO;
import com.snackking.model.ReviewDTO;

public interface ProductService {
	
	//리스트관련
	public List<ProductDTO> getMainProductList(String str);
	public int getCProductCount(ProductDTO product);  //카테고리별 상품 개수 확인 
	public List<ProductDTO> getCProductList(ProductDTO product); //카테고리별 리스트 검색
	public int getCProductCount_sp(ProductDTO product);
	public List<ProductDTO> getCProductList_sp(ProductDTO product);
	
	//리뷰관련
	public int getProductReviewCount(int product_id);  //상품별 리뷰 개수 확인 (페이징 처리에 사용)
	public List<ReviewDTO> getProductReviewList(MyBatisDTO mybatis);  //상품별 리뷰리스트 받기 (페이징 처리에 사용)
	
	//상품내용 관련
	public ProductDTO getProduct(int product_id); //상품 조회
	
	//주문관련
	public MemberDTO getOrderMember(String id);	
	public void productOrder(BuyDTO buy, List<Integer> product_id_list, List<Integer> product_amount_list, List<Integer> product_price_list, String id);
}
