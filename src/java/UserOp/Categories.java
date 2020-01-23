
package UserOp;

import java.io.Serializable;
import java.util.Collection;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;


@Entity
@Table(name = "CATEGORIES")
@XmlRootElement(name="CATEGORY")
//@NamedQueries({
//    @NamedQuery(name = "Categories.findAll", query = "SELECT c FROM TED.Categories c")})
public class Categories implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 150)
    @Column(name = "CATEGORY")
    private String category;
    @JoinTable(name = "ITEM_TO_CATEGORY", joinColumns = {
        @JoinColumn(name = "CATEGORY", referencedColumnName = "CATEGORY")}, inverseJoinColumns = {
        @JoinColumn(name = "ITEM_ID", referencedColumnName = "ITEM_ID")})
    @ManyToMany
    private Collection<Auctions> auctionsCollection;

    public Categories() {
    }

    public Categories(String category) {
        this.category = category;
    }

    public String getCategory() {
        return category;
    }

    @XmlElement
    public void setCategory(String category) {
        this.category = category;
    }

    @XmlTransient
    public Collection<Auctions> getAuctionsCollection() {
        return auctionsCollection;
    }

    public void setAuctionsCollection(Collection<Auctions> auctionsCollection) {
        this.auctionsCollection = auctionsCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (category != null ? category.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Categories)) {
            return false;
        }
        Categories other = (Categories) object;
        if ((this.category == null && other.category != null) || (this.category != null && !this.category.equals(other.category))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "user_op.Categories[ category=" + category + " ]";
    }
    
}
