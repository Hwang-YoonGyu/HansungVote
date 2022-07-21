package com.codingquokka.hansungenquete.domain;
public class UserVO {
	   
    private String stu_id;
    private String name;
    private String password;
    private String phone_number;
    private String department;


 
   
    public String getStu_id() {
        return stu_id;
    }
    public void setStu_id(String stu_id) {
        this.stu_id = stu_id;
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
    public void setPassword(String phone_number) {
        this.phone_number = phone_number;
    }
    public String getPhone_number() {
        return phone_number;
    }
    public void setPhone_number(String phone_number) {
        this.phone_number = phone_number;
    }
    public String getDepartment() {
        return department;
    }
    public void setDepartment(String department) {
        this.department = department;
    }
    

}