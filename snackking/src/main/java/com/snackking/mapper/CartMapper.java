package com.snackking.mapper;

import java.util.List;

import com.snackking.model.CartDTO;
import com.snackking.model.MyBatisDTO;

public interface CartMapper {

	public List<CartDTO> getCartList(String id); //계정별 카트 리스트 정보 받기
	public void cartInsert(CartDTO cart); //카트 추가하기
	public void cartUpdate(CartDTO cart); //카트 수량 변경
	public void cartDeleteSe(CartDTO cart); //선택된 카트 상품 삭제
}
