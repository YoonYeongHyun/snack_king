package com.snackking.service;

import java.util.List;

import com.snackking.model.CartDTO;
import com.snackking.model.MyBatisDTO;
import com.snackking.model.ProductDTO;

public interface CartService{
	public List<CartDTO> getCartList(String id);
	public void cartInsert(CartDTO cart); //카트 추가하기
	public void cartUpdate(CartDTO cart);
	public void cartDeleteSe(CartDTO cart);
	public int cartConfirm(CartDTO cart);
}
