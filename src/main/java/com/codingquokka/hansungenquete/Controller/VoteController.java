package com.codingquokka.hansungenquete.Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.*;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.codingquokka.hansungenquete.domain.*;

@RequestMapping("/vote")
@Controller
public class VoteController {

    @Inject
    private CandidateDAO cDao;

    @Inject
    private ElectionDAO eDao;

    @Inject
    private ElectionvotedDAO evDao;

    @Inject
    private UserDAO uDao;


    @RequestMapping(value = "/votehome", method = RequestMethod.GET)
    public String voteHome(Locale locale, HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();

        UserVO user = (UserVO) session.getAttribute("UserVO");
        if (user == null) {
            sessionIsNull(response);
        }
        String department = user.getDepartment();


        ElectionVO evVo = new ElectionVO();
        evVo.setDepartment(department);
        List<ElectionVO> electionList = eDao.selectElection(evVo);
        List<Float> votePercentageList = new ArrayList<Float>();
        List<Integer> voteRightCountList = new ArrayList<Integer>();
        for(ElectionVO e : electionList) {
            int voteRightCount = uDao.totalVoters(e.getDepartment());
            int votePercentage = evDao.turnout(e.getElectionName());
            votePercentageList.add(((float)votePercentage/voteRightCount*100));
            voteRightCountList.add(voteRightCount);
        }

        request.setAttribute("username", user.getName() + " (" + user.getStuid() + ")");
        request.setAttribute("electionList",electionList);

        request.setAttribute("votePercentageList",votePercentageList);
        request.setAttribute("voteRightCountList",voteRightCountList);
        return "003_Vote1";
    }


    @RequestMapping(value = "/voteDetail", method = RequestMethod.GET)
    public String voteDetail(Locale locale, HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        UserVO user = (UserVO)session.getAttribute("UserVO");
        if (user == null) {
            sessionIsNull(response);
        }
        String election = request.getParameter("electionName");

        ElectionVO eVo = eDao.selectSpecipicElection(election);


        if (LocalTime.now().getHour() < eVo.getStartDate().getHours() || LocalTime.now().getHour() >  eVo.getEndDate().getHours()) {
            response.setContentType("text/html; charset=euc-kr");
            PrintWriter out = null;
            out = response.getWriter();
            out.println("<script>alert('투표가능시간이 아닙니다');" +
                    "location.href = \"/vote/votehome\";" +
                    "</script>");
            out.flush();
        }

        Date now = new Date();
        if (now.before(eVo.getStartDate())) {
            response.setContentType("text/html; charset=euc-kr");
            PrintWriter out = null;
            out = response.getWriter();
            out.println("<script>alert('투표 시작 전입니다');" +
                    "location.href = \"/vote/votehome\";" +
                    "</script>");
            out.flush();
        }

        if (now.after(eVo.getEndDate())) {
            response.setContentType("text/html; charset=euc-kr");
            PrintWriter out = null;
            out = response.getWriter();
            out.println("<script>alert('투표가 이미 종료되었습니다.');" +
                    "location.href = \"/vote/votehome\";" +
                    "</script>");
            out.flush();
        }

        ElectionvotedVO evVo = new ElectionvotedVO();
        evVo.setStuId(user.getStuid());
        evVo.setName(user.getName());
        evVo.setDepartment(user.getDepartment());
        evVo.setElectionName(election);
        ElectionvotedVO wasVoted = evDao.wasVoted(evVo);


        if (wasVoted != null) {
            response.setContentType("text/html; charset=euc-kr");
            PrintWriter out = null;
            out = response.getWriter();
            out.println("<script>alert('중복투표는 불가합니다');" +
                    "location.href = \"/vote/votehome\";" +
                    "</script>");
            out.flush();
        }

        List<CandidateVO> candiList = cDao.selectList(election);
        request.setAttribute("candiList", candiList);


        return "004_Vote2";
    }

    @RequestMapping(value = "/doVote", method = RequestMethod.GET)
    public void doVote(Locale locale, HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        UserVO user = (UserVO)session.getAttribute("UserVO");
        if (user == null) {
            sessionIsNull(response);
        }

        ElectionvotedVO evVo = new ElectionvotedVO();
        evVo.setElectionName(request.getParameter("ElectionName"));
        evVo.setCandidateName(request.getParameter("CandidateName"));
        evVo.setStuId(user.getStuid());
        evVo.setName(user.getName());
        evVo.setDepartment(user.getDepartment());

        evDao.insertVote(evVo);

        response.setContentType("text/html; charset=euc-kr");
        PrintWriter out = null;
        out = response.getWriter();
        out.println("<script>alert('투표가 완료되었습니다. 감사합니다 :)');" +
                "location.href = \"/vote/votehome\";" +
                "</script>");
        out.flush();
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
