package models;
 
import java.util.*;
import javax.persistence.*;
 
import play.db.jpa.*;
 
@Entity
//@Table(name="table_name")
public class Blog extends Model {
    public String title;
    public String body;
    public Integer status;
    public Date created_at;
    public Date updated_at;
    public Date deleted_at;
}
