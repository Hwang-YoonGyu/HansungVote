package domain;

public class ElectionvotedVO {
	   
    private String stu_id;
    private String name;
    private String department;
    private String vote_name;
    private String election_name;
    
    public String getStu_Id() {
        return stu_id;
    }
    public void setStu_Id(String stu_id) {
        this.stu_id = stu_id;
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
    public String getVote_Name() {
        return vote_name;
    }
    public void setVote_name(String vote_name) {
        this.vote_name = vote_name;
    }
    public String getElection_Name() {
        return election_name;
    }
    public void setElection_Name(String election_name) {
        this.election_name = election_name;
    }
}

