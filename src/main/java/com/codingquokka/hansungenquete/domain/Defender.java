package com.codingquokka.hansungenquete.domain;

import org.springframework.stereotype.Repository;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;

@Repository
public class Defender {
    private HashMap<String, Integer> map; // IP주소, 1 : List? HashMap?

    public Defender() {
        map = new HashMap<>();
        //파일입출력해서 차단당한 ip리스트 삽입
        //자바로 하는거임 이건
        //
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
