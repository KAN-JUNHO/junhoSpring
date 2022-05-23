package org.conan.board;

import java.util.List;
import java.util.stream.IntStream;

import org.conan.config.RootConfig;
import org.conan.domain.ReplyVO;
import org.conan.mapper.BoardMapper;
import org.conan.mapper.ReplyMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import oracle.net.aso.m;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {RootConfig.class})
@Log4j
public class TicketMapperTest {
	@Setter(onMethod_ = @__({@Autowired}))
	private ReplyMapper mapper;
	
	@Test
	public void testMapper() {
		log.info(mapper);
	}
	
	private Long[] bnoArr= {41L,42L,43L,44L,45L};  //게시글 번호
	@Test
	public void testCreate() {
		IntStream.rangeClosed(1, 10).forEach(i-> {
		ReplyVO vo = new ReplyVO();
		vo.setBno(bnoArr[i%5]);
		vo.setReply("댓글 테스트 "+i);
		vo.setReplyer("replyer"+i);
		System.out.println("1213214241           "+vo.toString());
		mapper.insert(vo);
		});
	}
	@Test
	public void testRead() {
		Long targetRno = 5L;
		ReplyVO vo = mapper.read(targetRno);
	}
	@Test
	public void testDelete() {
		Long targetRno=1L;
		mapper.delete(targetRno);
	}
	@Test
	public void testUpdate() {
		Long targetRno = 10L;
		ReplyVO vo = mapper.read(targetRno);
		vo.setReply("update Reply");
		int count = mapper.update(vo);
		log.info("update count : "+count);
	}
	@Test
	public void testList() {
		List<ReplyVO> replies=
		mapper.getListByBno(bnoArr[0]);	
		replies.forEach(reply -> log.info(replies));
	}
}













