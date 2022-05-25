package org.conan.vo;

import lombok.Data;

@Data
public class BoardAttachVO {
	private String uuid;
	private String uploadPath;
	private String fileName;
	private boolean fileType; //이미ㅣ지 파일 첨부
	private Long bno;
	
	
}
