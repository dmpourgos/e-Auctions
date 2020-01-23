package UserOp;

import java.util.ArrayList;
import java.util.List;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement( name = "Items" )
public class AllAuctions
{
    List<Auctions> auctions;

    public List<Auctions> getAuctions()
    {
        return auctions;
    }

    
    @XmlElement( name = "Item" )
    public void setAuctions( List<Auctions> auctions )
    {
        this.auctions = auctions;
    }

  
    public void add( Auctions auction )
    {
        if( this.auctions == null )
        {
            this.auctions = new ArrayList<Auctions>();
        }
        this.auctions.add( auction );

    }

}
