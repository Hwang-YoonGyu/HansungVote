package com.codingquokka.hansungenquete.Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.LocalTime;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.codingquokka.hansungenquete.domain.*;


@Controller
public class HomeController {
    //ServerLog logger = ServerLog.instance;

    @Inject
    private CandidateDAO cDao;

    @Inject
    private UserDAO uDao;

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String welcome(HttpServletRequest request) {
        return "redirect:/login";
    }
    @RequestMapping(value = "/main", method = RequestMethod.GET)
    public String main(HttpServletRequest request) {
        return "002_Main";
    }
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login(HttpServletRequest request) {
        return "001_Login";
    }
    @RequestMapping(value = "/login/accessDenied.do", method = RequestMethod.POST)
    public String loginDenied(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html; charset=euc-kr");
        PrintWriter out = response.getWriter();
        out.println("<script>alert('로그인 정보를 다시 확인해주세요 :(');" +
                "</script>");
        out.flush();
        return "001_Login";
    }
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String login(@RequestParam("stu_id") String stu_id, @RequestParam("password") String password, HttpServletRequest request, HttpServletResponse response) throws Exception {

        UserVO uVo = new UserVO();
        uVo.setStuid(stu_id);
        uVo.setPassword(password);

        UserVO result = uDao.login(uVo);

        if (result != null) {

            HttpSession session = request.getSession();
            session.setAttribute("UserVO", result);

            if ("manager".equals(result.getStuid())) {
                System.out.println(LocalDate.now()+" "+LocalTime.now()+": " +result.getStuid() + " " + result.getName()+" login");
                //logger.WriteLog(LocalDateTime.now().toString(), result.getStuid() + " " + result.getName()+" login");
                return "redirect:/manager/main";

            }
            System.out.println(LocalDate.now()+" "+LocalTime.now()+": " +result.getStuid() + " " + result.getName()+" login");
            //logger.WriteLog(LocalDateTime.now().toString(), result.getStuid() + " " + result.getName()+" login");
            return "redirect:/main";
        }
        else {
            response.setContentType("text/html; charset=euc-kr");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('로그인 정보를 다시 확인해주세요');" +
                    "location.href = \"/login\";" +
                    "</script>");
            out.flush();
            return "redirect:/login";
        }
    }

    @RequestMapping(value = "/getByteImage", method = RequestMethod.GET)
    public ResponseEntity<byte[]> getByteImage(HttpServletRequest request) {// ResponseEntity는 HttpEntity를 상속받음으로써
        // HttpHeader와 body를 가질 수 있음
        String candidateName = request.getParameter("candidateName");

        CandidateVO cVo = cDao.selectSpecipicCandidate(candidateName);
        System.out.println(cVo.getCandidateName());

        byte[] imageContent = cVo.getImage();
        final HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.IMAGE_PNG); // 미디어 타입을 나타내기 위한 헤더(헤더는 클라이언트와 서버가 요청 또는 응답으로 부가적인 정보를 전송할 수 있게
        // 해줌)
        return new ResponseEntity<byte[]>(imageContent, headers, HttpStatus.OK);
    }
}
