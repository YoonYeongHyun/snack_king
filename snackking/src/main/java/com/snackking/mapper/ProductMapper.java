package com.snackking.mapper;

import java.util.List;

import com.snackking.model.BuyDTO;
import com.snackking.model.CartDTO;
import com.snackking.model.MemberDTO;
import com.snackking.model.MyBatisDTO;
import com.snackking.model.ProductDTO;
import com.snackking.model.ReviewDTO;

public interface ProductMapper {
	
	//리스트관련
	public List<ProductDTO> getMainProductList(String str); //메인페이지 리스트 1, 2
	public int getCProductCount(ProductDTO product); //카테고리별 상품 개수 확인 (페이징 처리에 사용)
	public List<ProductDTO> getCProductList(ProductDTO product); //카테고리별 리스트 검색(Mybatis 사용상 DTO로 매개변수 한번에 받아 사용)
	public int getCProductCount_sp(ProductDTO product); //
	public List<ProductDTO> getCProductList_sp(ProductDTO product);
	
	//리뷰관련
	public int getProductReviewCount(int product_id);  //상품별 리뷰 개수 확인 (페이징 처리에 사용)
	public List<ReviewDTO> getProductReviewList(MyBatisDTO mybatis);  //상품별 리뷰리스트 받기 (페이징 처리에 사용)
	
	//상품내용 관련
	public ProductDTO getProduct(int product_id);

	//주문관련
	public void insertOrder(BuyDTO buy);
	public void updateQty(BuyDTO buy);
	public MemberDTO getOrderMember(String id);

	
	

	
}
