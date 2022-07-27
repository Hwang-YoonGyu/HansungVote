package com.codingquokka.hansungenquete.Controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.codingquokka.hansungenquete.*;
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
    public String VoteHome(Locale locale, HttpServletRequest request) throws Exception {
        HttpSession session = request.getSession();

        UserVO user = (UserVO) session.getAttribute("UserVO");
        List<ElectionVO> electionList = eDao.SelectElection(user.getDepartment());


        request.setAttribute("username", user.getName() + " (" + user.getStu_id() + ")");
        request.setAttribute("electionList",electionList);

        return "003_Vote1";
    }

    @RequestMapping(value = "/voteDetail", method = RequestMethod.GET)
    public String VoteDetail(Locale locale, HttpServletRequest request) {
        HttpSession session = request.getSession();

        String election = request.getParameter("election");

        List<CandidateVO> candiList = cDao.selectList(election);
        request.setAttribute("candiList", candiList);


        return "003_Vote1";
    }

    @RequestMapping(value = "/DoVote", method = RequestMethod.POST)
    public String DoVote(Locale locale, HttpServletRequest request) {
        HttpSession session = request.getSession();

        String election_name = request.getParameter("election");
        String vote_name = request.getParameter("vote");


        return "redirect:/votehome";
    }


}
