package org.conan.controller;

import java.util.List;

import org.conan.domain.ReplyVO;
import org.conan.service.ReplyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/replies")
@RestController
@Log4j
@AllArgsConstructor
public class ReplyController {

	private ReplyService service;

	@PostMapping(value =  "/new",consumes = "application/json",produces = {MediaType.TEXT_PLAIN_VALUE})
	 public ResponseEntity<String> create (@RequestBody ReplyVO vo) {
	    
	 int insertCount = service.register(vo);
	  
	 return insertCount == 1? new ResponseEntity<>("success", HttpStatus.OK)
	    :new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	  
	  @GetMapping(value = "/pages/{bno}/{page}", produces =  {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_ATOM_XML_VALUE})
	  public ResponseEntity<List<ReplyVO>> getList(@PathVariable("bno") Long bno,@PathVariable("page") int page) {
	    return new ResponseEntity<>(service.getListByBno(bno) ,HttpStatus.OK);
	}
	@GetMapping(value ="/{rno}", produces = {MediaType.APPLICATION_XML_VALUE,MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<ReplyVO> get(@PathVariable("rno")Long rno){
		log.info("get : "+rno);
		return new ResponseEntity<>(service.get(rno),HttpStatus.OK);
	}
	
	@DeleteMapping(value = "/{rno}", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@PathVariable("rno")Long rno){
		log.info("remove : "+rno);
		return service.remove(rno)==1
		? new ResponseEntity<>("successs",HttpStatus.OK)
		: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	@RequestMapping(method = {RequestMethod.PUT,RequestMethod.PATCH},value = "/{rno}", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(@RequestBody ReplyVO vo, @PathVariable("rno")Long rno){
		vo.setRno(rno);
		log.info("rno : "+rno);
		log.info("modify : "+vo);
		return service.modify(vo)==1 ? new ResponseEntity<>("success",HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
}













