package com.codingquokka.hansungenquete.Controller;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.net.URL;
import java.time.LocalDate;
import java.time.LocalDateTime;
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
            if (formatedNow % 2 == 0) {
                if (!ServerLog.instance.SaveSwitch) {
                    Thread t = new Thread(new FileOut(ServerLog.instance.list));
                    t.start();
                    ServerLog.instance.SaveSwitch = true;
                }
            } else {
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
            try {

                File file = new File("C:\\\\Users\\\\NCL-NT-0162\\\\Desktop\\\\log.txt");
                if (!file.exists()) {
                    file.createNewFile();
                }
                FileWriter fw = null;
                fw = new FileWriter(file, true);

                BufferedWriter writer = new BufferedWriter(fw);
                for (String s: list) {
                    writer.write(s+"\n");
                }
                list.clear();
                writer.close();
            } catch (IOException e) {
                throw new RuntimeException(e);
            }

            System.out.println("Save Done");
        }
    }


    public FileOut(List<String> list) {
        this.list = list;
    }
}

