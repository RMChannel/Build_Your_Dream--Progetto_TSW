package Model;

import Database.DB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class NewsletterDAO {
    public List<String> getAllEmails() {
        List<String> emails = new ArrayList<String>();
        try {
            Connection conn= DB.getConn();
            PreparedStatement ps=conn.prepareStatement("select * from Build_Your_Dream.EMAIL_NEWSLETTER");
            ResultSet rs=ps.executeQuery();
            while(rs.next()){
                emails.add(rs.getString(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return emails;
    }
}
