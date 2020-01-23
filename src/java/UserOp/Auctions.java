package UserOp;

import java.io.Serializable;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;
import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementWrapper;
import javax.xml.bind.annotation.XmlType;


@Entity
@Table(name = "AUCTIONS")
@XmlType( propOrder={"name","cat","currently","buyPrice","firstBid","numberOfBids","bidsCollection" ,"location","loc","country","started","ends","seller","description"})
@XmlRootElement ( name = "Item" )
//@NamedQueries({
//    @NamedQuery(name = "Auctions.findAll", query = "SELECT a FROM TED.Auctions a")})
public class Auctions implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "ITEM_ID")
    private Integer itemId;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 100)
    @Column(name = "NAME")
    private String name;
    @Basic(optional = false)
    @NotNull
    @Column(name = "CURRENTLY")
    private double currently;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "BUY_PRICE")
    private Double buyPrice;
    @Basic(optional = false)
    @NotNull
    @Column(name = "FIRST_BID")
    private double firstBid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "NUMBER_OF_BIDS")
    private int numberOfBids;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "COUNTRY")
    private String country;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 100)
    @Column(name = "LOCATION")
    private String location;
    @Column(name = "LATITUDE")
    private Double latitude;
    @Column(name = "LONGITUDE")
    private Double longitude;
    @Basic(optional = false)
    @NotNull
    @Column(name = "STARTED")
    @Temporal(TemporalType.TIMESTAMP)
    private Date started;
    @Basic(optional = false)
    @NotNull
    @Column(name = "ENDS")
    @Temporal(TemporalType.TIMESTAMP)
    private Date ends;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 1000)
    @Column(name = "DESCRIPTION")
    private String description;
    @Basic(optional = false)
    @NotNull
    @Column(name = "SENT_MESSAGE")
    private int sentMessage;
    @ManyToMany(mappedBy = "auctionsCollection")
    private Collection<Categories> categoriesCollection;
    private List<String> cat; 
    private Location loc;
    private Users seller;
    
    @JoinColumn(name = "BUYER", referencedColumnName = "USERNAME")
    @ManyToOne
    private Users buyer;
    @JoinColumn(name = "USERNAME", referencedColumnName = "USERNAME")
    @ManyToOne(optional = false)
    private Users username;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "auctions")
    private Collection<Bids> bidsCollection;

    public Auctions() {
    }

    public Auctions(Integer itemId) {
        this.itemId = itemId;
    }

    public Auctions(Integer itemId, String name, double currently, double firstBid, int numberOfBids, String country, String location, Date started, Date ends, String description, int sentMessage) {
        this.itemId = itemId;
        this.name = name;
        this.currently = currently;
        this.firstBid = firstBid;
        this.numberOfBids = numberOfBids;
        this.country = country;
        this.location = location;
        this.started = started;
        this.ends = ends;
        this.description = description;
        this.sentMessage = sentMessage;
    }

    public Integer getItemId() {
        return itemId;
    }
    @XmlAttribute ( name = "ItemID" )
    public void setItemId(Integer itemId) {
        this.itemId = itemId;
    }

    public String getName() {
        return name;
    }
    @XmlElement ( name = "Name" )
    public void setName(String name) {
        this.name = name;
    }

    public double getCurrently() {
        return currently;
    }
    @XmlElement ( name = "Currently" )
    public void setCurrently(double currently) {
        this.currently = currently;
    }

    public Double getBuyPrice() {
        return buyPrice;
    }
    @XmlElement ( name = "Buy_Price" )
    public void setBuyPrice(Double buyPrice) {
        this.buyPrice = buyPrice;
    }
    
    public double getFirstBid() {
        return firstBid;
    }
    @XmlElement ( name = "First_Bid" )
    public void setFirstBid(double firstBid) {
        this.firstBid = firstBid;
    }

    public int getNumberOfBids() {
        return numberOfBids;
    }
    @XmlElement( name = "Number_of_Bids" )
    public void setNumberOfBids(int numberOfBids) {
        this.numberOfBids = numberOfBids;
    }

    public String getCountry() {
        return country;
    }
    @XmlElement ( name = "Country" )
    public void setCountry(String country) {
        this.country = country;
    }

     public Users getSeller() {
        return seller;
    }
    @XmlElement ( name = "Seller" )
    public void setSeller(Users seller) {
        this.seller = seller;
    }
    
    public String getLocation() {
        return location;
    }
    @XmlElement ( name = "Location" )
    public void setLocation(String location) {
        this.location = location;
    }

    public Double getLatitude() {
        return latitude;
    }
    @XmlTransient
    public void setLatitude(Double latitude) {
        this.latitude = latitude;
    }

    public Double getLongitude() {
        return longitude;
    }
    @XmlTransient
    public void setLongitude(Double longitude) {
        this.longitude = longitude;
    }

    public Date getStarted() {
        return started;
    }
    @XmlElement ( name = "Started" )
    public void setStarted(Date started) {
        this.started = started;
    }

    public Date getEnds() {
        return ends;
    }
    @XmlElement ( name = "Ends" )
    public void setEnds(Date ends) {
        this.ends = ends;
    }

    public String getDescription() {
        return description;
    }
    @XmlElement ( name = "Description" )
    public void setDescription(String description) {
        this.description = description;
    }

    public int getSentMessage() {
        return sentMessage;
    }

    @XmlTransient
    public void setSentMessage(int sentMessage) {
        this.sentMessage = sentMessage;
    }

    public Location getLoc() {
        return loc;
    }

    @XmlElement (name="Location")
    public void setLoc(Location loc) {
        this.loc = loc;
    }
   
    public Collection<Categories> getCategoriesCollection() {
        return categoriesCollection;
    }
    @XmlTransient
    public void setCategoriesCollection(Collection<Categories> categoriesCollection) {
        this.categoriesCollection = categoriesCollection;
    }
    
    public List<String> getCat() {
        return cat;
    }
    
    @XmlElement (name="Category")
    public void setCat(List<String> categoriesCollection) {
        this.cat = categoriesCollection;
    }
    

    public Users getBuyer() {
        return buyer;
    }
    @XmlTransient
    public void setBuyer(Users buyer) {
        this.buyer = buyer;
    }

    public Users getUsername() {
        return username;
    }
    @XmlTransient 
    public void setUsername(Users username) {
        this.username = username;
    }

  
    public Collection<Bids> getBidsCollection() {
        return bidsCollection;
    }

    @XmlElementWrapper (name = "Bids")
    @XmlElement (name="Bid")
    public void setBidsCollection(Collection<Bids> bidsCollection) {
        this.bidsCollection = bidsCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (itemId != null ? itemId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Auctions)) {
            return false;
        }
        Auctions other = (Auctions) object;
        if ((this.itemId == null && other.itemId != null) || (this.itemId != null && !this.itemId.equals(other.itemId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "user_op.Auctions[ itemId=" + itemId + " ]";
    }
    
}
