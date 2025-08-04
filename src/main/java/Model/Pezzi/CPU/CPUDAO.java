package Model.Pezzi.CPU;

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

public class CPUDAO {
    public List<CPU> getPezzi() {
        ArrayList<CPU> cpus=new ArrayList<>();
        try {
            PezzoDAO pezzoDAO=new PezzoDAO();
            HashMap<Integer, Pezzo> pezzoList=pezzoDAO.getPezzi();
            Connection conn= DB.getConn();
            PreparedStatement ps=conn.prepareStatement("select * from Build_Your_Dream.CPU");
            ResultSet rsCPU=ps.executeQuery();
            while(rsCPU.next()){
                Pezzo pezzo=pezzoList.get(rsCPU.getInt(1));
                if(pezzo==null) throw new PezzoNotFound();
                cpus.add(new CPU(rsCPU.getInt(1),pezzo.getMarca(),pezzo.getModello(),pezzo.getPrezzo(),pezzo.getDisponibilita(),pezzo.getSconto(), rsCPU.getString(2), rsCPU.getString(3), rsCPU.getInt(4), rsCPU.getInt(5), rsCPU.getFloat(6), rsCPU.getFloat(7),rsCPU.getInt(8), rsCPU.getString(9), rsCPU.getString(10), rsCPU.getString(11), rsCPU.getString(12), rsCPU.getString(13)));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return cpus;
    }

    public CPU getPezzo(int id) {
        CPU cpu=null;
        try {
            PezzoDAO pezzoDAO=new PezzoDAO();
            Pezzo pezzo=pezzoDAO.getPezzoFromID(id);
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("select * from Build_Your_Dream.CPU where ID_PEZZO=?");
            ps.setInt(1, id);
            ResultSet rsCPU=ps.executeQuery();
            if(rsCPU.next()){
                cpu=new CPU(rsCPU.getInt(1),pezzo.getMarca(),pezzo.getModello(),pezzo.getPrezzo(),pezzo.getDisponibilita(),pezzo.getSconto(), rsCPU.getString(2), rsCPU.getString(3), rsCPU.getInt(4), rsCPU.getInt(5), rsCPU.getFloat(6), rsCPU.getFloat(7),rsCPU.getInt(8), rsCPU.getString(9), rsCPU.getString(10), rsCPU.getString(11), rsCPU.getString(12), rsCPU.getString(13));
            } else{
                throw new PezzoNotFound();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return cpu;
    }

    public List<String> getAllMarche() {
        ArrayList<String> marche=new ArrayList<>();
        try {
            Connection conn= DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISTINCT MARCA FROM Build_Your_Dream.PEZZI WHERE ID_PEZZO IN (SELECT CPU.ID_PEZZO FROM Build_Your_Dream.CPU) ORDER BY MARCA");
            ResultSet rsCPU=ps.executeQuery();
            while(rsCPU.next()){
                marche.add(rsCPU.getString(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return marche;
    }

    public List<String> getAllSockets() {
        ArrayList<String> sockets=new ArrayList<>();
        try {
            Connection conn= DB.getConn();
            PreparedStatement ps=conn.prepareStatement("SELECT DISTINCT SOCKET FROM Build_Your_Dream.CPU");
            ResultSet rsCPU=ps.executeQuery();
            while(rsCPU.next()){
                sockets.add(rsCPU.getString(1));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return sockets;
    }

    public void update(CPU cpu) {
        try {
            PezzoDAO pezzoDAO=new PezzoDAO();
            pezzoDAO.update(cpu);
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("UPDATE Build_Your_Dream.CPU SET FAMIGLIA=?, GENERAZIONE=?, CORE=?, THREAD=?, BASE_FREQUENZA=?, TURBO_FREQUENZA=?, TDP=?, LITOGRAFIA=?, SOCKET=?, MEM_SUP=?, MEM_FREQ=?, PCIE=? WHERE ID_PEZZO=?");
            ps.setString(1,cpu.getFamiglia());
            ps.setString(2,cpu.getGenerazione());
            ps.setInt(3,cpu.getnCore());
            ps.setInt(4,cpu.getnThreads());
            ps.setDouble(5,cpu.getBaseFrequence());
            ps.setDouble(6,cpu.getTurboFrequence());
            ps.setInt(7,cpu.getTDP());
            ps.setString(8,cpu.getLitografia());
            ps.setString(9,cpu.getSocket());
            ps.setString(10,cpu.getMemSup());
            ps.setString(11,cpu.getMemFrequence());
            ps.setString(12,cpu.getPCIE());
            ps.setInt(13,cpu.getID());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void delete(int id, String path) {
        try {
            Connection conn= DB.getConn();
            PreparedStatement ps=conn.prepareStatement("DELETE FROM Build_Your_Dream.CPU WHERE ID_PEZZO=?");
            ps.setInt(1, id);
            ps.executeUpdate();
            PezzoDAO pezzoDAO=new PezzoDAO();
            pezzoDAO.delete(id);
            FotoDAO fotoDAO=new FotoDAO();
            fotoDAO.removeFoto(id,"fotoPezzi","CPU",path);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void newCPU(CPU cpu) {
        try {
            PezzoDAO pezzoDAO=new PezzoDAO();
            pezzoDAO.newPezzo(cpu);
            Connection conn=DB.getConn();
            PreparedStatement ps=conn.prepareStatement("INSERT INTO Build_Your_Dream.CPU VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)");
            ps.setInt(1,cpu.getID());
            ps.setString(2,cpu.getFamiglia());
            ps.setString(3,cpu.getGenerazione());
            ps.setInt(4,cpu.getnCore());
            ps.setInt(5,cpu.getnThreads());
            ps.setDouble(6,cpu.getBaseFrequence());
            ps.setDouble(7,cpu.getTurboFrequence());
            ps.setInt(8,cpu.getTDP());
            ps.setString(9,cpu.getLitografia());
            ps.setString(10,cpu.getSocket());
            ps.setString(11,cpu.getMemSup());
            ps.setString(12,cpu.getMemFrequence());
            ps.setString(13,cpu.getPCIE());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
