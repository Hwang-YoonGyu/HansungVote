package com.codingquokka.hansungenquete.Controller;

import java.io.IOException;
import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
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

		return "home";
	}

	@RequestMapping(value = "/submitImage", method = RequestMethod.GET)
	public String submitImage(Locale locale, Model model) {
		
		return "imgsubmitTest";
	}

	@RequestMapping(value = "/saveImage", method = RequestMethod.POST)
	public String saveImage(HttpServletRequest request, String title, String content) {
		MultipartHttpServletRequest mhsr = (MultipartHttpServletRequest) request;

		System.out.println(title + "  " + content);
		byte[] file = "0".getBytes();
		try {
			file = mhsr.getFile("imgFile").getBytes();
			if (file.length == 0) {
				return "redirect:/home";
			}

		} catch (IOException e1) {
			// TODO Auto-generated catch block
			System.out.println(e1.getMessage());
		}
		/*
		 * 파일 로컬에 저장하기 try { OutputStream output = new
		 * FileOutputStream("C:\\Users\\NCL-NT-0163\\Desktop\\Output.png"); byte[] by =
		 * file; output.write(by);
		 * 
		 * } catch (Exception e) { e.getStackTrace(); }
		 */
		CandidateVO cVo = new CandidateVO();
		cVo.setElection_Name(title);
		cVo.setImage(file);
		cVo.setVote_name(content);
		cVo.setVote_Count(0);
		cDao.insert(cVo);
		//cDao.selectList("데이터");
		return "redirect:/home";
	}

	@RequestMapping(value = "/getByteImage", method = RequestMethod.GET)
	public ResponseEntity<byte[]> getByteImage(HttpServletRequest request) {// ResponseEntity는 HttpEntity를 상속받음으로써
																			// HttpHeader와 body를 가질 수 있음
		String a = request.getParameter("number");
		int temp = Integer.parseInt(a);

		List<CandidateVO> list = cDao.selectList("test");
		System.out.println(list.size()+" "+temp);		
		byte[] imageContent = list.get(temp).getImage();
		final HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.IMAGE_PNG); // 미디어 타입을 나타내기 위한 헤더(헤더는 클라이언트와 서버가 요청 또는 응답으로 부가적인 정보를 전송할 수 있게
														// 해줌)
		return new ResponseEntity<byte[]>(imageContent, headers, HttpStatus.OK);
	}

	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public String view(HttpServletRequest request) {
		/*
		 * List<imgVO> list = iDao.getByteImage(); System.out.println(list.size());
		 * 
		 * byte[] imageContent = list.get(10).img; request.setAttribute("bydata",
		 * imageContent);
		 */
		request.setAttribute("imgSrc", "/hansungenquete/getByteImage?number=0");
		return "imgshowTest";
	}
}
