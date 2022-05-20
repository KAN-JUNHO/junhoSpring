package org.conan.service;

import static org.junit.Assert.assertNotNull;

import org.conan.config.RootConfig;
import org.conan.vo.BoardVO;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {RootConfig.class})
@Log4j
public class BoardServiceTest {
	@Setter(onMethod_ = {@Autowired})
	private BoardService service;
	
	@Test
	public void testExist() {
		log.info(service);
		assertNotNull(service);
	}
	
	@Test
	public void testGetList() {
		service.getList().forEach(board -> log.info(board));
	}
	@Test
	public void testRegister() {
		BoardVO board = new BoardVO();
		board.setTitle("새글 새글 새글 from service");
		board.setContent("새내용 새내영 from service");
		board.setWriter("newbie");
		service.register(board);
		log.info("생성된 게시물 번호 : "+board.getBno());
		
	}
	@Test
	public void testGet() {
		log.info(service.get(6L).getTitle());
	}
	
	@Test
	public void testDelete() {
		log.info("REMOVE RESULT : "+service.remove(8L));
	}
	@Test
	public void testUpdate() {
		BoardVO board = service.get(6L);
		if (board==null) {
			return;
		}
		board.setTitle("제목 수정 from Service");
		log.info("MODIFY RESULT : "+service.modify(board));
	}
	
	
}















