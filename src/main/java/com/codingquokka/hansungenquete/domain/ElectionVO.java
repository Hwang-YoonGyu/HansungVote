package com.codingquokka.hansungenquete.domain;

import java.util.Date;

public class ElectionVO {
	   
    private String election_name;
    private Date start_date;
    private Date end_date;
    private String explain;
    private String department;
    private Integer maxnum;
   
    public String getElection_Name() {
        return election_name;
    }
    public void setElection_Name(String election_name) {
        this.election_name = election_name;
    }
    public Date getStart_Date() {
        return start_date;
    }
    public void setStart_Date(Date start_date) {
        this.start_date = start_date;
    }
    public Date getEnd_Date() {
        return end_date;
    }
    public void setEnd_Date(Date end_date) {
        this.end_date = end_date;
    }
    public String getExplain() {
    	return explain;
    }
    public void setExplain(String explain) {
    	this.explain = explain;
    }
    public String getDepartment() {
    	return department;
    }
    public void setDepartment(String department) {
    	this.department = department;
    }
    public Integer getMaxnum() {
    	return maxnum;
    }
    public void setMaxnum(Integer maxnum) {
    	this.maxnum = maxnum;
    }
}

