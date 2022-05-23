package org.conan.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import javax.print.attribute.standard.Media;

import org.conan.domain.Ticket;
import org.conan.vo.SampleVO;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/rsample")
@Log4j
@AllArgsConstructor
public class RsampleController {
	
	@GetMapping(value = "/getText", produces = "text/plain; charset=UTF-8")
	public String getText() {
		log.info("MINE TYPE : "+MediaType.TEXT_PLAIN_VALUE);
		return "하이 친구들";
	}
	
	@GetMapping(value = "getSample" , produces = {MediaType.APPLICATION_JSON_VALUE,MediaType.APPLICATION_XML_VALUE})
	public SampleVO getSample() {
		return new SampleVO(112,"스타","러드");
		
	}
	@GetMapping(value = "/getList")
	public List<SampleVO> getList(){
		return IntStream.range(1,10).mapToObj(i->new SampleVO(i,i+"first",i+"last"))
				.collect(Collectors.toList());
	}
	@GetMapping(value = "/getMap")
	public Map<String, SampleVO> getMap(){
		Map<String, SampleVO> map = new HashMap<>();
		map.put("First", new SampleVO(111,"구르트","주니어"));
		return map;
	}
	@GetMapping(value = "/check", params = {"height","weight"})
	public ResponseEntity<SampleVO> check(Double height, Double weight){
		SampleVO vo = new SampleVO(000,""+height,""+weight);
		ResponseEntity<SampleVO> result =null;
		if (height<150) {
			result = ResponseEntity.status(HttpStatus.BAD_GATEWAY).body(vo);
		} else {
			result = ResponseEntity.status(HttpStatus.OK).body(vo);
		}
		return result;
	}
	@GetMapping(value = "/product/{cat}/{pid}")
	  public String[] getPath(@PathVariable("cat") String cat,
	          @PathVariable("pid") String pid) {
	    return new String[] {"category: "+cat,"productid: "+pid};
	  }
	
	@PostMapping("/ticket")
	  public Ticket convert(@RequestBody Ticket ticket) {
	    log.info("connvert............ticket: "+ticket);
	    return ticket;
	  }
}



















