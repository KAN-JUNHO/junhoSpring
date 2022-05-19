package org.conan.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.conan.vo.BoardVO;

public interface BoardMapper {

//	@Select("SELECT * from tbl_board where bno>0")
	public List<BoardVO> getList();
	public void insert(BoardVO board);
	public void insertSelectKey(BoardVO board);
	public BoardVO read(long a);
	public BoardVO delete(long a);
	public int update(BoardVO board);
	
	
}
