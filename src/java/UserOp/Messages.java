
package UserOp;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

@Entity
@Table(name = "MESSAGES")
@XmlRootElement
//@NamedQueries({
//    @NamedQuery(name = "Messages.findAll", query = "SELECT m FROM TED.Messages m")})
public class Messages implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "MESSAGE_ID")
    private Integer messageId;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 60)
    @Column(name = "THEME")
    private String theme;
    @Basic(optional = false)
    @NotNull
    @Column(name = "IS_READ")
    private int isRead;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 1000)
    @Column(name = "CONTENT")
    private String content;
    @Column(name = "TIME")
    @Temporal(TemporalType.TIMESTAMP)
    private Date time;
    @Column(name = "TYPE")
    private Integer type;
    @Basic(optional = false)
    @NotNull
    @Column(name = "DELETED_SENDER")
    private int deletedSender;
    @Basic(optional = false)
    @NotNull
    @Column(name = "DELETED_RECEIVER")
    private int deletedReceiver;
    @JoinColumn(name = "RECEIVER", referencedColumnName = "USERNAME")
    @ManyToOne(optional = false)
    private Users receiver;
    @JoinColumn(name = "SENDER", referencedColumnName = "USERNAME")
    @ManyToOne(optional = false)
    private Users sender;

    public Messages() {
    }

    public Messages(Integer messageId) {
        this.messageId = messageId;
    }

    public Messages(Integer messageId, String theme, int isRead, String content, int deletedSender, int deletedReceiver) {
        this.messageId = messageId;
        this.theme = theme;
        this.isRead = isRead;
        this.content = content;
        this.deletedSender = deletedSender;
        this.deletedReceiver = deletedReceiver;
    }

    public Integer getMessageId() {
        return messageId;
    }

    public void setMessageId(Integer messageId) {
        this.messageId = messageId;
    }

    public String getTheme() {
        return theme;
    }

    public void setTheme(String theme) {
        this.theme = theme;
    }

    public int getIsRead() {
        return isRead;
    }

    public void setIsRead(int isRead) {
        this.isRead = isRead;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public int getDeletedSender() {
        return deletedSender;
    }

    public void setDeletedSender(int deletedSender) {
        this.deletedSender = deletedSender;
    }

    public int getDeletedReceiver() {
        return deletedReceiver;
    }

    public void setDeletedReceiver(int deletedReceiver) {
        this.deletedReceiver = deletedReceiver;
    }

    public Users getReceiver() {
        return receiver;
    }

    public void setReceiver(Users receiver) {
        this.receiver = receiver;
    }

    public Users getSender() {
        return sender;
    }

    public void setSender(Users sender) {
        this.sender = sender;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (messageId != null ? messageId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Messages)) {
            return false;
        }
        Messages other = (Messages) object;
        if ((this.messageId == null && other.messageId != null) || (this.messageId != null && !this.messageId.equals(other.messageId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "user_op.Messages[ messageId=" + messageId + " ]";
    }
    
}
