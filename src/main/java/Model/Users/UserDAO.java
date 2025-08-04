package Model.Users;

import Database.DB;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    public User getUser(String username) {
        try {
            Connection conn= DB.getConn();
            PreparedStatement ps=conn.prepareStatement("select * from Build_Your_Dream.USERS where USERNAME=?");
            ps.setString(1,username);
            ResultSet rs=ps.executeQuery();
            if(rs.next()){
                return new User(rs.getString(1),rs.getString(2),rs.getString(3),rs.getString(4),rs.getString(5),rs.getString(6),rs.getDate(7),rs.getBoolean(8),true);
            }
            else return null;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void registerUser(User user) throws UsernameAlreadyRegistred, EmailAlreadyRegistred {
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("select * from Build_Your_Dream.USERS where USERNAME=?");
            ps.setString(1,user.getUsername());
            ResultSet rs=ps.executeQuery();
            if(rs.next()) {
                throw new UsernameAlreadyRegistred();
            }
            ps=conn.prepareStatement("Select * from Build_Your_Dream.USERS where EMAIL=?");
            ps.setString(1,user.getEmail());
            rs=ps.executeQuery();
            if(rs.next()) {
                throw new EmailAlreadyRegistred();
            }
            ps=conn.prepareStatement("INSERT INTO Build_Your_Dream.USERS VALUES(?,?,?,?,?,?,?,?)");
            ps.setString(1,user.getUsername());
            ps.setString(2,user.getPassword());
            ps.setString(3,user.getNome());
            ps.setString(4,user.getCognome());
            ps.setString(5,user.getEmail());
            ps.setString(6,user.getnTelefono());
            ps.setDate(7,user.getDataDiNascita());
            ps.setBoolean(8,user.isAdmin());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public User loginUser(String username, String password) throws PasswordNotCorrect, UserNotFound {
        User user = getUser(username);
        if(user==null) throw new UserNotFound();
        if(!user.getPassword().equals(user.calculateHashPassword(password))) {
            throw new PasswordNotCorrect();
        }
        return user;
    }
    //versione utente
    public void changePassword(String oldPassword, String newPassword, User user) throws PasswordNotCorrect, PasswordNotLongEnough {
        if(!user.getPassword().equals(user.calculateHashPassword(oldPassword))) {
            throw new PasswordNotCorrect();
        }
        user.setPassword(newPassword);
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("UPDATE Build_Your_Dream.USERS SET HASH_PASSWORD=? WHERE USERNAME=?");
            ps.setString(1,user.getPassword());
            ps.setString(2,user.getUsername());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    //versione admin
    public void changePassword(String username, String newPassword) throws PasswordNotLongEnough {
        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUser(username);
        user.setPassword(newPassword);
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps= conn.prepareStatement("UPDATE Build_Your_Dream.USERS SET HASH_PASSWORD=? WHERE USERNAME=?");
            ps.setString(1,user.getPassword());
            ps.setString(2,user.getUsername());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void updateUser(User user, String nome, String cognome, String nTelefono, String email, Date dateOfBirth) {
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("UPDATE Build_Your_Dream.USERS SET NOME=?, COGNOME=?, NUMERO_DI_TELEFONO=?, EMAIL=?, DATA_DI_NASCITA=? WHERE USERNAME=?");
            ps.setString(1,nome);
            ps.setString(2,cognome);
            ps.setString(3,nTelefono);
            ps.setString(4,email);
            ps.setDate(5,dateOfBirth);
            ps.setString(6,user.getUsername());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void updateUser(User user, String nome, String cognome, String nTelefono, String email, Date dateOfBirth, boolean admin) {
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("UPDATE Build_Your_Dream.USERS SET NOME=?, COGNOME=?, NUMERO_DI_TELEFONO=?, EMAIL=?, DATA_DI_NASCITA=?, ISADMIN=? WHERE USERNAME=?");
            ps.setString(1,nome);
            ps.setString(2,cognome);
            ps.setString(3,nTelefono);
            ps.setString(4,email);
            ps.setDate(5,dateOfBirth);
            ps.setBoolean(6,admin);
            ps.setString(7,user.getUsername());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void updateUsername(String username, String newUsername) {
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("UPDATE Build_Your_Dream.USERS SET USERNAME=? WHERE USERNAME=?");
            ps.setString(1,newUsername);
            ps.setString(2,username);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void removeUser(String username) {
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("DELETE FROM Build_Your_Dream.CARRELLO WHERE USER_ID=?");
            ps.setString(1,username);
            ps.executeUpdate();
            ps=conn.prepareStatement("DELETE FROM Build_Your_Dream.BUILDER WHERE USER_ID=?");
            ps.setString(1,username);
            ps.executeUpdate();
            ps=conn.prepareStatement("SELECT ID_BUILD FROM Build_Your_Dream.CREARE where ID_USER=?");
            ps.setString(1,username);
            ResultSet rs=ps.executeQuery();
            List<Integer> ids=new ArrayList<>();
            while(rs.next()) {
                ids.add(rs.getInt(1));
            }
            ps=conn.prepareStatement("DELETE FROM Build_Your_Dream.CREARE WHERE ID_USER=?");
            ps.setString(1,username);
            ps.executeUpdate();
            for(Integer id:ids) {
                ps=conn.prepareStatement("DELETE FROM Build_Your_Dream.BUILDS WHERE ID_BUILD=?");
                ps.setInt(1,id);
                ps.executeUpdate();
            }
            ps=conn.prepareStatement("DELETE FROM Build_Your_Dream.CARTE WHERE USERNAME=?");
            ps.setString(1,username);
            ps.executeUpdate();
            ps=conn.prepareStatement("DELETE FROM Build_Your_Dream.ORDERS WHERE ID_USER=?");
            ps.setString(1,username);
            ps.executeUpdate();
            ps=conn.prepareStatement("DELETE FROM Build_Your_Dream.USERS WHERE USERNAME=?");
            ps.setString(1,username);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<User> getAllUsers() {
        List<User> users = new ArrayList<User>();
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT * FROM Build_Your_Dream.USERS");
            ResultSet rs=ps.executeQuery();
            while(rs.next()) {
                users.add(new User(rs.getString(1),rs.getString(2),rs.getString(3),rs.getString(4),rs.getString(5),rs.getString(6),rs.getDate(7),rs.getBoolean(8)));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return users;
    }
}
