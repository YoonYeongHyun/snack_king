package com.snackking.service;

import java.util.List;

import com.snackking.model.ProductDTO;

public interface ProductService {
	
	public List<ProductDTO> getMainProductList1(); //메인페이지 상품1
	public List<ProductDTO> getMainProductList2(); //메인페이지 상품2
	public List<ProductDTO> getProductList();
	public List<ProductDTO> getProductList(String product_kind);

}
