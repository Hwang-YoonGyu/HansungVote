package com.codingquokka.hansungenquete.domain;
public class CandidateVO {
	   
    private String candidate_name;
    private String election_name;
    private byte[] image;
   
    public String getCandidate_name() {
        return candidate_name;
    }
    public void setVote_name(String vote_name) {
        this.candidate_name = vote_name;
    }
    public String getElection_Name() {
        return election_name;
    }
    public void setElection_Name(String election_name) {
        this.election_name = election_name;
    }
    public byte[] getImage() {
        return image;
    }
    public void setImage(byte[] image) {
        this.image = image;
    }
}

