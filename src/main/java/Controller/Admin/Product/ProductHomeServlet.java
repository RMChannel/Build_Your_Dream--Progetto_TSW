package Controller.Admin.Product;

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
import Model.PreBuilts.PreBuilt;
import Model.PreBuilts.PreBuiltDAO;
import Model.Users.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/adminPage/gestioneProdotti")
public class ProductHomeServlet extends HttpServlet { //Si occupa del caricamento di tutte le pagine riguardanti la gestione dei prodotti
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        User user = (User) request.getSession().getAttribute("user");
        if(user == null || !user.isAdmin()) {
            response.sendError(405);
            return;
        }
        String piece=request.getParameter("piece");
        if(piece==null) { //Se non c'è il parametro "piece", vuol dire che non abbiamo ancora aperto alcuna pagina e dobbiamo far caricare la pagina principale di gestione prodotti
            request.getRequestDispatcher("/admin/prodotti/chooseProduct.jsp").forward(request,response);
        }
        else {
            request.setAttribute("piece", piece);
            String type=request.getParameter("type");
            request.setAttribute("path",getServletContext().getRealPath("/"));
            if(type==null) { //Se piece c'è, ma type no, alllora vuol dire che abbiamo superato la 1°pagina, ma ora dobbiamo scegliere il tipo specifico di prodotto che vogliamo andare a visualizzare
                switch (piece) {
                    case "pezzi":
                        request.getRequestDispatcher("/admin/prodotti/choosePezzi.jsp").forward(request,response);
                        break;
                    case "accessori":
                        request.getRequestDispatcher("/admin/prodotti/chooseAccessori.jsp").forward(request,response);
                        break;
                    case "prebuilt": //Solo prebuilt viene caricato già adesso perché non ha delle sotto-categorie
                        PreBuiltDAO prebuiltDAO = new PreBuiltDAO();
                        List<PreBuilt> preBuilts=prebuiltDAO.getAllPreBuilts();
                        request.setAttribute("prebuilts", preBuilts);
                        request.getRequestDispatcher("/admin/prodotti/PreBuilt/prebuilt.jsp").forward(request,response);
                        break;
                    default:
                        response.sendError(404);
                        break;
                }
            }
            else {
                switch (piece) {
                    case "pezzi":
                        switch (type) { //Se c'è sia piece che type, allora vuol dire che dev'essere caricata la pagina specifica della tipologia prodotto richiesta
                            case "CPU":
                                CPUDAO cpuDAO = new CPUDAO();
                                List<CPU> cpus=cpuDAO.getPezzi();
                                request.setAttribute("cpus", cpus);
                                request.getRequestDispatcher("/admin/prodotti/Pezzi/cpu.jsp").forward(request,response);
                                break;
                            case "GPU":
                                GPUDAO gpuDAO = new GPUDAO();
                                List<GPU> gpus=gpuDAO.getPezzi();
                                request.setAttribute("gpus", gpus);
                                request.getRequestDispatcher("/admin/prodotti/Pezzi/gpu.jsp").forward(request,response);
                                break;
                            case "RAM":
                                RAMDAO ramDAO = new RAMDAO();
                                List<RAM> rams=ramDAO.getPezzi();
                                request.setAttribute("rams", rams);
                                request.getRequestDispatcher("/admin/prodotti/Pezzi/ram.jsp").forward(request,response);
                                break;
                            case "PSU":
                                PSUDAO psuDAO = new PSUDAO();
                                List<PSU> psus=psuDAO.getPezzi();
                                request.setAttribute("psus", psus);
                                request.getRequestDispatcher("/admin/prodotti/Pezzi/psu.jsp").forward(request,response);
                                break;
                            case "Motherboard":
                                MotherboardDAO motherboardDAO = new MotherboardDAO();
                                List<Motherboard> motherboards=motherboardDAO.getPezzi();
                                request.setAttribute("motherboards", motherboards);
                                request.getRequestDispatcher("/admin/prodotti/Pezzi/motherboard.jsp").forward(request,response);
                                break;
                            case "HDD/SSD":
                                MemoryDAO memoryDAO=new MemoryDAO();
                                List<Memory> memories=memoryDAO.getPezzi();
                                request.setAttribute("memories", memories);
                                request.getRequestDispatcher("/admin/prodotti/Pezzi/hddssd.jsp").forward(request,response);
                                break;
                            case "Cooling":
                                String cooling=request.getParameter("cooling");
                                request.setAttribute("cooling", cooling);
                                if(cooling==null || cooling.isEmpty() || cooling.equals("airCooling")) {
                                    AirCoolingDAO airCoolingDAO=new AirCoolingDAO();
                                    List<AirCooling> airCoolings=airCoolingDAO.getPezzi();
                                    request.setAttribute("aircoolings", airCoolings);
                                }
                                else {
                                    LiquidCoolingDAO liquidCoolingDAO=new LiquidCoolingDAO();
                                    List<LiquidCooling> liquidCoolings=liquidCoolingDAO.getPezzi();
                                    request.setAttribute("liquidcoolings", liquidCoolings);
                                }
                                request.getRequestDispatcher("/admin/prodotti/Pezzi/cooling.jsp").forward(request,response);
                                break;
                            case "Case":
                                CaseDAO caseDAO=new CaseDAO();
                                List<Case> cases=caseDAO.getCases();
                                request.setAttribute("cases", cases);
                                request.getRequestDispatcher("/admin/prodotti/Pezzi/case.jsp").forward(request,response);
                                break;
                            default:
                                response.sendError(404);
                                break;
                        }
                        break;
                    case "accessori":
                        switch (type) {
                            case "Headset":
                                HeadSetDAO headsetDAO = new HeadSetDAO();
                                List<HeadSet> headsets = headsetDAO.getAccessori();
                                request.setAttribute("headsets", headsets);
                                request.getRequestDispatcher("/admin/prodotti/Accessori/headset.jsp").forward(request,response);
                                break;
                            case "Monitor":
                                MonitorDAO monitorDAO = new MonitorDAO();
                                List<Monitor> monitors = monitorDAO.getAccessori();
                                request.setAttribute("monitors", monitors);
                                request.getRequestDispatcher("/admin/prodotti/Accessori/monitor.jsp").forward(request,response);
                                break;
                            case "Mouse":
                                MouseDAO mouseDAO = new MouseDAO();
                                List<Mouse> mouses = mouseDAO.getAccessori();
                                request.setAttribute("mouses", mouses);
                                request.getRequestDispatcher("/admin/prodotti/Accessori/mouse.jsp").forward(request,response);
                                break;
                            case "StreamDeck":
                                StreamDeckDAO streamDeckDAO = new StreamDeckDAO();
                                List<StreamDeck> streamDecks = streamDeckDAO.getAccessori();
                                request.setAttribute("streamDecks", streamDecks);
                                request.getRequestDispatcher("/admin/prodotti/Accessori/streamdeck.jsp").forward(request,response);
                                break;
                            case "Tappetini":
                                TappetinoDAO tappetinoDAO = new TappetinoDAO();
                                List<Tappetino> tappetini = tappetinoDAO.getAccessori();
                                request.setAttribute("tappetini", tappetini);
                                request.getRequestDispatcher("/admin/prodotti/Accessori/tappetino.jsp").forward(request,response);
                                break;
                            case "Tastiere":
                                TastieraDAO tastieraDAO = new TastieraDAO();
                                List<Tastiera> tastiere = tastieraDAO.getAccessori();
                                request.setAttribute("tastiere", tastiere);
                                request.getRequestDispatcher("/admin/prodotti/Accessori/tastiere.jsp").forward(request,response);
                                break;
                            default:
                                response.sendError(404);
                                break;
                        }
                        break;
                    default:
                        response.sendError(404);
                        break;
                }
            }
        }
    }
}
