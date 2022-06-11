package com.snackking.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.snackking.model.ManagerDTO;
import com.snackking.model.ProductDTO;

@RunWith(SpringJUnit4ClassRunner.class) //테스트를위한 jUnit클래스 사용한다는 어노테이션
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml") //스프링 빈(Bean)설정 파일의 위치를 지정.
public class ManagerTests{
	
	@Autowired
	private ManagerMapper managerMapper; // 인터페이스 의존성 주입
		/*
		@Test
		public void testinsertProduct(){
			ProductDTO product = new ProductDTO();
			product.setProduct_kind("101");
			product.setProduct_name("test");
			product.setProduct_price(5000);
			product.setDiscount_rate(0);
			product.setProduct_sale_price(5000);
			product.setProduct_sales(999);
			product.setProduct_brand("test");
			product.setProduct_image("101-1.png");
			product.setProduct_content("테스트중입니다.");
			
			managerMapper.insertProduct(product);
		}
		 */
		/*
		@Test
		public void testgetMproductlist() {
			int cnt = managerMapper.getMProductList1(10).size();
			System.out.println(managermapper.getMProductList1(10));
			System.out.println(cnt);
		}
		*/
		
		/*
		@Test
		public void testmemberLogin() {
			//HashMap<String, String> map = new HashMap<String, String>();
			//map.put("ManagerId", "yyh455");
			//map.put("ManagerPwd", "1234");
			ManagerDTO manager = new ManagerDTO();
			manager.setManagerId("admin");
			manager.setManagerPwd("1234");
			int cnt = managerMapper.managerLogin(manager);
			System.out.println(cnt);
		}
		*/
}