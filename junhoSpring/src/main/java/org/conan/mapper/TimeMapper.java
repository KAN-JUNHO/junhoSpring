package org.conan.mapper;

import org.apache.ibatis.annotations.Select;

public interface TimeMapper {
	@Select("SELECT SYSDATE FROM DUAL")
	public String getTime();	//annotation
	public String getTime2();   //XML
}
