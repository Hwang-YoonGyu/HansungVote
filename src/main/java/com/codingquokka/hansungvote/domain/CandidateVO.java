package com.codingquokka.hansungvote.domain;
public class CandidateVO {
	   
    private String candidateName;
    private String electionName;
    private byte[] image;
   
    public String getCandidateName() {return candidateName;}
    public void setCandidateName(String candidateName) {this.candidateName = candidateName;}
    public String getElectionName() {
        return electionName;
    }
    public void setElectionName(String electionName) {
        this.electionName = electionName;
    }
    public byte[] getImage() {
        return image;
    }
    public void setImage(byte[] image) {
        this.image = image;
    }
}

