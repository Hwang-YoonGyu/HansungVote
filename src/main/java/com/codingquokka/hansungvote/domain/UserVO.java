package com.codingquokka.hansungvote.domain;
public class UserVO {

    private String stuId;
    private String name;
    private String phoneNumber;
    private String department;
    private String agree;
    private String delegate;

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

    public String getAgree(){
        return agree;
    }
    public void setAgree(String agree){
        this.agree = agree;
    }

    public String getDelegate() {return delegate;}
    public void setDelegate(String delegate){this.delegate = delegate;}
}