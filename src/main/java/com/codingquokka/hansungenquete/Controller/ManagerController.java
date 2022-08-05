package com.codingquokka.hansungenquete.Controller;

import com.codingquokka.hansungenquete.domain.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

@RequestMapping("/manager")
@Controller
public class ManagerController {

    @Inject
    private CandidateDAO cDao;

    @Inject
    private ElectionDAO eDao;

    @Inject
    private ElectionvotedDAO evDao;

    @Inject
    private UserDAO uDao;

    @RequestMapping(value = "/main", method = RequestMethod.GET)
    public String main(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        UserVO uVo = (UserVO) session.getAttribute("UserVO");
        if (uVo != null) {
            if (uVo.getStuid().equals("manager")) {
                return "Mgr001_Main";

            }
            else {
                return abnormal(response);
            }
        }
        else {
            return abnormal(response);
        }


    }
    @RequestMapping(value = "/vote", method = RequestMethod.GET)
    public String vote(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        UserVO uVo = (UserVO) session.getAttribute("UserVO");
        if (uVo != null) {
            if (uVo.getStuid().equals("manager")) {
                return "Mgr003_showTurnOutList";

            }
            else {
                return abnormal(response);
            }
        }
        else {
            return abnormal(response);
        }
    }

    @RequestMapping(value = "/viewVote", method = RequestMethod.GET)
    public String viewVote(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        UserVO uVo = (UserVO) session.getAttribute("UserVO");
        if (uVo != null) {
            if (uVo.getStuid().equals("manager")) {
                List<ElectionVO> eList = eDao.selectElectionAll();
                request.setAttribute("electionList", eList);
                return "Mgr002_ViewVote";

            }
            else {
                return abnormal(response);
            }
        }
        else {
            return abnormal(response);
        }
    }
    @RequestMapping(value = "/showTurnOutList", method = RequestMethod.GET)
    public String showTurnOutList(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        UserVO uVo = (UserVO) session.getAttribute("UserVO");
        if (uVo != null) {
            if (uVo.getStuid().equals("manager")) {
                String electionName = request.getParameter("electionName");
                ElectionVO eVo = eDao.selectSpecipicElection(electionName);
                List<Map<String, Object>> list = uDao.allUserWhoHaveRight(eVo);
                request.setAttribute("electionName", electionName);
                request.setAttribute("List",list);

                return "Mgr003_showTurnOutList";

            }
            else {
                return abnormal(response);
            }
        }
        else {
            return abnormal(response);
        }
    }

    @RequestMapping(value = "/modifyElection", method = RequestMethod.GET)
    public String modifyElection(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        UserVO uVo = (UserVO) session.getAttribute("UserVO");
        if (uVo != null) {
            if (uVo.getStuid().equals("manager")) {


                return "Mgr004_openVote";

            }
            else {
                return abnormal(response);
            }
        }
        else {
            return abnormal(response);
        }
    }
    @RequestMapping(value = "/ballotCount", method = RequestMethod.GET)
    public String ballotCount(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        UserVO uVo = (UserVO) session.getAttribute("UserVO");
        if (uVo != null) {
            if (uVo.getStuid().equals("manager")) {


                return "Mgr003_showTurnOutList";

            }
            else {
                return abnormal(response);
            }
        }
        else {
            return abnormal(response);
        }
    }

    @RequestMapping(value = "/viewEnquete", method = RequestMethod.GET)
    public String viewEnquete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        UserVO uVo = (UserVO) session.getAttribute("UserVO");
        if (uVo != null) {
            if (uVo.getStuid().equals("manager")) {
                response.setContentType("text/html; charset=euc-kr");
                PrintWriter out = null;
                out = response.getWriter();
                out.println("<script>alert('준비중입니다.');" +
                        "location.href = \"/manager/main\";" +
                        "</script>");
                out.flush();

                return "redirect:/manager/main";

            }
            else {
                return abnormal(response);
            }
        }
        else {
            return abnormal(response);
        }
    }


    //----------------------------------Method------------------------------------------------------------------------//
    String sessionIsNull(HttpServletResponse response) throws IOException {
        response.setContentType("text/html; charset=euc-kr");
        PrintWriter out = null;
        out = response.getWriter();
        out.println("<script>alert('세션이 만료되었습니다. 다시 로그인해 주세요 :(');" +
                "location.href = \"/login\";" +
                "</script>");
        out.flush();

        return "redirect:/login";
    }
    String abnormal (HttpServletResponse response) throws IOException {
        response.setContentType("text/html; charset=euc-kr");
        PrintWriter out = null;
        out = response.getWriter();
        out.println("<script>alert('비정상적인 접근입니다.');" +
                "location.href = \"/login\";" +
                "</script>");
        out.flush();
        return "redirect:/login";
    }
}
