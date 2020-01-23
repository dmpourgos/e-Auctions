package UserOp;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.validation.constraints.NotNull;


@Embeddable
public class ImagesPK implements Serializable {
    @Basic(optional = false)
    @NotNull
    @Column(name = "ITEM_ID")
    private int itemId;
    @Basic(optional = false)
    @Column(name = "IMAGE_ID")
    private int imageId;

    public ImagesPK() {
    }

    public ImagesPK(int itemId, int imageId) {
        this.itemId = itemId;
        this.imageId = imageId;
    }

    public int getItemId() {
        return itemId;
    }

    public void setItemId(int itemId) {
        this.itemId = itemId;
    }

    public int getImageId() {
        return imageId;
    }

    public void setImageId(int imageId) {
        this.imageId = imageId;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (int) itemId;
        hash += (int) imageId;
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ImagesPK)) {
            return false;
        }
        ImagesPK other = (ImagesPK) object;
        if (this.itemId != other.itemId) {
            return false;
        }
        if (this.imageId != other.imageId) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "user_op.ImagesPK[ itemId=" + itemId + ", imageId=" + imageId + " ]";
    }
    
}
