package kr.spring.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class FileUtil {
	//업로드 상대 경로
	private static final String UPLOAD_PATH = "/upload";
	
	//파일 업로드 처리
	public static String createFile(
			                   HttpServletRequest request,
			                   MultipartFile file)
	                         throws IllegalStateException,
	                                IOException{
		//컨텍스트 루트상의 절대 경로 구하기
		String path = 
			request.getServletContext().getRealPath(UPLOAD_PATH);
		String filename = null;
		if(file!=null && !file.isEmpty()) {
			//파일명이 중복되지 않도록 파일명 변경
			//원래 파일명을 보존하지 않을 경우
			filename = UUID.randomUUID()+
					    file.getOriginalFilename().substring(
					    	file.getOriginalFilename()
					    	    .lastIndexOf("."));
			// _ 이후에 원래 파일명을 보존할 경우
			//filename = UUID.randomUUID()+"_"+file.getOriginalFilename();
			file.transferTo(new File(path+"/"+filename));
		}		
		return filename;
	}
	//파일 삭제
	public static void removeFile(HttpServletRequest request,
			                            String filename) {
		if(filename!=null) {
			//컨텍스트 루트상의 절대 경로 구하기
			String path = request.getServletContext()
					             .getRealPath(UPLOAD_PATH);
			File file = new File(path+"/"+filename);
			if(file.exists()) file.delete();
		}
	}
	
	//지정한 경로의 파일을 읽어들여 byte 배열로 변환
	public static byte[] getBytes(String path) {
		FileInputStream fis = null;
		byte[] readbyte = null;
		try {
			fis = new FileInputStream(path);
			readbyte = new byte[fis.available()];
			fis.read(readbyte);
		}catch(Exception e) {
			log.error(e.toString());
		}finally {
			if(fis!=null)try {fis.close();}catch(IOException e) {}
		}
		return readbyte;
	}
}
