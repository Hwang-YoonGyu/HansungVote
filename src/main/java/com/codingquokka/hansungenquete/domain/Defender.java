package com.codingquokka.hansungenquete.domain;

import org.springframework.stereotype.Repository;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;

@Repository
public class Defender {
    private HashMap<String, Integer> map;

    public Defender() {
        map = new HashMap<>();
    }

    public boolean isBlock(String ip) {
        if(map.get(ip) != null) {
            return true;
        }
        else {
            return false;
        }
    }

    public void add(String ip) {
        map.put(ip, 1);
    }

    public boolean checkLastTime(HttpServletRequest request) {
        HttpSession session = request.getSession();

        if(isBlock(request.getRemoteAddr())) {
            return true;
        }

        Date now = new Date();
        Date lastConnect = (Date) session.getAttribute("date");
        session.removeAttribute("date");
        session.setAttribute("date", now);

        if (now.getTime() - lastConnect.getTime() < 500) {
            add(request.getRemoteAddr());
            return true;
        }
        else {
            return false;
        }

    }
}
