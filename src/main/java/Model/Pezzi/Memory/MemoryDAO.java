package Model.Pezzi.Memory;

import Database.DB;
import Foto.FotoDAO;
import Model.Pezzi.Pezzo;
import Model.Pezzi.PezzoDAO;
import Model.Pezzi.PezzoNotFound;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class MemoryDAO {
    public List<Memory> getPezzi() {
        List<Memory> memoryList=new ArrayList<>();
        try {
            PezzoDAO pezzoDAO=new PezzoDAO();
            HashMap<Integer, Pezzo> pezzi=pezzoDAO.getPezzi();
            Connection conn= DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT * FROM Build_Your_Dream.MEMORY");
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {
                Pezzo pezzo=pezzi.get(rs.getInt(1));
                if(pezzo==null) throw new PezzoNotFound();
                memoryList.add(new Memory(rs.getInt(1),pezzo.getMarca(),pezzo.getModello(),pezzo.getPrezzo(),pezzo.getDisponibilita(),pezzo.getSconto(),rs.getString(2),rs.getString(3),rs.getString(4),rs.getInt(5),rs.getInt(6),rs.getInt(7)));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return memoryList;
    }

    public List<String> getAllMarche() {
        List<String> marche=new ArrayList<>();
        try {
            Connection conn= DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISTINCT MARCA FROM Build_Your_Dream.PEZZI WHERE ID_PEZZO IN (SELECT MEMORY.ID_PEZZO FROM Build_Your_Dream.MEMORY) ORDER BY MARCA");
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {
                marche.add(rs.getString(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return marche;
    }

    public List<String> getAllCategories() {
        List<String> categories=new ArrayList<>();
        try {
            Connection conn= DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISTINCT CATEGORIA FROM Build_Your_Dream.MEMORY ORDER BY CATEGORIA");
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {
                categories.add(rs.getString(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return categories;
    }

    public List<String> getAllTipologie() {
        List<String> tipologie=new ArrayList<>();
        try {
            Connection conn= DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISTINCT TIPOLOGIA FROM Build_Your_Dream.MEMORY ORDER BY TIPOLOGIA");
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {
                tipologie.add(rs.getString(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return tipologie;
    }

    public List<String> getAllInterfacce() {
        List<String> interfacce=new ArrayList<>();
        try {
            Connection conn= DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISTINCT INTERFACCIA FROM Build_Your_Dream.MEMORY ORDER BY INTERFACCIA");
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {
                interfacce.add(rs.getString(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return interfacce;
    }

    public List<Integer> getAllCapacities() {
        List<Integer> capacities=new ArrayList<>();
        try {
            Connection conn= DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISTINCT CAPACITA FROM Build_Your_Dream.MEMORY ORDER BY CAPACITA");
            ResultSet rs=ps.executeQuery();
            while (rs.next()) {
                capacities.add(rs.getInt(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return capacities;
    }

    public Memory getPezzo(int id) {
        Memory memory = null;
        try {
            PezzoDAO pezzoDAO = new PezzoDAO();
            Pezzo pezzo = pezzoDAO.getPezzoFromID(id);
            Connection conn = DB.getConn();
            PreparedStatement ps = conn.prepareStatement("select * from Build_Your_Dream.MEMORY where ID_PEZZO=?");
            ps.setInt(1, id);
            ResultSet rsMemory = ps.executeQuery();
            if (rsMemory.next()) {
                memory = new Memory(rsMemory.getInt(1), pezzo.getMarca(), pezzo.getModello(), pezzo.getPrezzo(), pezzo.getDisponibilita(), pezzo.getSconto(), rsMemory.getString(2), rsMemory.getString(3), rsMemory.getString(4), rsMemory.getInt(5), rsMemory.getInt(6), rsMemory.getInt(7));
            } else {
                throw new PezzoNotFound();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return memory;
    }

    public void update(Memory memory) {
        try {
            PezzoDAO pezzoDAO = new PezzoDAO();
            pezzoDAO.update(memory);
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("UPDATE Build_Your_Dream.MEMORY SET CATEGORIA=?, TIPOLOGIA=?, INTERFACCIA=?, CAPACITA=?, READ_SPEED=?, WRITE_SPEED=? WHERE ID_PEZZO=?");
            ps.setString(1,memory.getCategoria());
            ps.setString(2,memory.getTipologia());
            ps.setString(3,memory.getInterfaccia());
            ps.setInt(4,memory.getCapacita());
            ps.setInt(5,memory.getReadSpeed());
            ps.setInt(6,memory.getWriteSpeed());
            ps.setInt(7,memory.getID());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void delete(int id, String path) {
        try {
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("DELETE FROM Build_Your_Dream.MEMORY WHERE ID_PEZZO=?");
            ps.setInt(1, id);
            ps.executeUpdate();
            PezzoDAO pezzoDAO = new PezzoDAO();
            pezzoDAO.delete(id);
            FotoDAO fotoDAO = new FotoDAO();
            fotoDAO.removeFoto(id,"fotoPezzi","Memory",path);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void newMemory(Memory memory) {
        try {
            PezzoDAO pezzoDAO = new PezzoDAO();
            pezzoDAO.newPezzo(memory);
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("INSERT INTO Build_Your_Dream.MEMORY VALUES (?,?,?,?,?,?,?)");
            ps.setInt(1,memory.getID());
            ps.setString(2,memory.getCategoria());
            ps.setString(3,memory.getTipologia());
            ps.setString(4,memory.getInterfaccia());
            ps.setInt(5,memory.getCapacita());
            ps.setInt(6,memory.getReadSpeed());
            ps.setInt(7,memory.getWriteSpeed());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
