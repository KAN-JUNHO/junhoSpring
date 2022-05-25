package org.conan.service;

import java.util.List;

import org.conan.domain.Criteria;
import org.conan.vo.BoardVO;

public interface BoardService {
	public void register(BoardVO board);
	public BoardVO get(Long bno);
	public boolean modify(BoardVO board);
	public boolean remove(Long bno);
	public List<BoardVO> getList(Criteria criteria);
	public int getTotal(Criteria cri);

}
