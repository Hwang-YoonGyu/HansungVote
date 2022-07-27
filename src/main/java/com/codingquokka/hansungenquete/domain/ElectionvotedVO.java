package com.codingquokka.hansungenquete.domain;

public class ElectionvotedVO {
	   
    private String stuId;
    private String name;
    private String department;
    private String voteName;
    private String electionName;
    
    public String getStuId() {
        return stuId;
    }
    public void setStuId(String stuId) {
        this.stuId = stuId;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getDepartment() {
        return department;
    }
    public void setDepartment(String department) {
        this.department = department;
    }
    public String getVoteName() {
        return voteName;
    }
    public void setVotename(String voteName) {
        this.voteName = voteName;
    }
    public String getElectionName() {
        return electionName;
    }
    public void setElectionName(String electionName) {
        this.electionName = electionName;
    }
}

