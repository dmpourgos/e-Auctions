package UserOp;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;


@Entity
@Table(name = "BIDS")
@XmlType( propOrder = { "bidsPK", "auctions", "users" ,"time" ,"amount"} )
@XmlRootElement 
//@NamedQueries({
//    @NamedQuery(name = "Bids.findAll", query = "SELECT b FROM TED.Bids b")})
public class Bids implements Serializable {
    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected BidsPK bidsPK;
    @Basic(optional = false)
    @NotNull
    @Column(name = "AMOUNT")
    private double amount;
    @JoinColumn(name = "ITEM_ID", referencedColumnName = "ITEM_ID", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Auctions auctions;
    @JoinColumn(name = "USERNAME", referencedColumnName = "USERNAME", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Users users;
    private Date time;

    public Bids() {
    }

    public Bids(BidsPK bidsPK) {
        this.bidsPK = bidsPK;
    }

    public Bids(BidsPK bidsPK, double amount) {
        this.bidsPK = bidsPK;
        this.amount = amount;
    }

    public Bids(String username, Date time, int itemId) {
        this.bidsPK = new BidsPK(username, time, itemId);
    }

    public BidsPK getBidsPK() {
        return bidsPK;
    }

    public void setBidsPK(BidsPK bidsPK) {
        this.bidsPK = bidsPK;
    }

    public double getAmount() {
        return amount;
    }

    @XmlElement ( name = "Amount" )
    public void setAmount(double amount) {
        this.amount = amount;
    }
    
    public Date getTime() {
        return time;
    }

    @XmlElement ( name = "Time" )
    public void setTime(Date time) {
        this.time = time;
    }

    public Auctions getAuctions() {
        return auctions;
    }

    public void setAuctions(Auctions auctions) {
        this.auctions = auctions;
    }

    public Users getUsers() {
        return users;
    }

    @XmlElement ( name = "Bidder" )
    public void setUsers(Users users) {
        this.users = users;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (bidsPK != null ? bidsPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Bids)) {
            return false;
        }
        Bids other = (Bids) object;
        if ((this.bidsPK == null && other.bidsPK != null) || (this.bidsPK != null && !this.bidsPK.equals(other.bidsPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "user_op.Bids[ bidsPK=" + bidsPK + " ]";
    }
    
}
