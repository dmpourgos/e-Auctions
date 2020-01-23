
package UserOp;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Lob;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;


@Entity
@Table(name = "IMAGES")
@XmlRootElement
//@NamedQueries({
//    @NamedQuery(name = "Images.findAll", query = "SELECT i FROM TED.Images i")})
public class Images implements Serializable {
    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected ImagesPK imagesPK;
    @Basic(optional = false)
    @NotNull
    @Lob
    @Column(name = "IMAGE")
    private Serializable image;
    @Size(max = 50)
    @Column(name = "CONTENT_TYPE")
    private String contentType;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "CONTENT_LENGTH")
    private Double contentLength;

    public Images() {
    }

    public Images(ImagesPK imagesPK) {
        this.imagesPK = imagesPK;
    }

    public Images(ImagesPK imagesPK, Serializable image) {
        this.imagesPK = imagesPK;
        this.image = image;
    }

    public Images(int itemId, int imageId) {
        this.imagesPK = new ImagesPK(itemId, imageId);
    }

    public ImagesPK getImagesPK() {
        return imagesPK;
    }

    public void setImagesPK(ImagesPK imagesPK) {
        this.imagesPK = imagesPK;
    }

    public Serializable getImage() {
        return image;
    }

    public void setImage(Serializable image) {
        this.image = image;
    }

    public String getContentType() {
        return contentType;
    }

    public void setContentType(String contentType) {
        this.contentType = contentType;
    }

    public Double getContentLength() {
        return contentLength;
    }

    public void setContentLength(Double contentLength) {
        this.contentLength = contentLength;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (imagesPK != null ? imagesPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Images)) {
            return false;
        }
        Images other = (Images) object;
        if ((this.imagesPK == null && other.imagesPK != null) || (this.imagesPK != null && !this.imagesPK.equals(other.imagesPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "user_op.Images[ imagesPK=" + imagesPK + " ]";
    }
    
}
