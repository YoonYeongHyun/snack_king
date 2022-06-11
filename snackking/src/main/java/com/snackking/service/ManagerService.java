package com.snackking.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import com.snackking.model.ManagerDTO;
import com.snackking.model.MyBatisDTO;
import com.snackking.model.ProductDTO;

@Service
public interface ManagerService {

	public int managerLogin(ManagerDTO manager);
	
	public void insertProduct(ProductDTO product);
	
	public ProductDTO getProduct(ProductDTO product);
	
	public List<ProductDTO> getMProductList(int start);
	public List<ProductDTO> getMCProductList(MyBatisDTO mybatis);
	
	public int getMProductCount();
	public int getMCProductCount(String category);
}
