package UserOp;

import java.io.Serializable;
import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlValue;



public class Location implements Serializable{
    
    private double latitude; 
    private double longitude;
    private String location;


    public Location()
    {
    }

    public String getLocation() {
        return location;
    }

    @XmlValue
    public void setLocation(String location) {
        this.location = location;
    }
  
    public double getLongitude() {
        return longitude;
    }

    @XmlAttribute ( name = "Longitude" )
    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }
    
    public double getLatitude() {
        return longitude;
    }

    @XmlAttribute ( name = "Latitude" )
    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }
  
}
