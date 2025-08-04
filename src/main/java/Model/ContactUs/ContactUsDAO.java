package Model.ContactUs;

import Database.DB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ContactUsDAO {
    public void addModule(String name, String email, String Message) {
        try {
            Connection conn= DB.getConn();
            PreparedStatement ps=conn.prepareStatement("INSERT INTO Build_Your_Dream.CONTACTUS VALUES (?,?,?,?)");
            ps.setNull(1,java.sql.Types.INTEGER);
            ps.setString(2,name);
            ps.setString(3,email);
            ps.setString(4,Message);
            ps.executeUpdate();
            ps.close();
            conn.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<ContactUs> getAllModules() {
        List<ContactUs> list=new ArrayList<>();
        try {
            Connection conn= DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT * FROM Build_Your_Dream.CONTACTUS");
            ResultSet rs=ps.executeQuery();
            while(rs.next()) {
                list.add(new ContactUs(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getString(4)));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return list;
    }

    public void removeModule(int id) {
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("DELETE FROM Build_Your_Dream.CONTACTUS WHERE ID=?");
            ps.setInt(1,id);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
