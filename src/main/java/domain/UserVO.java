package domain;

public class UserVO {
	   
    private String stu_id;
    private String name;
    private String password;
    private String phone_number;
    private String department;
    private Boolean is_voted;
   
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
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    public String getPhone_Number() {
        return phone_number;
    }
    public void setPhone_Number(String phone_number) {
        this.phone_number = phone_number;
    }
    public String getDepartment() {
        return department;
    }
    public void setDepartment(String department) {
        this.department = department;
    }
    public Boolean getIs_Voted() {
        return is_voted;
    }
    public void setIs_Voted(Boolean is_voted) {
        this.is_voted = is_voted;
    }
}

