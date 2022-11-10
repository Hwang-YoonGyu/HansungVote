package com.codingquokka.hansungvote.domain;
public class UserVO {

    private String stuId;
    private String name;
    private String phoneNumber;
    private String department;
    private int agree;
    private int delegate;

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
    public void setAgree(int agree){
        this.agree = agree;
    }

    public int getDelegate() {return delegate;}
    public void setDelegate(int delegate){this.delegate = delegate;}
}