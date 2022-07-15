package domain;
public class VoteVO {
	   
    private String vote_name;
    private String election_name;
    private Byte[] image;
    private Integer vote_count;
   
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
    public Byte[] getImage() {
        return image;
    }
    public void setImage(Byte[] image) {
        this.image = image;
    }
    public Integer getVote_Count() {
    	return vote_count;
    }
    public void setVote_Count(Integer vote_count){
    	this.vote_count = vote_count;
    }
}

