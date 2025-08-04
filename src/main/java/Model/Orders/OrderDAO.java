package Model.Orders;

import Database.DB;
import Model.Accessori.Accessorio;
import Model.Accessori.AccessorioDAO;
import Model.Carrello.Carrello;
import Model.Carrello.CarrelloDAO;
import Model.Carrello.Item;
import Model.Pezzi.Pezzo;
import Model.Pezzi.PezzoDAO;
import Model.PreBuilts.PreBuilt;
import Model.PreBuilts.PreBuiltDAO;
import Model.Users.User;
import org.eclipse.tags.shaded.org.apache.xpath.operations.Or;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {
    public int genNextInt() {
        try {
            Connection conn= DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT MAX(Build_Your_Dream.ORDERS.CODICE) FROM Build_Your_Dream.ORDERS");
            ResultSet rs=ps.executeQuery();
            int max=0;
            if(rs.next()) {
                max=rs.getInt(1);
            }
            else {
                ps=conn.prepareStatement("SELECT * FROM Build_Your_Dream.ORDERS");
                rs=ps.executeQuery();
                if(rs.next()) {
                    throw new MaxNotFoundException();
                }
            }
            return max+1;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void createOrder(Order order) {
        try {
            Connection conn= DB.getConn();
            PreparedStatement ps=conn.prepareStatement("INSERT INTO Build_Your_Dream.ORDERS VALUES (?,?,?,?,?,?,?,?,?,?,?)");
            ps.setInt(1,order.getCodice());
            ps.setInt(2,order.getStatus());
            ps.setDate(3, order.getData());
            ps.setString(4,order.getId_user());
            ps.setString(5,order.getnTel());
            ps.setInt(6,order.getCivico());
            ps.setString(7,order.getCap());
            ps.setString(8,order.getVia());
            ps.setString(9,order.getCitta());
            ps.setString(10,order.getnCarta());
            CarrelloDAO carrelloDAO=new CarrelloDAO();
            ps.setBytes(11,carrelloDAO.serializzaCarrello(order.getCarrello()));
            ps.executeUpdate();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public Order getOrderBtID(int id) {
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT * FROM Build_Your_Dream.ORDERS WHERE CODICE=?");
            ps.setInt(1,id);
            ResultSet rs=ps.executeQuery();
            if(rs.next()) {
                byte[] dati = rs.getBytes(11);
                ByteArrayInputStream bis = new ByteArrayInputStream(dati);
                ObjectInputStream ois = new ObjectInputStream(bis);
                Carrello carrello = (Carrello) ois.readObject();
                return new Order(rs.getInt(1),rs.getInt(2),rs.getDate(3),rs.getString(4),rs.getString(5),rs.getInt(6),rs.getString(7),rs.getString(8),rs.getString(9),rs.getString(10),carrello);
            }
            else throw new OrderNotFoundException();
        } catch (SQLException | IOException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    public List<Order> getOrdersForUser(User user) {
        List<Order> orders = new ArrayList<>();
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT * FROM Build_Your_Dream.ORDERS WHERE ID_USER=?");
            ps.setString(1,user.getUsername());
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {
                byte[] dati = rs.getBytes(11);
                ByteArrayInputStream bis = new ByteArrayInputStream(dati);
                ObjectInputStream ois = new ObjectInputStream(bis);
                Carrello carrello = (Carrello) ois.readObject();
                orders.add(new Order(rs.getInt(1),rs.getInt(2),rs.getDate(3),rs.getString(4),rs.getString(5),rs.getInt(6),rs.getString(7),rs.getString(8),rs.getString(9),rs.getString(10),carrello));
            }
        } catch (SQLException | ClassNotFoundException | IOException e) {
            throw new RuntimeException(e);
        }
        return orders;
    }

    public void effettuaRimborsoOrdine(Order order, int status) {
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("UPDATE Build_Your_Dream.ORDERS SET STATUS=? WHERE CODICE=?");
            ps.setInt(1,status);
            ps.setInt(2,order.getCodice());
            ps.executeUpdate();
            ps=conn.prepareStatement("SELECT CONTENUTO_ORDINE FROM Build_Your_Dream.ORDERS WHERE CODICE=?");
            ps.setInt(1,order.getCodice());
            ResultSet rs=ps.executeQuery();
            if(rs.next()) {
                byte[] dati = rs.getBytes(1);
                ByteArrayInputStream bis = new ByteArrayInputStream(dati);
                ObjectInputStream ois = new ObjectInputStream(bis);
                Carrello carrello = (Carrello) ois.readObject();
                for(Item item:carrello.getObjects()) {
                    if(item.getObject() instanceof Pezzo pezzo) {
                        PezzoDAO pezzoDAO = new PezzoDAO();
                        pezzoDAO.increaseQuantity(pezzo,item.getQuantity());
                    }
                    else if(item.getObject() instanceof Accessorio accessorio) {
                        AccessorioDAO accessorioDAO = new AccessorioDAO();
                        accessorioDAO.increaseQuantity(accessorio,item.getQuantity());
                    }
                    else if(item.getObject() instanceof PreBuilt preBuilt) {
                        PreBuiltDAO preBuiltDAO = new PreBuiltDAO();
                        preBuiltDAO.increaseQuantity(preBuilt,item.getQuantity());
                    }
                }
            }
        } catch (SQLException | IOException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    public List<Order> getAllOrders() {
        List<Order> orders=new ArrayList<>();
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT * FROM Build_Your_Dream.ORDERS");
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {
                byte[] dati = rs.getBytes(11);
                ByteArrayInputStream bis = new ByteArrayInputStream(dati);
                ObjectInputStream ois = new ObjectInputStream(bis);
                Carrello carrello = (Carrello) ois.readObject();
                orders.add(new Order(rs.getInt(1),rs.getInt(2),rs.getDate(3),rs.getString(4),rs.getString(5),rs.getInt(6),rs.getString(7),rs.getString(8),rs.getString(9),rs.getString(10),carrello));
            }
        } catch (SQLException | IOException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        return orders;
    }

    public void changeStateOfOrder(int id, int stato) {
        if(stato<0) {
            effettuaRimborsoOrdine(getOrderBtID(id),stato);
        }
        else {
            try {
                Connection conn=DB.getConn();
                PreparedStatement ps=conn.prepareStatement("UPDATE Build_Your_Dream.ORDERS SET STATUS=? WHERE CODICE=?");
                ps.setInt(1,stato);
                ps.setInt(2,id);
                ps.executeUpdate();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
    }
}
