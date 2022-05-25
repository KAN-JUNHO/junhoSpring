package org.conan.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.conan.vo.BoardAttachVO;
import org.conan.vo.BoardVO;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Log4j
@Controller
public class UploadController {

	
	@GetMapping("/uploadAjax")
	public void uploadAjax() {
		log.info("upload ajax");
	}
	@PostMapping(value = "/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<BoardAttachVO>> uploadAjaxPost(MultipartFile[] uploadFile){
		String uploadFolder = "e:/upload";
		List <BoardAttachVO> list = new ArrayList<BoardAttachVO>();
		
		File uploadPath = new File(uploadFolder,getFolder());
		log.info("upload Path : "+uploadPath);
		
		if(uploadPath.exists()==false) {
			log.info("upload Path2222 : "+uploadPath);
			uploadPath.mkdirs();
		}

		for(MultipartFile multipartFile: uploadFile) {
			BoardAttachVO attachVO = new BoardAttachVO();
			log.info("-----------");
			log.info("Upload File Name : "+multipartFile.getOriginalFilename());
			log.info("Upload File Size : "+multipartFile.getSize());
			UUID uuid = UUID.randomUUID();
			String uploadFileName = multipartFile.getOriginalFilename();
			attachVO.setFileName(uploadFileName);
			uploadFileName = uuid.toString()+"_"+uploadFileName;

			File saveFile = new File(uploadPath,uploadFileName);
			try {
				multipartFile.transferTo(saveFile);
				attachVO.setUuid(uuid.toString());
				attachVO.setUploadPath(getFolder());
				if(checkImageType(saveFile)) {
					attachVO.setFileType(true);
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath,"s_"+uploadFileName));
					Thumbnailator.createThumbnail(multipartFile.getInputStream(),thumbnail,10,10);
					thumbnail.close();
				}
				list.add(attachVO);
				log.info("attachVO : "+attachVO);
			}catch (Exception e) {
				log.error(e.getMessage());
			}
		}//for
		return new ResponseEntity<>(list,HttpStatus.OK);
	}
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]>getFile(String fileName){
		log.info("fileName: "+fileName);
		File file = new File("e:/upload/"+fileName);
		log.info("file: "+file);
		ResponseEntity<byte[]> result=null;
		try {
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type",Files.probeContentType(file.toPath()));
			//적당한 MINE 타입을 헤더에 추가
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file),header,HttpStatus.OK);
		} catch (IOException e) {
			e.printStackTrace();
			
		}	
		return result;
	}


	
	@GetMapping(value = "/download" ,produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	  @ResponseBody
	  public ResponseEntity<Resource> downloadFile (String fileName){
		log.info("download file : "+fileName);
		Resource resource = new FileSystemResource("e:/upload/"+fileName);
		if(resource.exists()==false) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		log.info("resource : "+resource);
	    String resourceName = resource.getFilename();
	    //remove UUID 추가된부ㅜㄴ
	    String resourceOriginalName = resourceName.substring(resourceName.indexOf("_")+1);
	    log.info("resourceOriginalName: "+resourceOriginalName);
	    HttpHeaders headers = new HttpHeaders();
	    try {
	    headers.add("Content-Disposition", "attachment; fileName="+new String(resourceOriginalName.getBytes("UTF-8"),"ISO-8859-1"));
	  } catch (Exception e) {
	    e.printStackTrace();
	  }
	    return new ResponseEntity<>(resource,headers,HttpStatus.OK);
	  }
	  
	  private String getFolder() {
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	    Date date = new Date();
	    String str = sdf.format(date);
	    return str.replace("-", File.separator);
	  }
	  private boolean checkImageType(File file) {
	    try {
	    String contentType = Files.probeContentType(file.toPath());
	    return contentType.startsWith("image");
	  } catch (Exception e) {
	    e.printStackTrace();
	  }
	    return false;
	  }
	
	  @PostMapping("/deleteFile")
	  @ResponseBody
	  public ResponseEntity<String> deleteFile(String fileName,String type){
		 log.info("deleteFile : "+fileName); 
		 File file;
		 try {
			 file =new File("e:/upload/"+URLDecoder.decode(fileName,"UTF-8"));
			 file.delete();
			 if(type.equals("image")){
				 String largeFileName = file.getAbsolutePath().replace("s_","");
				 log.info("largeFileName: "+largeFileName);
				 file = new File(largeFileName);
				 file.delete();
			 }
		 }catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		return new ResponseEntity<String>("deleted",HttpStatus.OK);
	  }
	  


}






















