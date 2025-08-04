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
import Model.Pezzi.RAM.RAM;
import Model.Pezzi.RAM.RAMDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/table")
public class TablePageServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String table=request.getParameter("table");
        String type=request.getParameter("type");
        request.setAttribute("table",table);
        request.setAttribute("type",type);
        List<String> marche=null;
        List<String> categorie=null;
        List<String> sockets=null;
        List<String> tipologie=null;
        if(type.equals("pezzi")) {
            switch (table) {
                case "CPU":
                    CPUDAO cpuDAO = new CPUDAO();
                    List<CPU> cpus=cpuDAO.getPezzi();
                    marche=cpuDAO.getAllMarche();
                    sockets=cpuDAO.getAllSockets();
                    request.setAttribute("piecies",cpus);
                    request.setAttribute("marche",marche);
                    request.setAttribute("sockets",sockets);
                    break;
                case "GPU":
                    GPUDAO gpuDAO = new GPUDAO();
                    List<GPU> gpus=gpuDAO.getPezzi();
                    marche=gpuDAO.getAllMarche();
                    List<Integer> vrams=gpuDAO.getAllVrams();
                    request.setAttribute("piecies",gpus);
                    request.setAttribute("marche",marche);
                    request.setAttribute("vrams",vrams);
                    break;
                case "RAM":
                    RAMDAO ramdao=new RAMDAO();
                    List<RAM> rams=ramdao.getPezzi();
                    marche=ramdao.getAllMarche();
                    categorie=ramdao.getAllCategories();
                    List<Integer> capacities=ramdao.getAllCapacities();
                    tipologie=ramdao.getAllTipologie();
                    List<Integer> frequenze=ramdao.getAllFrequenze();
                    request.setAttribute("piecies",rams);
                    request.setAttribute("marche",marche);
                    request.setAttribute("capacities",capacities);
                    request.setAttribute("tipologie",tipologie);
                    request.setAttribute("categorie",categorie);
                    request.setAttribute("frequenze",frequenze);
                    break;
                case "PSU":
                    PSUDAO psuDAO = new PSUDAO();
                    List<PSU> PSUs=psuDAO.getPezzi();
                    marche=psuDAO.getAllMarche();
                    categorie=psuDAO.getAllCategories();
                    List<String> certificazioni=psuDAO.getAllCertificazioni();
                    request.setAttribute("piecies",PSUs);
                    request.setAttribute("marche",marche);
                    request.setAttribute("categorie",categorie);
                    request.setAttribute("certificazioni",certificazioni);
                    break;
                case "Motherboard":
                    MotherboardDAO motherboardDAO = new MotherboardDAO();
                    List<Motherboard> motherboards=motherboardDAO.getPezzi();
                    marche=motherboardDAO.getAllMarche();
                    sockets=motherboardDAO.getAllSockets();
                    List<String> tipiRam=motherboardDAO.getAllTipiRam();
                    categorie=motherboardDAO.getAllCategories();
                    List<String> pcies=motherboardDAO.getAllPCIE();
                    request.setAttribute("piecies",motherboards);
                    request.setAttribute("marche",marche);
                    request.setAttribute("sockets",sockets);
                    request.setAttribute("tipiRam",tipiRam);
                    request.setAttribute("categorie",categorie);
                    request.setAttribute("pcies",pcies);
                    break;
                case "HDD/SSD":
                    MemoryDAO memoryDAO = new MemoryDAO();
                    List<Memory> memories=memoryDAO.getPezzi();
                    marche=memoryDAO.getAllMarche();
                    categorie=memoryDAO.getAllCategories();
                    tipologie=memoryDAO.getAllTipologie();
                    List<String> interfacce=memoryDAO.getAllInterfacce();
                    List<Integer> capacita=memoryDAO.getAllCapacities();
                    request.setAttribute("piecies",memories);
                    request.setAttribute("marche",marche);
                    request.setAttribute("categorie",categorie);
                    request.setAttribute("tipologie",tipologie);
                    request.setAttribute("interfacce",interfacce);
                    request.setAttribute("capacita",capacita);
                    break;
                case "Cooling":
                    String coolingtype=request.getParameter("coolingType");
                    if(coolingtype==null) coolingtype="liquid";
                    if(coolingtype.equals("liquid")) {
                        LiquidCoolingDAO liquidCoolingDAO=new LiquidCoolingDAO();
                        List<LiquidCooling> liquidCoolings=liquidCoolingDAO.getPezzi();
                        marche=liquidCoolingDAO.getAllMarche();
                        sockets=liquidCoolingDAO.getAllSockets();
                        request.setAttribute("piecies",liquidCoolings);
                    }
                    else if(coolingtype.equals("air")) {
                        AirCoolingDAO airCoolingDAO=new AirCoolingDAO();
                        List<AirCooling> airCoolings=airCoolingDAO.getPezzi();
                        marche=airCoolingDAO.getAllMarche();
                        sockets=airCoolingDAO.getAllSockets();
                        List<Integer> dimVentole=airCoolingDAO.getAllDimVentole();
                        request.setAttribute("piecies",airCoolings);
                        request.setAttribute("dimVentole",dimVentole);
                    }
                    request.setAttribute("marche",marche);
                    request.setAttribute("sockets",sockets);
                    request.setAttribute("coolingType",coolingtype);
                    break;
                case "Case":
                    CaseDAO caseDAO = new CaseDAO();
                    List<Case> cases=caseDAO.getCases();
                    marche=caseDAO.getAllMarche();
                    categorie=caseDAO.getAllCategorie();
                    request.setAttribute("piecies",cases);
                    request.setAttribute("marche",marche);
                    request.setAttribute("categorie",categorie);
                    break;
            }
        }
        else {
            switch (table) {
                case "Headset":
                    HeadSetDAO headsetDAO = new HeadSetDAO();
                    List<HeadSet> headsets=headsetDAO.getAccessori();
                    marche=headsetDAO.getAllMarche();
                    categorie=headsetDAO.getAllCategories();
                    List<String> connectivies=headsetDAO.getAllConnectivies();
                    request.setAttribute("headsets",headsets);
                    request.setAttribute("marche",marche);
                    request.setAttribute("categorie",categorie);
                    request.setAttribute("connectivies",connectivies);
                    break;
                case "Monitor":
                    MonitorDAO monitorDAO = new MonitorDAO();
                    List<Monitor> monitors=monitorDAO.getAccessori();
                    marche=monitorDAO.getAllMarche();
                    List<String> risoluzioni=monitorDAO.getAllRisoluzione();
                    List<String> aspectRatios=monitorDAO.getAllAspectRatios();
                    List<String> tipi=monitorDAO.getAllTipi();
                    List<String> frequenze=monitorDAO.getAllRefreshRates();
                    request.setAttribute("monitors",monitors);
                    request.setAttribute("marche",marche);
                    request.setAttribute("risoluzioni",risoluzioni);
                    request.setAttribute("aspectRatios",aspectRatios);
                    request.setAttribute("tipi",tipi);
                    request.setAttribute("frequenze",frequenze);
                    break;
                case "Mouse":
                    MouseDAO mouseDAO = new MouseDAO();
                    List<Mouse> mouseList=mouseDAO.getAccessori();
                    List<String> connections=mouseDAO.getAllConnections();
                    List<String> forme=mouseDAO.getAllForme();
                    categorie=mouseDAO.getAllCategorie();
                    marche=mouseDAO.getAllMarche();
                    request.setAttribute("mouseList",mouseList);
                    request.setAttribute("connections",connections);
                    request.setAttribute("forme",forme);
                    request.setAttribute("categorie",categorie);
                    request.setAttribute("marche",marche);
                    break;
                case "StreamDeck":
                    StreamDeckDAO streamDeckDAO=new StreamDeckDAO();
                    List<StreamDeck> streamDecks=streamDeckDAO.getAccessori();
                    marche=streamDeckDAO.getAllMarche();
                    List<String> connectionTypes=streamDeckDAO.getAllConnectionTypes();
                    List<String> tipiTasti=streamDeckDAO.getAllTipiTasti();
                    request.setAttribute("streamDecks",streamDecks);
                    request.setAttribute("marche",marche);
                    request.setAttribute("connectionTypes",connectionTypes);
                    request.setAttribute("tipiTasti",tipiTasti);
                    break;
                case "Tappetini":
                    TappetinoDAO tappetinoDAO=new TappetinoDAO();
                    List<Tappetino> tappetini=tappetinoDAO.getAccessori();
                    marche=tappetinoDAO.getAllMarche();
                    request.setAttribute("tappetini",tappetini);
                    request.setAttribute("marche",marche);
                    break;
                case "Tastiere":
                    TastieraDAO tastieraDAO = new TastieraDAO();
                    List<Tastiera> tastiere=tastieraDAO.getAccessori();
                    List<String> layouts=tastieraDAO.getAllLayouts();
                    List<String> connettivita=tastieraDAO.getAllConnecttivities();
                    categorie=tastieraDAO.getAllCategorie();
                    marche=tastieraDAO.getAllMarche();
                    request.setAttribute("tastiere",tastiere);
                    request.setAttribute("layouts",layouts);
                    request.setAttribute("connettivita",connettivita);
                    request.setAttribute("categorie",categorie);
                    request.setAttribute("marche",marche);
                    break;
            }
        }
        request.setAttribute("path",getServletContext().getRealPath("/"));
        request.getRequestDispatcher("table_page/table_page.jsp").forward(request,response);
    }
}
