package com.codingquokka.hansungvote.Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.codingquokka.hansungvote.domain.*;

@RequestMapping("/enquete")
@Controller
public class EnqueteController {

    @RequestMapping(value = "/enquetehome", method = RequestMethod.GET)
    public String enqueteHome(Locale locale, HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();

        UserVO user = (UserVO) session.getAttribute("UserVO");
        if (user == null) {
            sessionIsNull(response);
        }
        response.setContentType("text/html; charset=euc-kr");
        PrintWriter out = null;
        out = response.getWriter();
        out.println("<script>alert('준비중입니다.');" +
                "location.href = \"/main\";" +
                "</script>");
        out.flush();

        return "002_Main";
    }

    //----------------------------------Method------------------------------------------------------------------------//
    void sessionIsNull(HttpServletResponse response) throws IOException {
        response.setContentType("text/html; charset=euc-kr");
        PrintWriter out = null;
        out = response.getWriter();
        out.println("<script>alert('세션이 만료되었습니다. 다시 로그인해 주세요 :(');" +
                "location.href = \"/login\";" +
                "</script>");
        out.flush();
    }

}
