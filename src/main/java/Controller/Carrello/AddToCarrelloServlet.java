package Controller.Carrello;

import Model.Accessori.Accessorio;
import Model.Accessori.AccessorioDAO;
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
import Model.Carrello.Carrello;
import Model.Carrello.CarrelloDAO;
import Model.Pezzi.CPU.CPU;
import Model.Pezzi.CPU.CPUDAO;
import Model.Pezzi.Case.Case;
import Model.Pezzi.Case.CaseDAO;
import Model.Pezzi.Cooling.AirCooling;
import Model.Pezzi.Cooling.AirCoolingDAO;
import Model.Pezzi.Cooling.LiquidCooling;
import Model.Pezzi.Cooling.LiquidCoolingDAO;
import Model.Pezzi.GPU.GPU;
import Model.Pezzi.GPU.GPUDAO;
import Model.Pezzi.Memory.Memory;
import Model.Pezzi.Memory.MemoryDAO;
import Model.Pezzi.Motherboard.Motherboard;
import Model.Pezzi.Motherboard.MotherboardDAO;
import Model.Pezzi.PSU.PSU;
import Model.Pezzi.PSU.PSUDAO;
import Model.Pezzi.Pezzo;
import Model.Pezzi.PezzoDAO;
import Model.Pezzi.RAM.RAM;
import Model.Pezzi.RAM.RAMDAO;
import Model.PreBuilts.PreBuilt;
import Model.PreBuilts.PreBuiltDAO;
import Model.Users.User;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/addToCarrello")
public class AddToCarrelloServlet extends HttpServlet { // gestisce l'aggiunta di un prodotto al carrello
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        CarrelloDAO carrelloDAO = new CarrelloDAO();
        HttpSession session=request.getSession();
        User user= (User) session.getAttribute("user");
        Carrello carrello=(Carrello) session.getAttribute("carrello");
        if(carrello==null) {
            if(user!=null) {
                carrello=carrelloDAO.loadCarrello(user);
                if(carrello==null) {
                    carrello=new Carrello();
                }
            }
            else {
                carrello=new Carrello();
            }
            session.setAttribute("carrello",carrello);
        }
        String type=request.getParameter("type");
        String table=request.getParameter("table");
        String tempId=request.getParameter("id");
        int id=Integer.parseInt(tempId);
        if(type.equals("pezzi") || type.equals("pezzo")) {
            switch (table) {
                case "CPU":
                    CPUDAO cpuDAO=new CPUDAO();
                    CPU cpu=cpuDAO.getPezzo(id);
                    carrello.addToChart(cpu);
                    break;
                case "GPU":
                    GPUDAO gpuDAO=new GPUDAO();
                    GPU gpu=gpuDAO.getPezzo(id);
                    carrello.addToChart(gpu);
                    break;
                case "RAM":
                    RAMDAO ramdao=new RAMDAO();
                    RAM ram=ramdao.getPezzo(id);
                    carrello.addToChart(ram);
                    break;
                case "PSU":
                    PSUDAO psudao=new PSUDAO();
                    PSU psu=psudao.getPezzo(id);
                    carrello.addToChart(psu);
                    break;
                case "Motherboard":
                    MotherboardDAO motherboardDAO=new MotherboardDAO();
                    Motherboard motherboard=motherboardDAO.getPezzo(id);
                    carrello.addToChart(motherboard);
                    break;
                case "HDD/SSD":
                    MemoryDAO memoryDAO=new MemoryDAO();
                    Memory memory=memoryDAO.getPezzo(id);
                    carrello.addToChart(memory);
                    break;
                case "Cooling": case "LiquidCooling": case "AirCooling":
                    String coolingtype=request.getParameter("coolingType");
                    if(coolingtype==null) coolingtype="liquid";
                    if(coolingtype.equals("liquid") || coolingtype.equals("LiquidCooling")) {
                        LiquidCoolingDAO liquidCoolingDAO=new LiquidCoolingDAO();
                        LiquidCooling liquidCooling=liquidCoolingDAO.getPezzo(id);
                        carrello.addToChart(liquidCooling);
                    }
                    else {
                        AirCoolingDAO airCoolingDAO=new AirCoolingDAO();
                        AirCooling airCooling=airCoolingDAO.getPezzo(id);
                        carrello.addToChart(airCooling);
                    }
                    break;
                case "Case":
                    CaseDAO caseDAO=new CaseDAO();
                    Case cases=caseDAO.getPezzo(id);
                    carrello.addToChart(cases);
                    break;
                default:
                    PezzoDAO pezzoDAO=new PezzoDAO();
                    Pezzo pezzo=pezzoDAO.getPezzoFromID(id);
                    carrello.addToChart(pezzo);
                    break;
            }
        }
        else if(type.equals("accessori") || type.equals("accessorio")) {
            switch (table) {
                case "Headset":
                    HeadSetDAO headsetDAO=new HeadSetDAO();
                    HeadSet headset=headsetDAO.getPezzo(id);
                    carrello.addToChart(headset);
                    break;
                case "Monitor":
                    MonitorDAO monitorDAO=new MonitorDAO();
                    Monitor monitor=monitorDAO.getPezzo(id);
                    carrello.addToChart(monitor);
                    break;
                case "Mouse":
                    MouseDAO mouseDAO=new MouseDAO();
                    Mouse mouse=mouseDAO.getPezzo(id);
                    carrello.addToChart(mouse);
                    break;
                case "StreamDeck":
                    StreamDeckDAO streamDeckDAO=new StreamDeckDAO();
                    StreamDeck streamDeck=streamDeckDAO.getPezzo(id);
                    carrello.addToChart(streamDeck);
                    break;
                case "Tappetini":
                    TappetinoDAO tappetinoDAO=new TappetinoDAO();
                    Tappetino tappetino=tappetinoDAO.getPezzo(id);
                    carrello.addToChart(tappetino);
                    break;
                case "Tastiere":
                    TastieraDAO tastieraDAO=new TastieraDAO();
                    Tastiera tastiera=tastieraDAO.getPezzo(id);
                    carrello.addToChart(tastiera);
                    break;
                default:
                    AccessorioDAO accessorioDAO=new AccessorioDAO();
                    Accessorio accessorio=accessorioDAO.getAccessorioFromID(id);
                    carrello.addToChart(accessorio);
                    break;
            }
        }
        else {
            PreBuiltDAO preBuiltDAO=new PreBuiltDAO();
            PreBuilt preBuilt=preBuiltDAO.getPrebuiltByID(id);
            carrello.addToChart(preBuilt);
        }
        if(user!=null) carrelloDAO.saveCarrello(carrello,user);
        response.sendError(200);
    }
}
