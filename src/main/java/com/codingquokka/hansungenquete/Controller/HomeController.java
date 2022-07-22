package com.codingquokka.hansungenquete.Controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.codingquokka.hansungenquete.*;
import com.codingquokka.hansungenquete.domain.*;


@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Inject
	private CandidateDAO cDao;

	@Inject UserDAO uDao;

	@RequestMapping(value = "/lobby", method = RequestMethod.GET)
	public String Lobby(HttpServletRequest request) {



		//return "000_Lobby";
		return "home";
	}

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String Login(HttpServletRequest request) {



		return "001_Login";
		//return "home";
	}
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String Login(@RequestParam("stu_id") String stu_id, @RequestParam("password") String password, HttpServletRequest request, HttpServletResponse response) throws Exception {

		UserVO uVo = new UserVO();
		uVo.setStu_id(stu_id);
		uVo.setPassword(password);

		System.out.println(uVo.getStu_id()+" "+uVo.getPassword());

		UserVO result = uDao.login(uVo);
		if (result==null) {
			System.out.println("널임 ㅂㅅ");
		}


		System.out.println(result.toString());


		 if (stu_id.equals(result.getStu_id())) {
			 return "redirect:/lobby";
		 }
		else {
			 PrintWriter out = null;
			 try {
				 out = response.getWriter();
			 } catch (IOException e) {
				 throw new RuntimeException(e);
			 }
			 out.println("<script>alert('로그인정보를 다시 입력해주세요.'); </script>");
			 out.flush();
			 return "redirect:/login";
		 }
	}



	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);

		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);

		String formattedDate = dateFormat.format(date);

		model.addAttribute("msg", formattedDate.toString());

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
		byte[] file = null;
		try {
			file = mhsr.getFile("imgFile").getBytes();
			if (file.length == 0) {
				request.setAttribute("msg", "파일 저장 실패");
				return "home";
			}

		} catch (IOException e1) {
			// TODO Auto-generated catch block
			System.out.println(e1.getMessage());
		}

		CandidateVO cVo = new CandidateVO();
		cVo.setElection_Name(title);
		cVo.setImage(file);
		cVo.setVote_name(content);
		cVo.setVote_Count(0);
		cDao.insert(cVo);
		request.setAttribute("msg", "파일 저장 성공");
		return "home";
	}

	@RequestMapping(value = "/getByteImage", method = RequestMethod.GET)
	public ResponseEntity<byte[]> getByteImage(HttpServletRequest request) {// ResponseEntity는 HttpEntity를 상속받음으로써
																			// HttpHeader와 body를 가질 수 있음
		String a = request.getParameter("number");
		int temp = Integer.parseInt(a);

		List<CandidateVO> list = cDao.selectList("테스트 선거");
		System.out.println(list.size()+" "+temp);		
		byte[] imageContent = list.get(temp).getImage();
		final HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.IMAGE_PNG); // 미디어 타입을 나타내기 위한 헤더(헤더는 클라이언트와 서버가 요청 또는 응답으로 부가적인 정보를 전송할 수 있게
													 // 해줌)
		return new ResponseEntity<byte[]>(imageContent, headers, HttpStatus.OK);
	}

	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public String view(HttpServletRequest request) {

		request.setAttribute("imgSrc", "/hansungenquete/getByteImage?number=0");
		return "imgshowTest";
	}
	
	@RequestMapping(value = "/excel", method = RequestMethod.GET)
	public String excelRead(HttpServletRequest request){
        String result = "";

	    try {
	    	// 경로에 있는 파일을 읽
	        FileInputStream file = new FileInputStream("C:\\User_Excel_Example.xlsx");
	        XSSFWorkbook workbook = new XSSFWorkbook(file);
	
	        int rowNo = 0;
	        int cellIndex = 0;
	        
	        XSSFSheet sheet = workbook.getSheetAt(0); // 0 번째 시트를 가져온다 
	        										  // 만약 시트가 여러개 인 경우 for 문을 이용하여 각각의 시트를 가져온다
	        int rows = sheet.getPhysicalNumberOfRows(); // 사용자가 입력한 엑셀 Row수를 가져온다
	        for(rowNo = 0; rowNo < rows; rowNo++){
	            XSSFRow row = sheet.getRow(rowNo);
	            if(row != null){
	                int cells = row.getPhysicalNumberOfCells(); // 해당 Row에 사용자가 입력한 셀의 수를 가져온다
	                for(cellIndex = 0; cellIndex <= cells; cellIndex++){  
	                    XSSFCell cell = row.getCell(cellIndex); // 셀의 값을 가져온다	        
	                    String value = "";	                    
	                    if(cell == null){ // 빈 셀 체크 
	                        continue;
	                    }else{
	                        // 타입 별로 내용을 읽는다
	                        switch (cell.getCellType()){
	                        case XSSFCell.CELL_TYPE_FORMULA:
	                            value = cell.getCellFormula();
	                            break;
	                        case XSSFCell.CELL_TYPE_NUMERIC:
	                            value = cell.getNumericCellValue() + "";
	                            break;
	                        case XSSFCell.CELL_TYPE_STRING:
	                            value = cell.getStringCellValue() + "";
	                            break;
	                        case XSSFCell.CELL_TYPE_BLANK:
	                            value = cell.getBooleanCellValue() + "";
	                            break;
	                        case XSSFCell.CELL_TYPE_ERROR:
	                            value = cell.getErrorCellValue() + "";
	                            break;
	                        }
	                    }
	                    result += value + "  ";
	                    System.out.println( rowNo + "번 행 : " + cellIndex + "번 열 값은: " + value);
	                }
	            }
	            result += "<br>";
	        }
	    }catch(Exception e) {
    		e.printStackTrace();
    	}
        request.setAttribute("msg",result);

	    return "home";
	}
}
