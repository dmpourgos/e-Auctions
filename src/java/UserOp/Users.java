package UserOp;

import Database.DbConnection;
import java.io.Serializable;
import java.sql.ResultSet;
import java.util.Collection;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityManager;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Query;
import javax.persistence.Table;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Validation;
import javax.validation.ValidatorFactory;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.Validator;
import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;
import javax.xml.bind.annotation.XmlType;

@Entity
@Table(name = "TED.USERS")
@XmlType( propOrder = { "location", "country" ,"password" ,"name" ,"surname" ,"email" ,"phone" ,"city" ,"address"  ,"afm"} )
@XmlRootElement
//@NamedQueries({
//    @NamedQuery(name = "Users.findAll", query = "SELECT u FROM Users u"),
//    @NamedQuery(name = "Users.findByUsername", query = "SELECT u FROM Users u WHERE u.username = :username"),
//    @NamedQuery(name = "Users.findByPassword", query = "SELECT u FROM Users u WHERE u.password = :password"),
//    @NamedQuery(name = "Users.findByName", query = "SELECT u FROM Users u WHERE u.name = :name"),
//    @NamedQuery(name = "Users.findBySurname", query = "SELECT u FROM Users u WHERE u.surname = :surname"),
//    @NamedQuery(name = "Users.findByEmail", query = "SELECT u FROM Users u WHERE u.email = :email"),
//    @NamedQuery(name = "Users.findByPhone", query = "SELECT u FROM Users u WHERE u.phone = :phone"),
//    @NamedQuery(name = "Users.findByCity", query = "SELECT u FROM Users u WHERE u.city = :city"),
//    @NamedQuery(name = "Users.findByAddress", query = "SELECT u FROM Users u WHERE u.address = :address"),
//    @NamedQuery(name = "Users.findByNumber", query = "SELECT u FROM Users u WHERE u.number = :number"),
//    @NamedQuery(name = "Users.findByTk", query = "SELECT u FROM Users u WHERE u.tk = :tk"),
//    @NamedQuery(name = "Users.findByInfos", query = "SELECT u FROM Users u WHERE u.infos = :infos"),
//    @NamedQuery(name = "Users.findByAccepted", query = "SELECT u FROM Users u WHERE u.accepted = :accepted"),
//    @NamedQuery(name = "Users.findByAfm", query = "SELECT u FROM Users u WHERE u.afm = :afm"),
//    @NamedQuery(name = "Users.findByRole", query = "SELECT u FROM Users u WHERE u.role = :role"),
//    })
public class Users implements Serializable {
    @Basic(optional = false)
    @NotNull
    @Column(name = "ROLE")
    private int role;
    @Basic(optional = false)
    @NotNull
    @Column(name = "S_RATING")
    private int sRating;
    @Basic(optional = false)
    @NotNull
    @Column(name = "B_RATING")
    private int bRating;
    @Size(max = 100)
    @Column(name = "LOCATION")
    private String location;
//    @OneToMany(cascade = CascadeType.ALL, mappedBy = "username")
//    private Collection<Auctions> auctionsCollection;
//    @OneToMany(cascade = CascadeType.ALL, mappedBy = "users")
//    private Collection<Bids> bidsCollection;
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 30)
    @Column(name = "USERNAME")
    private String username;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 30)
    @Column(name = "PASSWORD")
    private String password;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 30)
    @Column(name = "NAME")
    private String name;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 30)
    @Column(name = "SURNAME")
    private String surname;
    // @Pattern(regexp="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?", message="Invalid email")//if the field contains email address consider using this annotation to enforce field validation
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 60)
    @Column(name = "EMAIL")
    private String email;
    // @Pattern(regexp="^\\(?(\\d{3})\\)?[- ]?(\\d{3})[- ]?(\\d{4})$", message="Invalid phone/fax format, should be as xxx-xxx-xxxx")//if the field contains phone or fax number consider using this annotation to enforce field validation
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 15)
    @Column(name = "PHONE")
    private String phone;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 30)
    @Column(name = "CITY")
    private String city;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 30)
    @Column(name = "ADDRESS")
    private String address;
    @Basic(optional = false)
    @NotNull
    @Column(name = "NUMBER")
    private int number;
    @Basic(optional = false)
    @NotNull
    @Column(name = "TK")
    private int tk;
    @Basic(optional = false)
    @NotNull
    @Column(name = "INFOS")
    private int infos;
    @Basic(optional = false)
    @NotNull
    @Column(name = "ACCEPTED")
    private int accepted;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 30)
    @Column(name = "AFM")
    private String afm;
    @Size(max = 30)
    @Column(name = "COUNTRY")
    private String country;

    public Users() {
    }

    public Users(String username) {
        this.username = username;
    }

    public Users(String username, String password, String name, String surname, String email, String phone, String city, String address, int number, int tk, int infos, int accepted, String afm, String country,int role,String location,int sRating,int bRating) {
        this.username = username;
        this.password = password;
        this.name = name;
        this.surname = surname;
        this.email = email;
        this.phone = phone;
        this.city = city;
        this.address = address;
        this.number = number;
        this.tk = tk;
        this.infos = infos;
        this.accepted = accepted;
        this.afm = afm;
        this.country=country;
        this.role=role;
        this.location=location;
        this.sRating=sRating;
        this.bRating=bRating;
    }

    public String getUsername() {
        return username;
    }

    @XmlAttribute ( name = "UserID" )
    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    @XmlTransient
    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }

    @XmlTransient
    public int getTk() {
        return tk;
    }

    public void setTk(int tk) {
        this.tk = tk;
    }

    @XmlTransient
    public int getInfos() {
        return infos;
    }

    public void setInfos(int infos) {
        this.infos = infos;
    }

    @XmlTransient
    public int getAccepted() {
        return accepted;
    }

    public void setAccepted(int accepted) {
        this.accepted = accepted;
    }

    public String getAfm() {
        return afm;
    }

    public void setAfm(String afm) {
        this.afm = afm;
    }


    public String getCountry() {
        return country;
    }

    @XmlElement ( name = "Country" )
    public void setCountry(String country) {
        this.country = country;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (username != null ? username.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Users)) {
            return false;
        }
        Users other = (Users) object;
        if ((this.username == null && other.username != null) || (this.username != null && !this.username.equals(other.username))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "user_op.Users[ username=" + username + " ]";
    }

    @XmlTransient
    public int getRole() {
        return role;
    }

    public void setRole(int role) {
        this.role = role;
    }

    public int getSRating() {
        return sRating;
    }

    @XmlTransient
    public void setSRating(int sRating) {
        this.sRating = sRating;
    }

    public int getBRating() {
        return bRating;
    }

    @XmlAttribute ( name = "Rating" )
    public void setBRating(int bRating) {
        this.bRating = bRating;
    }

    public String getLocation() {
        return location;
    }

    @XmlElement ( name = "Location" )
    public void setLocation(String location) {
        this.location = location;
    }

