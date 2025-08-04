package Model.Accessori.StreamDeck;

import Database.DB;
import Foto.FotoDAO;
import Model.Accessori.Accessorio;
import Model.Accessori.AccessorioDAO;
import Model.Accessori.AccessorioNotFound;
import Model.IDAlreadyRegistred;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class StreamDeckDAO {
    public List<StreamDeck> getAccessori() {
        List<StreamDeck> streamDecks=new ArrayList<>();
        try {
            AccessorioDAO accessorioDAO=new AccessorioDAO();
            HashMap<Integer, Accessorio> accessori=accessorioDAO.getAccessori();
            Connection conn= DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT * FROM Build_Your_Dream.STREAM_DECK");
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {
                Accessorio accessorio=accessori.get(rs.getInt(1));
                if(accessorio==null) throw new AccessorioNotFound();
                String tipiTasti=rs.getString(3);
                List<String> tipiTastiList= List.of(tipiTasti.split(","));
                streamDecks.add(new StreamDeck(rs.getInt(1),accessorio.getMarca(),accessorio.getModello(),accessorio.getPrezzo(),accessorio.getDisponibilita(),accessorio.getSconto(),rs.getInt(2),tipiTastiList, rs.getString(4), rs.getDouble(5),rs.getDouble(6)));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return streamDecks;
    }

    public List<String> getAllMarche() {
        List<String> marche=new ArrayList<>();
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISTINCT MARCA FROM Build_Your_Dream.ACCESSORI WHERE ID_ACCESSORIO IN (SELECT STREAM_DECK.ID_ACCESSORIO FROM Build_Your_Dream.STREAM_DECK) ORDER BY MARCA");
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {
                marche.add(rs.getString(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return marche;
    }

    public List<String> getAllConnectionTypes() {
        List<String> connectionTypes=new ArrayList<>();
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISTINCT CONNECTION_TYPE FROM Build_Your_Dream.STREAM_DECK ORDER BY CONNECTION_TYPE");
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {
                connectionTypes.add(rs.getString(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return connectionTypes;
    }

    public List<String> getAllTipiTasti() {
        List<String> tipiTasti=new ArrayList<>();
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT TIPO_TASTI FROM Build_Your_Dream.STREAM_DECK");
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {
                List<String> temp=List.of(rs.getString(1).split(","));
                for(String s:temp){
                    if(!tipiTasti.contains(s.strip())) tipiTasti.add(s.strip());
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        tipiTasti.sort(String::compareToIgnoreCase);
        return tipiTasti;
    }

    public StreamDeck getPezzo(int id) {
        StreamDeck streamDeck = null;
        try {
            AccessorioDAO accessorioDAO = new AccessorioDAO();
            Accessorio accessorio = accessorioDAO.getAccessorioFromID(id);
            Connection conn = DB.getConn();
            PreparedStatement ps = conn.prepareStatement("select * from Build_Your_Dream.STREAM_DECK where ID_ACCESSORIO=?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String tipiTasti = rs.getString(3);
                List<String> tipiTastiList = List.of(tipiTasti.split(","));
                streamDeck = new StreamDeck(rs.getInt(1), accessorio.getMarca(), accessorio.getModello(), accessorio.getPrezzo(), accessorio.getDisponibilita(), accessorio.getSconto(), rs.getInt(2), tipiTastiList, rs.getString(4), rs.getDouble(5), rs.getDouble(6));
            } else {
                throw new AccessorioNotFound();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return streamDeck;
    }

    public void update(StreamDeck streamDeck) {
        try {
            AccessorioDAO accessorioDAO = new AccessorioDAO();
            accessorioDAO.update(streamDeck);
            String tipoTasti="";
            if(streamDeck.getTipoTasti().size()==1) {
                tipoTasti=streamDeck.getTipoTasti().get(0);
            }
            else {
                StringBuilder tipoTastiBuilder = new StringBuilder(streamDeck.getTipoTasti().remove(0));
                for(String s:streamDeck.getTipoTasti()) {
                    tipoTastiBuilder.append(", ").append(s);
                }
                tipoTasti = tipoTastiBuilder.toString();
            }
            Connection conn = DB.getConn();
            PreparedStatement ps=conn.prepareStatement("UPDATE Build_Your_Dream.STREAM_DECK SET NUMERO_TASTI=?, TIPO_TASTI=?, CONNECTION_TYPE=?, LUNGHEZZA=?, LARGHEZZA=? WHERE ID_ACCESSORIO=?");
            ps.setInt(1,streamDeck.getnTasti());
            ps.setString(2,tipoTasti);
            ps.setString(3,streamDeck.getConnectionType());
            ps.setDouble(4,streamDeck.getLunghezza());
            ps.setDouble(5,streamDeck.getLarghezza());
            ps.setInt(6,streamDeck.getID());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void delete(int id, String path) {
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("DELETE FROM Build_Your_Dream.STREAM_DECK WHERE ID_ACCESSORIO=?");
            ps.setInt(1, id);
            ps.executeUpdate();
            AccessorioDAO accessorioDAO=new AccessorioDAO();
            accessorioDAO.delete(id);
            FotoDAO fotoDAO = new FotoDAO();
            fotoDAO.removeFoto(id,"fotoAccessori","StreamDeck",path);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void newStreamDeck(StreamDeck streamDeck) throws IDAlreadyRegistred {
        try {
            AccessorioDAO accessorioDAO=new AccessorioDAO();
            accessorioDAO.newAccessorio(streamDeck);
            String tipoTasti="";
            if(streamDeck.getTipoTasti().size()==1) {
                tipoTasti=streamDeck.getTipoTasti().get(0);
            }
            else {
                StringBuilder tipoTastiBuilder = new StringBuilder(streamDeck.getTipoTasti().remove(0));
                for(String s:streamDeck.getTipoTasti()) {
                    tipoTastiBuilder.append(", ").append(s);
                }
                tipoTasti = tipoTastiBuilder.toString();
            }
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("INSERT INTO Build_Your_Dream.STREAM_DECK VALUES (?,?,?,?,?,?)");
            ps.setInt(1,streamDeck.getID());
            ps.setInt(2,streamDeck.getnTasti());
            ps.setString(3,tipoTasti);
            ps.setString(4,streamDeck.getConnectionType());
            ps.setDouble(5,streamDeck.getLunghezza());
            ps.setDouble(6,streamDeck.getLarghezza());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
