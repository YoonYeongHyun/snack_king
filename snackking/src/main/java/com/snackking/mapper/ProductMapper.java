package com.snackking.mapper;

import java.util.List;

import com.snackking.model.CartDTO;
import com.snackking.model.MemberDTO;
import com.snackking.model.MyBatisDTO;
import com.snackking.model.ProductDTO;
import com.snackking.model.ReviewDTO;

public interface ProductMapper {
	//상품조회
	public List<ProductDTO> getMainProductList1(); //메인페이지 상품1
	public List<ProductDTO> getMainProductList2(); //메인페이지 상품2
	
	public int getCProductCount(String category);  //카테고리별 상품 개수 확인 (페이징 처리에 사용)
	
	public ProductDTO getProduct(int product_id);
	public List<ProductDTO> getCProductList(MyBatisDTO mybatis); //카테고리별 리스트 검색(Mybatis 사용상 DTO로 매개변수 한번에 받아 사용) 

	public int getProductReviewCount(int product_id);  //상품별 리뷰 개수 확인 (페이징 처리에 사용)
	public List<ReviewDTO> getProductReviewList(MyBatisDTO mybatis);  //상품별 리뷰리스트 받기 (페이징 처리에 사용)
	
	public List<CartDTO> getCartList(String id); //계정별 카트 리스트 정보 받기
	public void cartInsert(MyBatisDTO mybatis); //카트 추가하기
	public void cartUpdate(MyBatisDTO mybatis); //카트 수량 변경
	public void cartDeleteSe(MyBatisDTO mybatis); //선택된 카트 상품 삭제
	
	public MemberDTO getOrderMember(String id);
	
}
