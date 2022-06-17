package com.snackking.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.snackking.mapper.CartMapper;
import com.snackking.model.CartDTO;
import com.snackking.model.MyBatisDTO;
import com.snackking.model.ProductDTO;

@Service
public class CartServiceImpl implements CartService{
	
	@Autowired
	CartMapper cartMapper;
	
	@Override
	public List<CartDTO> getCartList(String id){
		return cartMapper.getCartList(id);
	}

	@Override
	public void cartInsert(CartDTO cart) {
		cartMapper.cartInsert(cart);
		
	}

	@Override
	public void cartUpdate(CartDTO cart) {
		cartMapper.cartUpdate(cart);
	}
	
	@Override
	public void cartDeleteSe(CartDTO cart) {
		cartMapper.cartDeleteSe(cart);
	}

	@Override
	public int cartConfirm(CartDTO cart) {
		
		return cartMapper.cartConfirm(cart);
	}

}
