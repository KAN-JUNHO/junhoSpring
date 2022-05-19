package org.conan.domain;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.bind.annotation.ModelAttribute;

import lombok.Data;

@Data
public class SampleDTOList {
	private List<SampleDTO> list;
	public SampleDTOList() {
		list = new ArrayList<>();
				
	}
	
}
