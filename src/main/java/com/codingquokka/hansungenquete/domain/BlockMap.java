package com.codingquokka.hansungenquete.domain;

import org.springframework.stereotype.Repository;

import java.util.HashMap;

@Repository
public class BlockMap {
    private HashMap<String, Integer> map;

    public BlockMap() {
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
}
