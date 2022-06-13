package com.snackking.mapper;

import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.snackking.model.MyBatisDTO;
import com.snackking.model.ProductDTO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class ProductMapperTests {
	
	@Autowired
	private ProductMapper mapper;
	/*
	@Test
	public void getProductListTest() {
		MyBatisDTO mybatis = new MyBatisDTO();
		mybatis.setInt1(0);
		mybatis.setStr1("101");
		
		System.out.println();*/
	/*
	@Test
	public void getProductListTest() {
		MyBatisDTO mybatis = new MyBatisDTO();
		mybatis.setInt1(0);
		mybatis.setStr1("101");
		
		List<ProductDTO> product = mapper.getCProductList(mybatis);
		System.out.println(product);
	}
	*/
	/* xml 전체 리스트 쿼리문 테스트
	@Test
	public void getProductListTest() {
		String product_kind = "101";
		List<ProductDTO> product = mapper.getProductList("10%");
		System.out.println(product.size());
	}
	*/
	
}
