package com.codingquokka.hansungvote.Controller;

import com.codingquokka.hansungvote.domain.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.*;
import java.security.PrivateKey;

@RequestMapping("/mgr")
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

    @Inject
    private RSA rsa;
    @RequestMapping(value = "/main", method = RequestMethod.GET)
    public String main(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        UserVO uVo = (UserVO) session.getAttribute("UserVO");
        if (uVo != null && uVo.getStuid().equals("manager")) {
            return "Mgr001_Main";
        }
        else {
            return customResponse(response,"비정상적인 접근입니다.","\"/login\"");
        }


    }

    @RequestMapping(value = "/vote", method = RequestMethod.GET)
    public String vote(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        UserVO uVo = (UserVO) session.getAttribute("UserVO");
        if (uVo != null && uVo.getStuid().equals("manager")) {
            return "Mgr003_showTurnOutList";
        }
        else {
            return customResponse(response,"비정상적인 접근입니다.","\"/login\"");
        }
    }

    @RequestMapping(value = "/viewVote", method = RequestMethod.GET)
    public String viewVote(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        UserVO uVo = (UserVO) session.getAttribute("UserVO");
        if (uVo != null && uVo.getStuid().equals("manager")) {
            List<ElectionVO> eList = eDao.selectElectionAll();
            request.setAttribute("electionList", eList);
            return "Mgr002_ViewVote";
        }
        else {
            return customResponse(response,"비정상적인 접근입니다.","\"/login\"");
        }
    }

    @RequestMapping(value = "/showTurnOutList", method = RequestMethod.GET)
    public String showTurnOutList(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        UserVO uVo = (UserVO) session.getAttribute("UserVO");
        if (uVo != null && uVo.getStuid().equals("manager")) {

            String electionName = request.getParameter("electionName");
            ElectionVO eVo = eDao.selectSpecipicElection(electionName);
            List<Map<String, Object>> list = uDao.allUserWhoHaveRight(eVo);
            request.setAttribute("electionName", electionName);
            request.setAttribute("List", list);

            return "Mgr003_showTurnOutList";
        }
        else {
            return customResponse(response,"비정상적인 접근입니다.","\"/login\"");
        }
    }

    @RequestMapping(value = "/showTurnOutRate", method = RequestMethod.GET)
     public String showTurnOutRate(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        UserVO uVo = (UserVO) session.getAttribute("UserVO");
        if (uVo != null && uVo.getStuid().equals("manager")) {

            List<ElectionVO> allElection = eDao.selectElectionAll();
            List<Map<String,Object>> turnOutRateList = new ArrayList<>();
            for(ElectionVO e: allElection) {

                int voteRightCount =0;
                int votePercentage =0;

                if (!e.getDepartment().equals("delegate")) {
                    voteRightCount = uDao.totalVoters(e.getDepartment());
                    votePercentage = evDao.turnout(e.getElectionName());
                }
                else {
                    voteRightCount = uDao.totalVotersDelegate(e.getDepartment());
                    votePercentage = evDao.turnout(e.getElectionName());
                }
                Map<String,Object> temp = new HashMap<>();
                temp.put("rate",(float)votePercentage/voteRightCount*100);
                temp.put("electionName",e.getElectionName());
                turnOutRateList.add(temp);

            }
            request.setAttribute("turnOutRateList",turnOutRateList);
            return "Mgr008_showTurnOutRate";
        }
        else {
            return customResponse(response,"비정상적인 접근입니다.","\"/login\"");
        }
    }

    @RequestMapping(value = "/modifyElection", method = RequestMethod.GET)
    public String modifyElection(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        UserVO uVo = (UserVO) session.getAttribute("UserVO");
        if (uVo != null && uVo.getStuid().equals("manager")) {
            String electionName = request.getParameter("electionName");

            ElectionVO eVo = eDao.selectSpecipicElection(electionName);
            List<CandidateVO> cVoList = cDao.selectList(electionName);

            request.setAttribute("eVo", eVo);
            request.setAttribute("cVoList", cVoList);
            return "Mgr004_openVote";
        } else {
            return customResponse(response,"비정상적인 접근입니다.","\"/login\"");
        }
    }

    @RequestMapping(value = "/modifyElection", method = RequestMethod.POST)
    public String modifyElectionPOST(HttpServletRequest request, HttpServletResponse response) throws Exception {
        MultipartHttpServletRequest mhsr = (MultipartHttpServletRequest) request;

        ElectionVO eVo = new ElectionVO();

        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        String startDateString = request.getParameter("startDate") + " " + request.getParameter("startTime");
        Date startDate = format.parse(startDateString);
        String endDateString = request.getParameter("endDate") + " " + request.getParameter("endTime");
        Date endDate = format.parse(endDateString);
        String electionName = request.getParameter("electionName");

        eVo.setElectionName(electionName);
        eVo.setDepartment(request.getParameter("department"));
        eVo.setStartDate(startDate);
        eVo.setEndDate(endDate);
        eDao.insertElection(eVo);

        for (int i = 0; i < Integer.parseInt(request.getParameter("candidateCount")); i++) {
            String candidateName = request.getParameter("candidateName" + i);

            byte[] file = null;
            try {
                file = mhsr.getFile("candidatePic" + i).getBytes();
                if (file.length == 0) {
                    return customResponse(response,"파일 업로드 에러.\n관리자에게 문의하세요."," \"/manager/main\"");
                }
            } catch (IOException e1) {
                System.out.println(e1.getMessage());
            }

            CandidateVO cVo = new CandidateVO();
            cVo.setImage(file);
            cVo.setCandidateName(candidateName);
            cVo.setElectionName(electionName);
            cDao.insert(cVo);
        }
        return "redirect:/mgr/viewVote";
    }


    @RequestMapping(value = "/deleteElection", method = RequestMethod.GET)
    public String deleteAction(HttpServletRequest request, HttpServletResponse response) throws Exception {

        HttpSession session = request.getSession();
        UserVO uVo = (UserVO) session.getAttribute("UserVO");
        if (uVo != null && uVo.getStuid().equals("manager")) {

            String electionName = request.getParameter("electionName");

            cDao.deleteCandidate(electionName);
            eDao.deleteElection(electionName);

            return customResponse(response,"삭제가 완료되었습니다","\"/mgr/viewVote\"");

        } else {
            return customResponse(response,"비정상적인 접근입니다.","\"/login\"");
        }
    }

    @RequestMapping(value = "/ballotCount", method = RequestMethod.GET)
    public String ballotCount(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        UserVO uVo = (UserVO) session.getAttribute("UserVO");
        Date now = new Date();
        if (uVo != null && uVo.getStuid().equals("manager")) {
            ElectionVO eVo = eDao.selectSpecipicElection(request.getParameter("electionName"));
            System.out.println(request.getParameter("electionName"));

            if (now.before(eVo.getEndDate())) {
                return customResponse(response,"선거가 아직 종료되지 않았습니다.","\"/mgr/viewVote\"");
            }
            List<Map<String, String>> map = evDao.votepercentage(request.getParameter("electionName"));
            System.out.println(map);
            request.setAttribute("mapList", map);

            return "Mgr005_countVote";
        } else {
            return customResponse(response,"비정상적인 접근입니다.","\"/login\"");
        }
    }

    @RequestMapping(value = "/viewEnquete", method = RequestMethod.GET)
    public String viewEnquete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        UserVO uVo = (UserVO) session.getAttribute("UserVO");
        if (uVo != null && uVo.getStuid().equals("manager")) {
            return customResponse(response,"준비중입니다.","\"/mgr/main\"");
        } else {
            return customResponse(response,"비정상적인 접근입니다.","\"/login\"");
        }
    }

    @RequestMapping(value = "/addVoted", method = RequestMethod.GET)
    public String addVoted(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        UserVO uVo = (UserVO) session.getAttribute("UserVO");
        if (uVo != null && uVo.getStuid().equals("manager")) {
            rsa.initRsa(request);
            return "Mgr007_offLineVote";

        } else {
            return customResponse(response,"비정상적인 접근입니다.","\"/login\"");
        }
    }

    @RequestMapping(value = "/addVoted", method = RequestMethod.POST)
    public String addVotedPost(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        UserVO uVo = (UserVO) session.getAttribute("UserVO");
        PrivateKey privateKey = (PrivateKey) session.getAttribute(RSA.RSA_WEB_KEY);
        if (uVo != null && uVo.getStuid().equals("manager")) {

            String deStuId = RSA.decryptRsa(privateKey,request.getParameter("stuId"));
            String deName = RSA.decryptRsa(privateKey,request.getParameter("name"));

            Map<String, String> paramMap = new HashMap<>();
            paramMap.put("stuId",deStuId);
            paramMap.put("name",deName);

            UserVO user = uDao.findDepartmentOfUser(paramMap);

            if (user == null) {
                return customResponse(response,"입력 정보가 유효하지 않습니다.","\"/mgr/addVoted\"");
            }
            List<String> electionNameList = uDao.voteCan(user.getDepartment());


            for (String s :electionNameList) {
                ElectionvotedVO evVo = new ElectionvotedVO();
                evVo.setStuId(deStuId);
                evVo.setElectionName(s);
                ElectionvotedVO result = evDao.wasVoted(evVo);

                if (result != null) {
                    return customResponse(response,"이미 하나 이상의 선거에 투표를 완료한 유권자입니다.","\"/mgr/addVoted\"");

                }
            }

            for (String s : electionNameList) {
                ElectionvotedVO evVo = new ElectionvotedVO();
                evVo.setStuId(user.getStuid());
                evVo.setDepartment(user.getDepartment());
                evVo.setName(user.getName());
                evVo.setElectionName(s);
                evVo.setCandidateName("오프라인");
                evDao.insertVote(evVo);
            }
            return customResponse(response,"오프라인 투표 처리 되었습니다.","\"/mgr/addVoted\"");
        }
        else {
            return customResponse(response,"비정상적인 접근입니다.","\"/login\"");
        }
    }
    @RequestMapping(value = "/addUserDB", method = RequestMethod.GET)
    public String excelRead(HttpServletRequest request, HttpServletResponse response) throws IOException {

        HttpSession session = request.getSession();
        UserVO uVo = (UserVO) session.getAttribute("UserVO");
        if (uVo != null && uVo.getStuid().equals("manager")) {
            return "Mgr006_userDbUpdate";

        }
        else {
            return customResponse(response,"비정상적인 접근입니다.","\"/login\"");
        }

    }


    @RequestMapping(value = "/addUserDB", method = RequestMethod.POST)
    public String excelReadPOST(HttpServletRequest request, HttpServletResponse response) throws IOException {


        MultipartHttpServletRequest mhsr = (MultipartHttpServletRequest) request;
        byte[] bytesFile;

        try {
            bytesFile = mhsr.getFile("excelFile").getBytes();
            if (bytesFile.length == 0 || bytesFile ==null) {
                return customResponse(response,"파일 업로드 에러. 관리자에게 문의하세요.","\"/mgr/viewVote\"");
            }

            Thread thread = new Thread(new InputThread(bytesFile, uDao));
            thread.start();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return customResponse(response,"유권자 DB파일이 업로드 되었습니다.\n데이터삽입 스레드가 시작됩니다.","\"/mgr/viewVote\"");
    }

    @RequestMapping(value = "/electionDataDelete", method = RequestMethod.GET)
    public String electionDataDelete(HttpServletRequest request, HttpServletResponse response) throws Exception {

        HttpSession session = request.getSession();
        UserVO uVo = (UserVO) session.getAttribute("UserVO");
        if (uVo != null && uVo.getStuid().equals("manager")) {
            eDao.electionDataDelete();
            return customResponse(response,"모든 선거 데이터가 삭제 되었습니다.","\"/mgr/viewVote\"");
        }
        else {
            return customResponse(response,"비정상적인 접근입니다.","\"/login\"");
        }
    }

    @RequestMapping(value = "/userDataDelete", method = RequestMethod.GET)
    public String userDataDelete(HttpServletRequest request, HttpServletResponse response) throws Exception {

        HttpSession session = request.getSession();
        UserVO uVo = (UserVO) session.getAttribute("UserVO");
        if (uVo != null && uVo.getStuid().equals("manager")) {
            uDao.userDataDelete();
            return customResponse(response,"모든 유저 데이터가 삭제 되었습니다."," \"/mgr/viewVote\"");
        }
        else {
            return customResponse(response,"비정상적인 접근입니다.","\"/login\"");
        }
    }



    //----------------------------------Method------------------------------------------------------------------------//
    String customResponse(HttpServletResponse response, String msg, String link) throws IOException {
        response.setContentType("text/html; charset=euc-kr");
        PrintWriter out = null;
        out = response.getWriter();
        out.println("<script>alert(\""+msg+"\");\n" +
                "location.href = " + link + ";" +
                "</script>");
        out.flush();
        return null;
    }
}


