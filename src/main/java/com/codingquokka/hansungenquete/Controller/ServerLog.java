/*package com.codingquokka.hansungenquete.Controller;

import java.util.ArrayList;
import java.util.List;

public class ServerLog {

    public static ServerLog instance = new ServerLog();

    private List<String> list = new ArrayList<String>();

    public ServerLog() {

    }

    public void WriteLog(String timeStamp, String content) {
        list.add(timeStamp+" : "+content);
    }

}
class FileOut implements Runnable {
    private List<String> list;

    @Override
    public void run() {
        System.out.println("Automatic log saving thread has started");
        while (true) {
            try {
                System.out.println("Auto Save doing");
                list.wait();



            } catch (InterruptedException e) {
                throw new RuntimeException(e);
            }
            list.notify();

        }
    }
    public FileOut(List<String> list) {
        this.list = list;
    }
}*/

