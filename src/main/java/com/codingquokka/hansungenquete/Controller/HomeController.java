package com.codingquokka.hansungenquete.Controller;

import java.io.IOException;
import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.codingquokka.hansungenquete.*;
import com.codingquokka.hansungenquete.domain.*;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Inject
	private CandidateDAO cDao;

	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);

		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);

		String formattedDate = dateFormat.format(date);

		model.addAttribute("serverTime", formattedDate);
		class asd extends Thread {
			@Override
			public void run() {

			}
		}

		return "home";
	}

//	@RequestMapping(value = "/saveImage", method = RequestMethod.POST)
//	public String saveImage(HttpServletRequest request, String election_name, String candidate_name) {
//		MultipartHttpServletRequest mhsr = (MultipartHttpServletRequest) request;
//		byte[] file;
//		try {
//			file = mhsr.getFile("imgFile").getBytes();
//
//		} catch (IOException e1) {
//			file = "0".getBytes();
//			System.out.println(e1.getMessage());
//		}
//
//		CandidateVO cVo = new CandidateVO();
//		cVo.setImage(file);
//		cVo.setElection_Name(election_name);
//		cVo.setVote_name(candidate_name);
//		
//		cDao.insert(cVo);
//
//		return "home";
//	}
//
//	@RequestMapping(value = "/getByteImage")
//	public ResponseEntity<byte[]> getByteImage() {// ResponseEntity는 HttpEntity를 상속받음으로써 HttpHeader와 body를 가질 수 있음
//		Map<String, Object> map = iDao.getByteImage(1);
//		System.out.println(map.get("img").toString());
//
//		byte[] imageContent = (byte[]) map.get("img");
//		final HttpHeaders headers = new HttpHeaders();
//		headers.setContentType(MediaType.IMAGE_PNG); // 미디어 타입을 나타내기 위한 헤더(헤더는 클라이언트와 서버가 요청 또는 응답으로 부가적인 정보를 전송할 수 있게
//														// 해줌)
//		return new ResponseEntity<byte[]>(imageContent, headers, HttpStatus.OK);
//	}
//
//	@RequestMapping(value = "/ view")
//	public String view() {
//		return "imgView";
//	}
//
//	public class asd extends Thread {
//		@Override
//		public void run() {
//
//		}
//	}

}
