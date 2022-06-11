package com.snackking.mapper;

import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.snackking.model.ProductDTO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class ProductMapperTests {
	
	@Autowired
	private ProductMapper mapper;
	/*
	@Test
	public void getProductListTest() {
		String product_kind = "101";
		List<ProductDTO> product = mapper.getProductList("10%");
		System.out.println(product.size());
	}
	*/
	
}
