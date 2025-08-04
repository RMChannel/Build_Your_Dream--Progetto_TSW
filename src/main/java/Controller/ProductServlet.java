
package Controller;

import Model.Accessori.Headset.HeadSet;
import Model.Accessori.Headset.HeadSetDAO;
import Model.Accessori.Monitor.Monitor;
import Model.Accessori.Monitor.MonitorDAO;
import Model.Accessori.Mouse.Mouse;
import Model.Accessori.Mouse.MouseDAO;
import Model.Accessori.StreamDeck.StreamDeck;
import Model.Accessori.StreamDeck.StreamDeckDAO;
import Model.Accessori.Tappetino.Tappetino;
import Model.Accessori.Tappetino.TappetinoDAO;
import Model.Accessori.Tastiera.Tastiera;
import Model.Accessori.Tastiera.TastieraDAO;
import Model.Pezzi.CPU.CPU;
import Model.Pezzi.CPU.CPUDAO;
import Model.Pezzi.GPU.GPU;
import Model.Pezzi.GPU.GPUDAO;
import Model.Pezzi.RAM.RAM;
import Model.Pezzi.RAM.RAMDAO;
import Model.Pezzi.PSU.PSU;
import Model.Pezzi.PSU.PSUDAO;
import Model.Pezzi.Motherboard.Motherboard;
import Model.Pezzi.Motherboard.MotherboardDAO;
import Model.Pezzi.Memory.Memory;
import Model.Pezzi.Memory.MemoryDAO;
import Model.Pezzi.Cooling.AirCooling;
import Model.Pezzi.Cooling.AirCoolingDAO;
import Model.Pezzi.Cooling.LiquidCooling;
import Model.Pezzi.Cooling.LiquidCoolingDAO;
import Model.Pezzi.Case.Case;
import Model.Pezzi.Case.CaseDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/product")
public class ProductServlet extends HttpServlet { // carica la pagina dei prodotti versione mobile
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id=0;
        String type=request.getParameter("type"); //prende il tipo di prodotto
        if(type!=null) {
            try {
                id=Integer.parseInt(request.getParameter("id")); // se il tipo non null, prende anche l'id e verifica che sia corretto
            } catch (NumberFormatException e) {
                response.setStatus(405);
                return;
            }
        }
        else {
            response.setStatus(405);
            return;
        }
        request.setAttribute("piece",type);
        switch (type) {
            case "HeadSet": {
                HeadSetDAO headSetDAO = new HeadSetDAO();
                HeadSet headSet = headSetDAO.getPezzo(id);
                request.setAttribute("pezzo", headSet);
                request.setAttribute("type", "accessorio");
                request.setAttribute("marca", headSet.getMarca());
                request.setAttribute("modello", headSet.getModello());
                break;
            }
            case "Monitor": {
                MonitorDAO monitorDAO = new MonitorDAO();
                Monitor monitor = monitorDAO.getPezzo(id);
                request.setAttribute("pezzo", monitor);
                request.setAttribute("type", "accessorio");
                request.setAttribute("marca", monitor.getMarca());
                request.setAttribute("modello", monitor.getModello());
                break;
            }
            case "Mouse": {
                MouseDAO mouseDAO = new MouseDAO();
                Mouse mouse = mouseDAO.getPezzo(id);
                request.setAttribute("pezzo", mouse);
                request.setAttribute("type", "accessorio");
                request.setAttribute("marca", mouse.getMarca());
                request.setAttribute("modello", mouse.getModello());
                break;
            }
            case "StreamDeck": {
                StreamDeckDAO streamDeckDAO = new StreamDeckDAO();
                StreamDeck streamDeck = streamDeckDAO.getPezzo(id);
                request.setAttribute("pezzo", streamDeck);
                request.setAttribute("type", "accessorio");
                request.setAttribute("marca", streamDeck.getMarca());
                request.setAttribute("modello", streamDeck.getModello());
                break;
            }
            case "Tappetino": {
                TappetinoDAO tappetinoDAO = new TappetinoDAO();
                Tappetino tappetino = tappetinoDAO.getPezzo(id);
                request.setAttribute("pezzo", tappetino);
                request.setAttribute("type", "accessorio");
                request.setAttribute("marca", tappetino.getMarca());
                request.setAttribute("modello", tappetino.getModello());
                break;
            }
            case "Tastiera": {
                TastieraDAO tastieraDAO = new TastieraDAO();
                Tastiera tastiera = tastieraDAO.getPezzo(id);
                request.setAttribute("pezzo", tastiera);
                request.setAttribute("type", "accessorio");
                request.setAttribute("marca", tastiera.getMarca());
                request.setAttribute("modello", tastiera.getModello());
                break;
            }
            case "CPU": {
                CPUDAO cpuDAO = new CPUDAO();
                CPU cpu = cpuDAO.getPezzo(id);
                request.setAttribute("pezzo", cpu);
                request.setAttribute("type", "pezzo");
                request.setAttribute("marca", cpu.getMarca());
                request.setAttribute("modello", cpu.getModello());
                break;
            }
            case "GPU": {
                GPUDAO gpuDAO = new GPUDAO();
                GPU gpu = gpuDAO.getPezzo(id);
                request.setAttribute("pezzo", gpu);
                request.setAttribute("type", "pezzo");
                request.setAttribute("marca", gpu.getMarca());
                request.setAttribute("modello", gpu.getModello());
                break;
            }
            case "RAM": {
                RAMDAO ramDAO = new RAMDAO();
                RAM ram = ramDAO.getPezzo(id);
                request.setAttribute("pezzo", ram);
                request.setAttribute("type", "pezzo");
                request.setAttribute("marca", ram.getMarca());
                request.setAttribute("modello", ram.getModello());
                break;
            }
            case "PSU": {
                PSUDAO psuDAO = new PSUDAO();
                PSU psu = psuDAO.getPezzo(id);
                request.setAttribute("pezzo", psu);
                request.setAttribute("type", "pezzo");
                request.setAttribute("marca", psu.getMarca());
                request.setAttribute("modello", psu.getModello());
                break;
            }
            case "Motherboard": {
                MotherboardDAO motherboardDAO = new MotherboardDAO();
                Motherboard motherboard = motherboardDAO.getPezzo(id);
                request.setAttribute("pezzo", motherboard);
                request.setAttribute("type", "pezzo");
                request.setAttribute("marca", motherboard.getMarca());
                request.setAttribute("modello", motherboard.getModello());
                break;
            }
            case "Memory": {
                MemoryDAO memoryDAO = new MemoryDAO();
                Memory memory = memoryDAO.getPezzo(id);
                request.setAttribute("pezzo", memory);
                request.setAttribute("type", "pezzo");
                request.setAttribute("marca", memory.getMarca());
                request.setAttribute("modello", memory.getModello());
                break;
            }
            case "LiquidCooling": {
                LiquidCoolingDAO liquidCoolingDAO = new LiquidCoolingDAO();
                LiquidCooling liquidCooling = liquidCoolingDAO.getPezzo(id);
                request.setAttribute("pezzo", liquidCooling);
                request.setAttribute("type", "pezzo");
                request.setAttribute("marca", liquidCooling.getMarca());
                request.setAttribute("modello", liquidCooling.getModello());
                break;
            }
            case "AirCooling": {
                AirCoolingDAO airCoolingDAO = new AirCoolingDAO();
                AirCooling airCooling = airCoolingDAO.getPezzo(id);
                request.setAttribute("pezzo", airCooling);
                request.setAttribute("type", "pezzo");
                request.setAttribute("marca", airCooling.getMarca());
                request.setAttribute("modello", airCooling.getModello());
                break;
            }
            case "Case": {
                CaseDAO caseDAO = new CaseDAO();
                Case cases = caseDAO.getPezzo(id);
                request.setAttribute("pezzo", cases);
                request.setAttribute("type", "pezzo");
                request.setAttribute("marca", cases.getMarca());
                request.setAttribute("modello", cases.getModello());
                break;
            }
            default: {
                System.out.println(type);
            }
        }
        String realPath=getServletContext().getRealPath("/");
        request.setAttribute("realPath",realPath);
        request.getRequestDispatcher("/table_page/product.jsp").forward(request,response);
    }
}
