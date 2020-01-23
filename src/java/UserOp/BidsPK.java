
package UserOp;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlElement;


@Embeddable
public class BidsPK implements Serializable {
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 30)
    @Column(name = "USERNAME")
    private String username;
    @Basic(optional = false)
    @NotNull
    @Column(name = "TIME")
    @Temporal(TemporalType.TIMESTAMP)
    private Date time;
    @Basic(optional = false)
    @NotNull
    @Column(name = "ITEM_ID")
    private int itemId;

    public BidsPK() {
    }

    public BidsPK(String username, Date time, int itemId) {
        this.username = username;
        this.time = time;
        this.itemId = itemId;
    }

    public String getUsername() {
        return username;
    }

    @XmlElement ( name = "Bidder" )
    public void setUsername(String username) {
        this.username = username;
    }

    public Date getTime() {
        return time;
    }

    @XmlElement ( name = "Time" )
    public void setTime(Date time) {
        this.time = time;
    }

    public int getItemId() {
        return itemId;
    }

    public void setItemId(int itemId) {
        this.itemId = itemId;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (username != null ? username.hashCode() : 0);
        hash += (time != null ? time.hashCode() : 0);
        hash += (int) itemId;
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof BidsPK)) {
            return false;
        }
        BidsPK other = (BidsPK) object;
        if ((this.username == null && other.username != null) || (this.username != null && !this.username.equals(other.username))) {
            return false;
        }
        if ((this.time == null && other.time != null) || (this.time != null && !this.time.equals(other.time))) {
            return false;
        }
        if (this.itemId != other.itemId) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "user_op.BidsPK[ username=" + username + ", time=" + time + ", itemId=" + itemId + " ]";
    }
    
}
