package UserOp;


public class UserDto {
    private Users user;
    private int flag;
    
    public UserDto() {
        user=null;
        flag=-1;
    }

    public Users getUser() {
        return user;
    }

    public void setUser(Users user) {
        this.user = user;
    }

    public int getFlag() {
        return flag;
    }

    public void setFlag(int flag) {
        this.flag = flag;
    }
    
    
}
