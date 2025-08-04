package Model.Builds;

import Database.DB;
import Model.Carrello.Carrello;
import Model.Users.User;

import java.io.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BuilderDAO {
    public byte[] serializzaBuild(Object build) throws Exception {
        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        ObjectOutputStream oos = new ObjectOutputStream(bos);
        oos.writeObject(build);
        oos.flush();
        return bos.toByteArray();
    }

    public void saveBuild(Build build, User user) {
        try {
            Connection conn= DB.getConn();
            if(loadBuild(user)==null) {
                PreparedStatement ps=conn.prepareStatement("insert into Build_Your_Dream.BUILDER VALUES(?,?)");
                ps.setString(1,user.getUsername());
                ps.setBytes(2,serializzaBuild(build));
                ps.executeUpdate();
            }
            else {
                PreparedStatement ps=conn.prepareStatement("UPDATE Build_Your_Dream.BUILDER SET dati=? WHERE USER_ID=?");
                ps.setBytes(1,serializzaBuild(build));
                ps.setString(2,user.getUsername());
                ps.executeUpdate();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public int getNextID() {
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT MAX(ID_BUILD) FROM Build_Your_Dream.BUILDS");
            ResultSet rs=ps.executeQuery();
            if(rs.next()) {
                return rs.getInt(1)+1;
            }
            else {
                return 0;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public int saveBuild(Build build, User user, String nome, int id) {
        try {
            Connection conn=DB.getConn();
            if(id==-1) {
                int newID=getNextID();
                UserBuild userBuild=new UserBuild(newID,nome,build);
                PreparedStatement ps=conn.prepareStatement("INSERT INTO Build_Your_Dream.BUILDS VALUES(?,?,?)");
                ps.setInt(1,newID);
                ps.setBytes(2,serializzaBuild(userBuild));
                ps.setString(3,nome);
                ps.executeUpdate();
                ps=conn.prepareStatement("INSERT INTO Build_Your_Dream.CREARE VALUES (?,?)");
                ps.setString(1,user.getUsername());
                ps.setInt(2,newID);
                ps.executeUpdate();
                return newID;
            }
            else {
                UserBuild userBuild=new UserBuild(id,nome,build);
                PreparedStatement ps=conn.prepareStatement("UPDATE Build_Your_Dream.BUILDS SET dati=? WHERE ID_BUILD=?");
                ps.setBytes(1,serializzaBuild(userBuild));
                ps.setInt(2,id);
                ps.executeUpdate();
                return id;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public Build loadBuild(User user) {
        Build build = null;
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("select * from Build_Your_Dream.BUILDER where user_id=?");
            ps.setString(1,user.getUsername());
            ResultSet rs=ps.executeQuery();
            if(rs.next()) {
                byte[] dati = rs.getBytes("dati");
                ByteArrayInputStream bis = new ByteArrayInputStream(dati);
                ObjectInputStream ois = new ObjectInputStream(bis);
                build=(Build) ois.readObject();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        return build;
    }

    public ArrayList<Integer> getIdsOfUser(User user) {
        ArrayList<Integer> ids=new ArrayList<>();

        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT * FROM Build_Your_Dream.CREARE where ID_USER=?");
            ps.setString(1,user.getUsername());
            ResultSet rs=ps.executeQuery();
            while(rs.next()) {
                ids.add(rs.getInt(2));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return ids;
    }

    public UserBuild loadBuild(User user, int id) {
        UserBuild build = null;
        try {
            Connection conn=DB.getConn();
            ArrayList<Integer> ids=getIdsOfUser(user);
            if(ids.contains(id)) {
                PreparedStatement ps=conn.prepareStatement("SELECT * FROM Build_Your_Dream.BUILDS where ID_BUILD=?");
                ps.setInt(1,id);
                ResultSet rs=ps.executeQuery();
                if(rs.next()) {
                    byte[] dati = rs.getBytes("dati");
                    ByteArrayInputStream bis = new ByteArrayInputStream(dati);
                    ObjectInputStream ois = new ObjectInputStream(bis);
                    build = (UserBuild) ois.readObject();
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return build;
    }

    public List<UserBuild> loadAllBuilds(User user) {
        List<UserBuild> builds = new ArrayList<>();
        try {
            Connection conn=DB.getConn();
            ArrayList<Integer> ids=getIdsOfUser(user);
            PreparedStatement ps=conn.prepareStatement("SELECT * FROM Build_Your_Dream.BUILDS");
            ResultSet rs=ps.executeQuery();
            while(rs.next()) {
                if(ids.contains(rs.getInt(1))) {
                    byte[] dati = rs.getBytes("dati");
                    ByteArrayInputStream bis = new ByteArrayInputStream(dati);
                    ObjectInputStream ois = new ObjectInputStream(bis);
                    builds.add(new UserBuild(rs.getInt(1),rs.getString(3),(Build) ois.readObject()));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return builds;
    }

    public void removeBuild(int id, User user) {
        try {
            Connection conn=DB.getConn();
            ArrayList<Integer> ids=getIdsOfUser(user);
            if(ids.contains(id)) {
                PreparedStatement ps=conn.prepareStatement("DELETE FROM Build_Your_Dream.CREARE where ID_BUILD=?");
                ps.setInt(1,id);
                ps.executeUpdate();
                ps=conn.prepareStatement("DELETE FROM Build_Your_Dream.BUILDS where ID_BUILD=?");
                ps.setInt(1,id);
                ps.executeUpdate();
            }
            else {
                throw new BuildIsNotOwnerByTheUser();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
