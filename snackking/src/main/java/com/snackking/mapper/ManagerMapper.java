package com.snackking.mapper;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.snackking.model.ManagerDTO;
import com.snackking.model.MyBatisDTO;
import com.snackking.model.ProductDTO;

public interface ManagerMapper {
	
	public int managerLogin(ManagerDTO manager);

	public void insertProduct(ProductDTO product);
	public ProductDTO getProduct(ProductDTO product);
	public void updateProduct(ProductDTO product);
	public void deleteProduct(ProductDTO product);
	
	
	public List<ProductDTO> getMProductList(int start);
	public List<ProductDTO> getMCProductList(MyBatisDTO mybatis);
	
	public int getMProductCount();
	public int getMCProductCount(MyBatisDTO mybatis);

	
	
}
