package com.snackking.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.snackking.mapper.ProductMapper;
import com.snackking.model.ProductDTO;

@Service
public class ProductServiceImpl implements ProductService{

	@Autowired
	ProductMapper productMapper;
	
	@Override
	public List<ProductDTO> getMainProductList1() {
		return productMapper.getMainProductList1();
	}

	@Override
	public List<ProductDTO> getMainProductList2() {
		return productMapper.getMainProductList2();
	}

	@Override
	public List<ProductDTO> getProductList() {
		return productMapper.getProductList();
	}

	
	@Override
	public List<ProductDTO> getProductList(String product_kind) {
		return productMapper.getProductList(product_kind);
	}


	

}
