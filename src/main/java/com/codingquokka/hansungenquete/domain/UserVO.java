package com.codingquokka.hansungenquete.domain;
public class UserVO {

    private String stuId;
    private String name;
    private String password;
    private String phoneNumber;
    private String department;

    private int agree;
    private int Y;
    private int D;






    public String getStuid() {
        return stuId;
    }
    public void setStuid(String stuId) {
        this.stuId = stuId;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    public String getPhoneNumber() {
        return phoneNumber;
    }
    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }
    public String getDepartment() {
        return department;
    }
    public void setDepartment(String department) {
        this.department = department;
    }

    public int getAgree(){
        return agree;
    }
    public void setAgree(){
        this.agree = agree;
    }

    public int getY() {return Y;}
    public int getD() {return D;}
    public void setY(){
        this.Y = Y;
    }
    public void setD(){
        this.D = D;
    }



}