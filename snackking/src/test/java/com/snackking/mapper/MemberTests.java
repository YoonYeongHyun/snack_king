package com.snackking.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.snackking.model.MemberDTO;

@RunWith(SpringJUnit4ClassRunner.class) //테스트를위한 jUnit클래스 사용한다는 어노테이션
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml") //스프링 빈(Bean)설정 파일의 위치를 지정.
public class MemberTests{
	
	@Autowired
	private MemberMapper membermapper; // 인터페이스 의존성 주입
	
	//회원가입 쿼리 테스트 메서드
		@Test
		public void memberJoin() throws Exception{
			MemberDTO member = new MemberDTO();
			
			member.setId("test");
			member.setPwd("test");
			member.setName("name");
			member.setEmail("email");
			member.setTel("tel");
			member.setAddrNum("addrNum");
			member.setAddr1("addr1");
			member.setAddr2("addr2");
			
			membermapper.memberJoin(member);			//jUnit실행
			
		}
}
