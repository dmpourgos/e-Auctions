package UserOp;

import javax.servlet.http.HttpSession;

public class UserHelper {

    private HttpSession session;
    private boolean isValidate;

    public UserHelper(HttpSession session, boolean isValidate) {
        this.session = session;
        this.isValidate = isValidate;
    }

    public HttpSession getSession() {
        return session;
    }

    public boolean isIsValidate() {
        return isValidate;
    }

    public void setSession(HttpSession session) {
        this.session = session;
    }

    public void setIsValidate(boolean isValidate) {
        this.isValidate = isValidate;
    }
    
    
}
