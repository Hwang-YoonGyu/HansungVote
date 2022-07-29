package com.codingquokka.hansungenquete.Controller;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class ServerLog {

    public boolean SaveSwitch = false;
    public static ServerLog instance = new ServerLog();

    public List<String> list = new ArrayList<String>();

    public ServerLog() {
        System.out.println("Manager Thread has started");
        Thread t = new Thread(new ManagerFile());
        t.start();
    }

    public void WriteLog(String timeStamp, String content) {
        list.add(timeStamp + " : " + content);
    }

}

class ManagerFile implements Runnable {

    @Override
    public void run() {
        System.out.println("Automatic log saving thread has started");

        while (true) {
            LocalTime now = LocalTime.now();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("mm");
            int formatedNow = Integer.parseInt(now.format(formatter));
            if (formatedNow % 5 == 0 ) {
                if (!ServerLog.instance.SaveSwitch) {
                    Thread t = new Thread(new FileOut(ServerLog.instance.list));
                    t.start();
                    ServerLog.instance.SaveSwitch = true;
                }
            }
            else {
                ServerLog.instance.SaveSwitch = false;

            }
        }
    }
}


class FileOut implements Runnable {
    private List<String> list;

    @Override
    public void run() {
        synchronized (list) {
            System.out.println("Auto Save doing");

            System.out.println("Save Done");
        }
    }


    public FileOut(List<String> list) {
        this.list = list;
    }
}

