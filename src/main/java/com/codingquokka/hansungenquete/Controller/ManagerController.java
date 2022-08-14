package com.codingquokka.hansungenquete.Controller;

import com.codingquokka.hansungenquete.domain.*;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.Date;
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
        if (uVo != null && uVo.getStuid().equals("manager")) {
            return "Mgr001_Main";

        } else {
            return abnormal(response);
        }


    }

    @RequestMapping(value = "/vote", method = RequestMethod.GET)
    public String vote(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        UserVO uVo = (UserVO) session.getAttribute("UserVO");
        if (uVo != null && uVo.getStuid().equals("manager")) {
            return "Mgr003_showTurnOutList";

        } else {
            return abnormal(response);
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

        } else {
            return abnormal(response);
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


        } else {
            return abnormal(response);
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
            return abnormal(response);
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
        eVo.setExplain("");
        eDao.insertElection(eVo);

        for (int i = 0; i < Integer.parseInt(request.getParameter("candidateCount")); i++) {
            String candidateName = request.getParameter("candidateName" + i);

            byte[] file = null;
            try {
                file = mhsr.getFile("candidatePic" + i).getBytes();
                if (file.length == 0) {
                    request.setAttribute("msg", "error");
                    return "home";
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

        return "redirect:/manager/viewVote";
    }


    @RequestMapping(value = "/deleteElection", method = RequestMethod.GET)
    public String deleteAction(HttpServletRequest request, HttpServletResponse response) throws Exception {

        HttpSession session = request.getSession();
        UserVO uVo = (UserVO) session.getAttribute("UserVO");
        if (uVo != null && uVo.getStuid().equals("manager")) {

            String electionName = request.getParameter("electionName");

            cDao.deleteCandidate(electionName);
            eDao.deleteElection(electionName);


            response.setContentType("text/html; charset=euc-kr");
            PrintWriter out = null;
            out = response.getWriter();
            out.println("<script>alert('삭제가 완료되었습니다.');" +
                    "location.href = \"/manager/main\";" +
                    "</script>");
            out.flush();

            return null;

        } else {
            return abnormal(response);
        }
    }

    @RequestMapping(value = "/ballotCount", method = RequestMethod.GET)
    public String ballotCount(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        UserVO uVo = (UserVO) session.getAttribute("UserVO");
        if (uVo != null && uVo.getStuid().equals("manager")) {
            ElectionVO eVo = eDao.selectSpecipicElection(request.getParameter("electionName"));
            System.out.println(request.getParameter("electionName"));

//            if (LocalTime.now().getHour() < eVo.getEndDate().getHours()) {
//                response.setContentType("text/html; charset=euc-kr");
//                PrintWriter out = null;
//                out = response.getWriter();
//                out.println("<script>alert('선거가 아직 종료되지 않았습니다.');" +
//                        "location.href = \"/manager/viewVote\";" +
//                        "</script>");
//                out.flush();
//                return null;
//            }
            List<Map<String, String>> map = evDao.votepercentage(request.getParameter("electionName"));
            System.out.println(map);
            request.setAttribute("mapList", map);

            return "Mgr005_countVote";
        } else {
            return abnormal(response);
        }
    }

    @RequestMapping(value = "/viewEnquete", method = RequestMethod.GET)
    public String viewEnquete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        UserVO uVo = (UserVO) session.getAttribute("UserVO");
        if (uVo != null && uVo.getStuid().equals("manager")) {
            response.setContentType("text/html; charset=euc-kr");
            PrintWriter out = null;
            out = response.getWriter();
            out.println("<script>alert('준비중입니다.');" +
                    "location.href = \"/manager/main\";" +
                    "</script>");
            out.flush();

            return "redirect:/manager/main";

        } else {
            return abnormal(response);
        }
    }

    @RequestMapping(value = "/addVoted", method = RequestMethod.GET)
    public String addVoted(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        UserVO uVo = (UserVO) session.getAttribute("UserVO");
        if (uVo != null && uVo.getStuid().equals("manager")) {

            return "Mgr007_offLineVote";

        } else {
            return abnormal(response);
        }
    }

    @RequestMapping(value = "/addVoted", method = RequestMethod.POST)
    public String addVotedPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        UserVO uVo = (UserVO) session.getAttribute("UserVO");
        if (uVo != null && uVo.getStuid().equals("manager")) {
            System.out.println(request.getParameter("stuId"));
            System.out.println(request.getParameter("name"));

            ElectionvotedVO evVo = new ElectionvotedVO();




            response.setContentType("text/html; charset=euc-kr");
            PrintWriter out = null;
            out = response.getWriter();
            out.println("<script>alert('오프라인 투표 완료 처리 되었습니다..');" +
                    "location.href = \"/manager/addVoted\";" +
                    "</script>");
            out.flush();

            return null;

        } else {
            return abnormal(response);
        }
    }
    @RequestMapping(value = "/addUserDB", method = RequestMethod.GET)
    public String excelRead(HttpServletRequest request, HttpServletResponse response) throws IOException {

        HttpSession session = request.getSession();
        UserVO uVo = (UserVO) session.getAttribute("UserVO");
        if (uVo != null && uVo.getStuid().equals("manager")) {

            return "Mgr006_userDbUpdate";

        } else {
            return abnormal(response);
        }

    }


    @RequestMapping(value = "/addUserDB", method = RequestMethod.POST)
    public String excelReadPOST(HttpServletRequest request, HttpServletResponse response) {


        MultipartHttpServletRequest mhsr = (MultipartHttpServletRequest) request;
        byte[] bytesFile = null;

        try {
            bytesFile = mhsr.getFile("excelFile").getBytes();
            if (bytesFile.length == 0) {
                response.setContentType("text/html; charset=euc-kr");
                PrintWriter out = null;
                out = response.getWriter();
                out.println("<script>alert(error : 파일업로드 에러.\n 관리자에게 문의하세요.');" +
                        "location.href = \"/manager/main\";" +
                        "</script>");
                out.flush();

                return "redirect:/manager/main";
            }

            Thread thread = new Thread(new InputThread(bytesFile, uDao));
            thread.start();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "redirect:/manager/viewVote";
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

        return null;
    }

    String abnormal(HttpServletResponse response) throws IOException {
        response.setContentType("text/html; charset=euc-kr");
        PrintWriter out = null;
        out = response.getWriter();
        out.println("<script>alert('비정상적인 접근입니다.');" +
                "location.href = \"/login\";" +
                "</script>");
        out.flush();
        return null;
    }
}

class InputThread implements Runnable {
    private byte[] bytesFile;

    private UserDAO uDao;

    public InputThread(byte[] file, UserDAO uDao) {
        this.uDao = uDao;
        this.bytesFile = file;
    }

    @Override
    public void run() {
        InputStream in = new ByteArrayInputStream(bytesFile);
        XSSFWorkbook workbook = null;
        try {
            workbook = new XSSFWorkbook(in);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

        int rowNo = 0;
        int cellIndex = 0;

        XSSFSheet sheet = workbook.getSheetAt(0); // 0 번째 시트를 가져온다
        // 만약 시트가 여러개 인 경우 for 문을 이용하여 각각의 시트를 가져온다
        int rows = sheet.getPhysicalNumberOfRows(); // 사용자가 입력한 엑셀 Row수를 가져온다
        for (rowNo = 1; rowNo < rows; rowNo++) {

            XSSFRow row = sheet.getRow(rowNo);

            if (row != null) {

                int cells = row.getPhysicalNumberOfCells(); // 해당 Row에 사용자가 입력한 셀의 수를 가져온다
                String[] temp = new String[5];

                for (cellIndex = 0; cellIndex <= cells; cellIndex++) {
                    XSSFCell cell = row.getCell(cellIndex); // 셀의 값을 가져온다
                    String value = "";
                    if (cell == null) { // 빈 셀 체크
                        continue;
                    } else {
                        // 타입 별로 내용을 읽는다
                        switch (cell.getCellType()) {
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
                    temp[cellIndex] = value;
                }
                UserVO uVo = new UserVO();
                uVo.setStuid(temp[0]);
                uVo.setName(temp[1]);
                uVo.setPassword(temp[2]);
                uVo.setPhoneNumber(temp[3]);
                uVo.setDepartment(temp[4]);

                try {
                    uDao.insertUser(uVo);
                } catch (Exception e) {
                    throw new RuntimeException(e);
                }
            }
        }
    }
}
