package com.codingquokka.hansungvote.Controller;

import java.io.PrintWriter;
import java.security.PrivateKey;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.codingquokka.hansungvote.domain.*;


@Controller
public class HomeController {
    //ServerLog logger = ServerLog.instance;

    @Inject
    private CandidateDAO cDao;

    @Inject
    private UserDAO uDao;

    @Inject
    private RSA rsa;

    @Inject
    private Defender defender;

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String welcome(HttpServletRequest request) {

        return login(request);
    }

    @RequestMapping(value = "/main", method = RequestMethod.GET)
    public String main(HttpServletRequest request) {
        if (defender.checkLastTime(request)) {
            return "home";
        }

        return "002_Main";
    }


    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login(HttpServletRequest request) {
        if (defender.checkLastTime(request)) {
            return "home";
        }
        rsa.initRsa(request);

        return "001_Login";
    }

    @RequestMapping(value = "/agreePop", method = RequestMethod.GET)
    public String agreePop(HttpServletRequest request) throws Exception {

        return "agreePop";
    }

    @RequestMapping(value = "/agreePop", method = RequestMethod.POST)
    public String agreePopPost(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        UserVO uVo = (UserVO) session.getAttribute("UserVO");
        System.out.println(uVo);
        if(uVo != null){
            if(uVo.getPhoneNumber().equals(request.getParameter("certPhoneNumber"))){
                uDao.agreeCount(uVo);
                return "redirect:/main";
            } else {
                response.setContentType("text/html; charset=euc-kr");
                PrintWriter out = response.getWriter();
                out.println("<script>alert('인증된 전화번호와 가입된 전화번호가 일치하지 않습니다.');" +
                        "location.href = \"/agreePop\";" +
                        "</script>");
                out.flush();
                return null;
            }

        }
        else{
            response.setContentType("text/html; charset=euc-kr");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('세션정보를 잃었습니다. 다시 로그인 해주세요');" +
                    "location.href = \"/login\";" +
                    "</script>");
            out.flush();
            return null;
        }

    }


    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String login(@RequestParam("stu_id") String stu_id, @RequestParam("phoneNumber") String phoneNumber, HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> paramMap) throws Exception {
        if (defender.checkLastTime(request)) {
            return "home";
        }


        UserVO uVo = new UserVO();
        HttpSession session = request.getSession();
        PrivateKey privateKey = (PrivateKey) session.getAttribute(RSA.RSA_WEB_KEY);


        uVo.setStuid(RSA.decryptRsa(privateKey, stu_id));
        session.removeAttribute(RSA.RSA_WEB_KEY);

        uVo.setPhoneNumber(RSA.decryptRsa(privateKey, phoneNumber));
        System.out.println(LocalDate.now() + " " + LocalTime.now() + ": " + uVo.getStuid() + " " + uVo.getPhoneNumber() + " try login");

        UserVO result = uDao.login(uVo);


        if (result != null) {

            session.setAttribute("UserVO", result);

            if ("manager".equals(result.getStuid())) {
                System.out.println(LocalDate.now() + " " + LocalTime.now() + ": " + result.getStuid() + " " + result.getPhoneNumber() + " login success");
                return "redirect:/mgr/main";

            } else {
                System.out.println(LocalDate.now() + " " + LocalTime.now() + ": " + result.getStuid() + " " + result.getPhoneNumber() + " login success");
                if (result.getAgree().equals("0")) {
                    return "redirect:/agreePop";

                } else {
                    return "redirect:/main";

                }
            }

        } else {
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

        byte[] imageContent = cVo.getImage();
        final HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.IMAGE_PNG); // 미디어 타입을 나타내기 위한 헤더(헤더는 클라이언트와 서버가 요청 또는 응답으로 부가적인 정보를 전송할 수 있게
        // 해줌)
        return new ResponseEntity<byte[]>(imageContent, headers, HttpStatus.OK);
    }

    @RequestMapping(value = "/defender", method = RequestMethod.GET)
    public void removeIP(@RequestParam String ip, HttpServletRequest request, HttpServletResponse response) throws Exception {

        HttpSession session = request.getSession();
        UserVO uVo = (UserVO) session.getAttribute("UserVO");
        if (ip != null && uVo.getStuid().equals("manager")) {
            defender.remove(ip);
            response.setContentType("text/html; charset=euc-kr");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('차단이 정상 해제되었습니다');" +
                    "location.href = \"/mgr/main\";" +
                    "</script>");
            out.flush();


        } else {
            response.setContentType("text/html; charset=euc-kr");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('비정상적인 접근입니다.');" +
                    "location.href = \"/login\";" +
                    "</script>");
            out.flush();
        }
    }

    @RequestMapping(value = "/sample1", method = RequestMethod.GET)
    public String sample1() {

        return "sample1";
    }

    @RequestMapping(value = "/error", method = RequestMethod.GET)
    public String error() {
        new Exception();
        return "";
    }

    @RequestMapping(value = "/sample2", method = RequestMethod.POST)
    public String sample2() {

        return "sample2";
    }

    @RequestMapping(value = "/sample3", method = RequestMethod.POST)
    public String sample3(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        UserVO uVo = (UserVO) session.getAttribute("UserVO");

        return "sample3";
    }

    @RequestMapping(value = "/sample4", method = RequestMethod.POST)
    public String sample4() {

        return "sample1";
    }
}
