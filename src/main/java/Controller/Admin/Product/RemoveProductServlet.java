package Controller.Admin.Product;

import Model.Accessori.Headset.HeadSetDAO;
import Model.Accessori.Monitor.MonitorDAO;
import Model.Accessori.Mouse.MouseDAO;
import Model.Accessori.StreamDeck.StreamDeckDAO;
import Model.Accessori.Tappetino.TappetinoDAO;
import Model.Accessori.Tastiera.TastieraDAO;
import Model.Pezzi.CPU.CPUDAO;
import Model.Pezzi.Case.CaseDAO;
import Model.Pezzi.Cooling.AirCoolingDAO;
import Model.Pezzi.Cooling.LiquidCoolingDAO;
import Model.Pezzi.GPU.GPUDAO;
import Model.Pezzi.Memory.MemoryDAO;
import Model.Pezzi.Motherboard.MotherboardDAO;
import Model.Pezzi.PSU.PSUDAO;
import Model.Pezzi.RAM.RAMDAO;
import Model.PreBuilts.PreBuiltDAO;
import Model.Users.User;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.eclipse.tags.shaded.org.apache.regexp.RE;

import java.io.IOException;

@WebServlet("/removeProduct")
@MultipartConfig
public class RemoveProductServlet extends HttpServlet { //gestisce la rimozione di un prodotto da parte dell'admin
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        User user = (User) request.getSession().getAttribute("user");
        if(user == null || !user.isAdmin()) {
            response.sendError(405);
            return;
        }
        response.setContentType("application/json");
        String piece=request.getParameter("piece");
        String type=request.getParameter("type");
        String temp=request.getParameter("id");
        int id=Integer.parseInt(temp);
        if(piece.equals("accessorio")) {
            switch (type) {
                case "headset":
                    HeadSetDAO headSetDAO = new HeadSetDAO();
                    headSetDAO.delete(id,getServletContext().getRealPath("/"));
                    break;
                case "monitor":
                    MonitorDAO monitorDAO = new MonitorDAO();
                    monitorDAO.delete(id,getServletContext().getRealPath("/"));
                    break;
                case "mouse":
                    MouseDAO mouseDAO = new MouseDAO();
                    mouseDAO.delete(id,getServletContext().getRealPath("/"));
                    break;
                case "streamdeck":
                    StreamDeckDAO streamDeckDAO = new StreamDeckDAO();
                    streamDeckDAO.delete(id,getServletContext().getRealPath("/"));
                    break;
                case "tappetino":
                    TappetinoDAO tappetinoDAO = new TappetinoDAO();
                    tappetinoDAO.delete(id,getServletContext().getRealPath("/"));
                    break;
                case "tastiera":
                    TastieraDAO tastieraDAO = new TastieraDAO();
                    tastieraDAO.delete(id,getServletContext().getRealPath("/"));
                    break;
                default:
                    response.sendError(405);
                    return;
            }
            response.getWriter().write("{\"status\": \"success\"}");
            return;
        }
        else if(piece.equals("pezzo")) {
            switch (type) {
                case "cpu":
                    CPUDAO cpuDAO = new CPUDAO();
                    cpuDAO.delete(id,getServletContext().getRealPath("/"));
                    break;
                case "gpu":
                    GPUDAO gpuDAO = new GPUDAO();
                    gpuDAO.delete(id,getServletContext().getRealPath("/"));
                    break;
                case "ram":
                    RAMDAO ramDAO = new RAMDAO();
                    ramDAO.delete(id,getServletContext().getRealPath("/"));
                    break;
                case "psu":
                    PSUDAO psuDAO = new PSUDAO();
                    psuDAO.delete(id,getServletContext().getRealPath("/"));
                    break;
                case "motherboard":
                    MotherboardDAO motherboardDAO = new MotherboardDAO();
                    motherboardDAO.delete(id,getServletContext().getRealPath("/"));
                    break;
                case "memory":
                    MemoryDAO memoryDAO = new MemoryDAO();
                    memoryDAO.delete(id,getServletContext().getRealPath("/"));
                    break;
                case "liquidcooling":
                    LiquidCoolingDAO liquidCoolingDAO = new LiquidCoolingDAO();
                    liquidCoolingDAO.delete(id,getServletContext().getRealPath("/"));
                    break;
                case "aircooling":
                    AirCoolingDAO airCoolingDAO = new AirCoolingDAO();
                    airCoolingDAO.delete(id,getServletContext().getRealPath("/"));
                    break;
                case "case":
                    CaseDAO caseDAO = new CaseDAO();
                    caseDAO.delete(id,getServletContext().getRealPath("/"));
                    break;
                default:
                    response.sendError(405);
                    return;
            }
            response.getWriter().write("{\"status\": \"success\"}");
            return;
        }
        else if(piece.equals("prebuilt")) {
            PreBuiltDAO preBuiltDAO=new PreBuiltDAO();
            preBuiltDAO.delete(id,getServletContext().getRealPath("/"));
            response.getWriter().write("{\"status\": \"success\"}");
            return;
        }
        response.getWriter().write("{\"status\": \"failed\",\"message\": \"Implementazione ancora non effettuata\"}");
    }
}