//    @XmlTransient
//    public Collection<Auctions> getAuctionsCollection() {
//        return auctionsCollection;
//    }
//
//    public void setAuctionsCollection(Collection<Auctions> auctionsCollection) {
//        this.auctionsCollection = auctionsCollection;
//    }
//
//    @XmlTransient
//    public Collection<Bids> getBidsCollection() {
//        return bidsCollection;
//    }
//
//    public void setBidsCollection(Collection<Bids> bidsCollection) {
//        this.bidsCollection = bidsCollection;
//    }
    
    public UserHelper validate(EntityManager entitymanager, HttpServletRequest request){
        
            
            HttpSession signup_session = request.getSession(true);
            boolean isValidated = true;
  //          Query query = entitymanager.createQuery( "Select u " + "from Users u " + "where u.username= " + "'"+this.username+"'"  );
            Query query = entitymanager.createNamedQuery("Users.findByUsername");
            query.setParameter("username", this.username);
        
            List<Users> listWithSameUsername=(List<Users>)query.getResultList( ); 
            
            if (listWithSameUsername.isEmpty()) {
                signup_session.setAttribute("username_span", this.username+" is avaliable");
                signup_session.setAttribute("color", "color:green");
            }  
            else{  
                signup_session.setAttribute("username_span","** "+this.username+" is not avaliable");
                signup_session.setAttribute("color", "color:red");
                isValidated = false;
            }
            
            if(this.password.length()<6){
                signup_session.setAttribute("password_span","** Password is weak , more than 5 chars");
                signup_session.setAttribute("password1", "");
                isValidated = false;
            }else{
                 signup_session.setAttribute("password_span","");
                 signup_session.setAttribute("password1", this.password);
            }
            
            UserHelper usrHelper = new UserHelper(signup_session, isValidated);
            return usrHelper;
    }
}
