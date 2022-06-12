package com.snackking.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.snackking.mapper.ManagerMapper;
import com.snackking.model.ManagerDTO;
import com.snackking.model.MyBatisDTO;
import com.snackking.model.ProductDTO;

@Service
public class ManagerServiceImpl implements ManagerService {

	@Autowired
	ManagerMapper managerMapper;
	
	@Override
	public int managerLogin(ManagerDTO manager) {

		return managerMapper.managerLogin(manager);
	}

	@Override
	public void insertProduct(ProductDTO product){
		
		managerMapper.insertProduct(product);
	}

	@Override
	public ProductDTO getProduct(ProductDTO product) {
		
		return managerMapper.getProduct(product);
	}
	
	@Override
	public List<ProductDTO> getMProductList(int start){

		return managerMapper.getMProductList(start);
	}

	@Override
	public List<ProductDTO> getMCProductList(MyBatisDTO mybatis) {

		switch (mybatis.getStr1()) {
		case "0": mybatis.setStr1("%"); break;
		case "1": mybatis.setStr1("1%"); break;
		case "2": mybatis.setStr1("2%"); break;
		case "3": mybatis.setStr1("3%"); break;
		case "4": mybatis.setStr1("4%"); break;
		case "5": mybatis.setStr1("5%"); break;
		case "6": mybatis.setStr1("6%"); break;

		default: break;
		}
		return managerMapper.getMCProductList(mybatis);
	}

	@Override
	public int getMProductCount() {
		
		return managerMapper.getMProductCount();
	}

	@Override
	public int getMCProductCount(String category) {
		String cat = "";
		switch (category) {
		case "0": cat = "%"; break;
		case "1": cat = "1%"; break;
		case "2": cat = "2%"; break;
		case "3": cat = "3%"; break;
		case "4": cat = "4%"; break;
		case "5": cat = "5%"; break;
		case "6": cat = "6%"; break;

		default:
			break;
		}
		return managerMapper.getMCProductCount(cat);
	}




	
}
