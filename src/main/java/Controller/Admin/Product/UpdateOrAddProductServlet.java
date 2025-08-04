package Controller.Admin.Product;

import Foto.FotoDAO;
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
import Model.IDAlreadyRegistred;
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
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;

/*
L'aggiunta e la modifica vengono gestite da un'unica servlet perché i controlli da effettuare sono
esattamente gli stessi, l'unica differenza è che uno deve andare a modificare un prodotto già salvato
nel database e modificarlo nel caso tutti i parametri sono rispettati, nell'altro invece va aggiunto
un nuovo prodotto all'interno del database.

Infatti, questo si nota alla fine di ogni tipologia di prodotto c'è il controllo if(isNew) allora aggiunge
un nuovo prodotto, altrimenti modifica il preesistente.
*/

public class UpdateOrAddProductServlet { //gestisce l'aggiunta o la modifica di un prodotto
    public static void process(HttpServletRequest request, HttpServletResponse response, boolean isNew) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if(user == null || !user.isAdmin()) {
            response.sendError(405);
            return;
        }
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        String piece=request.getParameter("piece");
        String type=request.getParameter("type");
        String temp=request.getParameter("id");
        int id=0;
        try { //Controllo ID
            id = Integer.parseInt(temp);
        } catch (NumberFormatException e) {
            response.getWriter().write("{\"status\": \"error\", \"message\": \"Richiesta non valida\"}");
            return;
        }
        String marca=request.getParameter("marca");
        if(marca==null || marca.isEmpty()) {
            response.getWriter().write("{\"status\": \"error\", \"message\": \"Marca vuota\"}");
            return;
        }
        String modello=request.getParameter("modello");
        if(modello==null || modello.isEmpty()) {
            response.getWriter().write("{\"status\": \"error\", \"message\": \"Modello vuoto\"}");
            return;
        }
        temp=request.getParameter("prezzo");
        double prezzo=0;
        try { //Controllo prezzo
            prezzo=Double.parseDouble(temp);
            if(prezzo<0) {
                response.getWriter().write("{\"status\": \"error\", \"message\": \"Prezzo minore di 0\"}");
                return;
            }
        } catch (NumberFormatException e) {
            response.getWriter().write("{\"status\": \"error\", \"message\": \"Prezzo vuoto o non valido\"}");
            return;
        }
        temp=request.getParameter("disponibilita");
        int disponibilita=0;
        try { //Controllo disponiblità
            disponibilita=Integer.parseInt(temp);
            if (disponibilita<0) {
                response.getWriter().write("{\"status\": \"error\", \"message\": \"Disponibilità minore di 0\"}");
                return;
            }
        } catch (NumberFormatException e) {
            response.getWriter().write("{\"status\": \"error\", \"message\": \"Disponiblità vuota o non valida\"}");
            return;
        }
        temp=request.getParameter("sconto");
        int sconto=0;
        try { //Controllo sconto
            sconto=Integer.parseInt(temp);
            if (sconto < 0 || sconto > 100) {
                response.getWriter().write("{\"status\": \"error\", \"message\": \"Lo sconto deve essere tra 0 e 100\"}");
                return;
            }
        } catch (NumberFormatException e) {
            response.getWriter().write("{\"status\": \"error\", \"message\": \"Sconto vuoto o non valido\"}");
            return;
        }
        //Controllo del resto dei parametri
        if(piece==null || piece.isEmpty()) {
            response.getWriter().write("{\"status\": \"error\", \"message\": \"Richiesta non valida (piece)\"}");
            return;
        }
        if(type==null || type.isEmpty()) {
            response.getWriter().write("{\"status\": \"error\", \"message\": \"Richiesta non valida (type)\"}");
            return;
        }
        String categoria="";
        String connectionType="";
        String socket="";
        String pcie="";
        String memFrequence="";
        String tipologia="";
        String colore="";
        boolean led=false;
        boolean rgb=false;
        double lunghezza=0;
        double larghezza=0;
        double peso=0;
        double altezza=0;
        int capacita=0;
        int nVentole=0;
        int maxRPM=0;
        int tdp=0;
        try {
            if(piece.equals("accessorio")) {
                switch (type) {
                    case "headset":
                        categoria=requestCategoria(request,response);
                        temp=request.getParameter("microfono");
                        if(temp==null || temp.isEmpty()) {
                            response.getWriter().write("{\"status\": \"error\", \"message\": \"Microfono vuoto\"}");
                            return;
                        }
                        boolean microfono=Boolean.parseBoolean(temp);
                        connectionType=requestConnectionType(request,response);
                        led=requestLED(request,response);
                        HeadSetDAO headSetDAO = new HeadSetDAO();
                        HeadSet headSet=new HeadSet(id,marca,modello,prezzo,disponibilita,sconto,categoria,microfono,connectionType,led);
                        if(isNew) {
                            headSetDAO.newHeadset(headSet);
                            uploadFoto(id,request);
                        }
                        else headSetDAO.update(headSet);
                        response.getWriter().write("{\"status\": \"success\"}");
                        return;
                    case "monitor":
                        int dimensione=0;
                        try {
                            dimensione=Integer.parseInt(request.getParameter("dimensione"));
                        } catch (NumberFormatException e) {
                            response.getWriter().write("{\"status\": \"error\", \"message\": \"Dimensione vuota o non valida\"}");
                            return;
                        }
                        String risoluzione=request.getParameter("risoluzione");
                        if(risoluzione==null || risoluzione.isEmpty()) {
                            response.getWriter().write("{\"status\": \"error\", \"message\": \"Risoluzione vuoto\"}");
                            return;
                        }
                        String aspectRatio=request.getParameter("aspectRatio");
                        if(aspectRatio==null || aspectRatio.isEmpty()) {
                            response.getWriter().write("{\"status\": \"error\", \"message\": \"AspectRatio vuoto\"}");
                            return;
                        }
                        String tipo=request.getParameter("tipo");
                        if(tipo==null || tipo.isEmpty()) {
                            response.getWriter().write("{\"status\": \"error\", \"message\": \"Tipo vuoto\"}");
                            return;
                        }
                        double responseTime=0;
                        try {
                            responseTime=Double.parseDouble(request.getParameter("responseTime"));
                        } catch (NumberFormatException e) {
                            response.getWriter().write("{\"status\": \"error\", \"message\": \"responseTime vuoto\"}");
                            return;
                        }
                        int frequenza=0;
                        try {
                            frequenza=Integer.parseInt(request.getParameter("frequenza"));
                        } catch (NumberFormatException e) {
                            response.getWriter().write("{\"status\": \"error\", \"message\": \"Frequenza vuoto\"}");
                            return;
                        }
                        boolean hdr=false;
                        try {
                            hdr=Boolean.parseBoolean(request.getParameter("hdr"));
                        } catch (NumberFormatException e) {
                            response.getWriter().write("{\"status\": \"error\", \"message\": \"HDR vuoto o non valido\"}");
                            return;
                        }
                        boolean casse=false;
                        try {
                            casse=Boolean.parseBoolean(request.getParameter("casse"));
                        } catch (NumberFormatException e) {
                            response.getWriter().write("{\"status\": \"error\", \"message\": \"Casse vuoto o non valido\"}");
                            return;
                        }
                        MonitorDAO monitorDAO = new MonitorDAO();
                        Monitor monitor = new Monitor(id,marca,modello,prezzo,disponibilita,sconto,dimensione,risoluzione,aspectRatio,tipo,responseTime,frequenza,hdr,casse);
                        if(isNew) {
                            monitorDAO.newMonitor(monitor);
                            uploadFoto(id,request);
                        }
                        else monitorDAO.update(monitor);
                        response.getWriter().write("{\"status\": \"success\"}");
                        return;
                    case "mouse":
                        categoria=requestCategoria(request,response);
                        connectionType=requestConnectionType(request,response);
                        String forma=request.getParameter("forma");
                        if(forma==null || forma.isEmpty()) {
                            response.getWriter().write("{\"status\": \"error\", \"message\": \"Forma vuota\"}");
                            return;
                        }
                        String sensore=request.getParameter("sensore");
                        if(sensore==null || sensore.isEmpty()) {
                            response.getWriter().write("{\"status\": \"error\", \"message\": \"Sensore vuoto\"}");
                            return;
                        }
                        int dpi=0;
                        try {
                            dpi=Integer.parseInt(request.getParameter("dpi"));
                        } catch (NumberFormatException e) {
                            response.getWriter().write("{\"status\": \"error\", \"message\": \"DPI vuoto\"}");
                            return;
                        }
                        peso=requestPeso(request,response);
                        led=requestLED(request,response);
                        MouseDAO mouseDAO = new MouseDAO();
                        Mouse mouse=new Mouse(id,marca,modello,prezzo,disponibilita,sconto,categoria,connectionType,forma,sensore,dpi,peso,led);
                        if(isNew) {
                            mouseDAO.newMouse(mouse);
                            uploadFoto(id,request);
                        }
                        else mouseDAO.update(mouse);
                        response.getWriter().write("{\"status\": \"success\"}");
                        return;
                    case "streamdeck":
                        int nTasti=0;
                        try {
                            nTasti=Integer.parseInt(request.getParameter("nTasti"));
                        } catch (NumberFormatException e) {
                            response.getWriter().write("{\"status\": \"error\", \"message\": \"Numero tasti vuoto o non valido\"}");
                            return;
                        }
                        String tipoTasti=request.getParameter("tipoTasti");
                        if(tipoTasti==null || tipoTasti.isEmpty()) {
                            response.getWriter().write("{\"status\": \"error\", \"message\": \"Tipo tasti vuoto\"}");
                            return;
                        }
                        connectionType=requestConnectionType(request,response);
                        lunghezza=requestLunghezza(request,response);
                        larghezza=requestLarghezza(request,response);
                        List<String> tipiTastiList = java.util.List.of(tipoTasti.split(","));
                        StreamDeckDAO streamDeckDAO = new StreamDeckDAO();
                        StreamDeck streamDeck=new StreamDeck(id,marca,modello,prezzo,disponibilita,sconto,nTasti,tipiTastiList,connectionType,lunghezza,larghezza);
                        if(isNew) {
                            streamDeckDAO.newStreamDeck(streamDeck);
                            uploadFoto(id,request);
                        }
                        else streamDeckDAO.update(streamDeck);
                        response.getWriter().write("{\"status\": \"success\"}");
                        return;
                    case "tappetino":
                        led=requestLED(request,response);
                        lunghezza=requestLunghezza(request,response);
                        larghezza=requestLarghezza(request,response);
                        TappetinoDAO tappetinoDAO = new TappetinoDAO();
                        Tappetino tappetino=new Tappetino(id,marca,modello,prezzo,disponibilita,sconto,led,lunghezza,larghezza);
                        if(isNew) {
                            tappetinoDAO.newTappetino(tappetino);
                            uploadFoto(id,request);
                        }
                        else tappetinoDAO.update(tappetino);
                        response.getWriter().write("{\"status\": \"success\"}");
                        return;
                    case "tastiera":
                        categoria=requestCategoria(request,response);
                        String layout=request.getParameter("layout");
                        if(layout==null || layout.isEmpty()) {
                            response.getWriter().write("{\"status\": \"error\", \"message\": \"Layout vuoto\"}");
                            return;
                        }
                        boolean compatta=false;
                        try {
                            compatta=Boolean.parseBoolean(request.getParameter("compatta"));
                        } catch (NumberFormatException e) {
                            response.getWriter().write("{\"status\": \"error\", \"message\": \"Compatta vuota o non valida\"}");
                            return;
                        }
                        led=requestLED(request,response);
                        String connettivita=request.getParameter("connettivita");
                        if(connettivita==null || connettivita.isEmpty()) {
                            response.getWriter().write("{\"status\": \"error\", \"message\": \"Connettività vuota\"}");
                            return;
                        }
                        larghezza=requestLarghezza(request,response);
                        lunghezza=requestLunghezza(request,response);
                        peso=requestPeso(request,response);
                        TastieraDAO tastieraDAO = new TastieraDAO();
                        Tastiera tastiera=new Tastiera(id,marca,modello,prezzo,disponibilita,sconto,categoria,layout,compatta,led,connettivita,larghezza,lunghezza,peso);
                        if(isNew) {
                            tastieraDAO.newTastiera(tastiera);
                            uploadFoto(id,request);
                        }
                        else tastieraDAO.update(tastiera);
                        response.getWriter().write("{\"status\": \"success\"}");
                        return;
                    default:
                        response.sendError(405);
                        return;
                }
            }
            else if(piece.equals("pezzo")) {
                switch (type) {
                    case "cpu":
                        String famiglia=request.getParameter("famiglia");
                        if(famiglia==null || famiglia.isEmpty()) {
                            response.getWriter().write("{\"status\": \"error\", \"message\": \"Famiglia vuota\"}");
                            return;
                        }
                        String generazione=request.getParameter("generazione");
                        if(generazione==null || generazione.isEmpty()) {
                            response.getWriter().write("{\"status\": \"error\", \"message\": \"Generazione vuota\"}");
                            return;
                        }
                        int nCore=0;
                        try {
                            nCore=Integer.parseInt(request.getParameter("nCore"));
                        } catch (NumberFormatException e) {
                            response.getWriter().write("{\"status\": \"error\", \"message\": \"nCore vuoto o non valido\"}");
                            return;
                        }
                        int nThreads=0;
                        try {
                            nThreads=Integer.parseInt(request.getParameter("nThreads"));
                        } catch (NumberFormatException e) {
                            response.getWriter().write("{\"status\": \"error\", \"message\": \"nThreads vuoto o non valido\"}");
                            return;
                        }
                        float baseFrequence=0;
                        try {
                            baseFrequence=Float.parseFloat(request.getParameter("baseFrequence"));
                        } catch (NumberFormatException e) {
                            response.getWriter().write("{\"status\": \"error\", \"message\": \"baseFrequence vuoto o non valido\"}");
                            return;
                        }
                        float turboFrequence=0;
                        try {
                            turboFrequence=Float.parseFloat(request.getParameter("turboFrequence"));
                        } catch (NumberFormatException e) {
                            response.getWriter().write("{\"status\": \"error\", \"message\": \"turboFrequence vuoto o non valido\"}");
                            return;
                        }
                        int TDP=0;
                        try {
                            TDP=Integer.parseInt(request.getParameter("TDP"));
                        } catch (NumberFormatException e) {
                            response.getWriter().write("{\"status\": \"error\", \"message\": \"TDP vuoto o non valido\"}");
                            return;
                        }
                        String litografia=request.getParameter("litografia");
                        if(litografia==null || litografia.isEmpty()) {
                            response.getWriter().write("{\"status\": \"error\", \"message\": \"Litografia vuota\"}");
                            return;
                        }
                        socket=requestSocket(request,response);
                        String memSup=request.getParameter("memSup");
                        if(memSup==null || memSup.isEmpty()) {
                            response.getWriter().write("{\"status\": \"error\", \"message\": \"memSup vuota\"}");
                            return;
                        }
                        memFrequence=requestMemFrequence(request,response);
                        String PCIE=request.getParameter("PCIE");
                        if(PCIE==null || PCIE.isEmpty()) {
                            response.getWriter().write("{\"status\": \"error\", \"message\": \"PCIE vuota\"}");
                            return;
                        }
                        CPUDAO cpuDAO = new CPUDAO();
                        CPU cpu=new CPU(id,marca,modello,prezzo,disponibilita,sconto,famiglia,generazione,nCore,nThreads,baseFrequence,turboFrequence,TDP,litografia,socket,memSup,memFrequence,PCIE);
                        if(isNew) {
                            cpuDAO.newCPU(cpu);
                            uploadFoto(id,request);
                        }
                        else cpuDAO.update(cpu);
                        response.getWriter().write("{\"status\": \"success\"}");
                        return;
                    case "gpu":
                        String produttore=request.getParameter("produttore");
                        if(produttore==null || produttore.isEmpty()) {
                            response.getWriter().write("{\"status\": \"error\", \"message\": \"Produttore vuoto\"}");
                            return;
                        }
                        int VRAM=0;
                        try {
                            VRAM=Integer.parseInt(request.getParameter("VRAM"));
                        } catch (NumberFormatException e) {
                            response.getWriter().write("{\"status\": \"error\", \"message\": \"VRAM vuota o non valida\"}");
                            return;
                        }
                        String VRAMtype=request.getParameter("VRAMtype");
                        if(VRAMtype==null || VRAMtype.isEmpty()) {
                            response.getWriter().write("{\"status\": \"error\", \"message\": \"VRAMtype vuota\"}");
                            return;
                        }
                        pcie=requestpcie(request,response);
                        boolean overclock=false;
                        try {
                            overclock=Boolean.parseBoolean(request.getParameter("overclock"));
                        } catch (NumberFormatException e) {
                            response.getWriter().write("{\"status\": \"error\", \"message\": \"Overclock vuoto o non valido\"}");
                            return;
                        }
                        int watt=0;
                        try {
                            watt=Integer.parseInt(request.getParameter("watt"));
                        } catch (NumberFormatException e) {
                            response.getWriter().write("{\"status\": \"error\", \"message\": \"watt vuoto o non valido\"}");
                            return;
                        }
                        peso=requestPeso(request,response);
                        memFrequence=requestMemFrequence(request,response);
                        GPUDAO gpuDAO = new GPUDAO();
                        GPU gpu=new GPU(id,marca,modello,prezzo,disponibilita,sconto,produttore,VRAM,VRAMtype,pcie,overclock,watt,peso,memFrequence);
                        if(isNew) {
                            gpuDAO.newGPU(gpu);
                            uploadFoto(id,request);
                        }
                        else gpuDAO.update(gpu);
                        response.getWriter().write("{\"status\": \"success\"}");
                        return;
                    case "ram":
                        capacita=requestCapacita(request,response);
                        categoria=requestCategoria(request,response);
                        int frequenza=0;
                        try {
                            frequenza=Integer.parseInt(request.getParameter("frequenza"));
                        } catch (NumberFormatException e) {
                            response.getWriter().write("{\"status\": \"error\", \"message\": \"Frequenza vuota o non valida\"}");
                            return;
                        }
                        tipologia=requestTipologia(request,response);
                        if(tipologia==null || tipologia.isEmpty()) {
                            response.getWriter().write("{\"status\": \"error\", \"message\": \"Tipologia vuota\"}");
                            return;
                        }
                        RAMDAO ramDAO = new RAMDAO();
                        RAM ram=new RAM(id,marca,modello,prezzo,disponibilita,sconto,capacita,categoria,frequenza,tipologia);
                        if(isNew) {
                            ramDAO.newRAM(ram);
                            uploadFoto(id,request);
                        }
                        else ramDAO.update(ram);
                        response.getWriter().write("{\"status\": \"success\"}");
                        return;
                    case "psu":
                        categoria=requestCategoria(request,response);
                        int potenza=0;
                        try {
                            potenza=Integer.parseInt(request.getParameter("potenza"));
                        } catch (NumberFormatException e) {
                            response.getWriter().write("{\"status\": \"error\", \"message\": \"Potenza vuota o non valida\"}");
                            return;
                        }
                        String certificazione=request.getParameter("certificazione");
                        if(certificazione==null || certificazione.isEmpty()) {
                            response.getWriter().write("{\"status\": \"error\", \"message\": \"Certificazione vuota\"}");
                            return;
                        }
                        boolean modularita=false;
                        try {
                            modularita=Boolean.parseBoolean(request.getParameter("modularita"));
                        } catch (NumberFormatException e) {
                            response.getWriter().write("{\"status\": \"error\", \"message\": \"Modularità vuota o non valida\"}");
                            return;
                        }
                        peso=requestPeso(request,response);
                        PSUDAO psuDAO = new PSUDAO();
                        PSU psu=new PSU(id,marca,modello,prezzo,disponibilita,sconto,categoria,potenza,certificazione,modularita,peso);
                        if(isNew) {
                            psuDAO.newPSU(psu);
                            uploadFoto(id,request);
                        }
                        else psuDAO.update(psu);
                        response.getWriter().write("{\"status\": \"success\"}");
                        return;
                    case "motherboard":
                        socket=requestSocket(request,response);
                        categoria=requestCategoria(request,response);
                        String tipo_ram=request.getParameter("tipo_ram");
                        if(tipo_ram==null || tipo_ram.isEmpty()) {
                            response.getWriter().write("{\"status\": \"error\", \"message\": \"TipoRam vuota\"}");
                            return;
                        }
                        int nSlot=0;
                        try {
                            nSlot=Integer.parseInt(request.getParameter("nSlot"));
                        } catch (NumberFormatException e) {
                            response.getWriter().write("{\"status\": \"error\", \"message\": \"nSlot vuoto o non valido\"}");
                            return;
                        }
                        int capacitaRAM=0;
                        try {
                            capacitaRAM=Integer.parseInt(request.getParameter("capacitaRAM"));
                        } catch (NumberFormatException e) {
                            response.getWriter().write("{\"status\": \"error\", \"message\": \"capacitàRAM vuota o non valida\"}");
                            return;
                        }
                        int nSata=0;
                        try {
                            nSata=Integer.parseInt(request.getParameter("nSata"));
                        } catch (NumberFormatException e) {
                            response.getWriter().write("{\"status\": \"error\", \"message\": \"nSata vuota o non valida\"}");
                            return;
                        }
                        int nM2=0;
                        try {
                            nM2=Integer.parseInt(request.getParameter("nM2"));
                        } catch (NumberFormatException e) {
                            response.getWriter().write("{\"status\": \"error\", \"message\": \"nM2 vuota o non valida\"}");
                            return;
                        }
                        boolean wifi=false;
                        try {
                            wifi=Boolean.parseBoolean(request.getParameter("wifi"));
                        } catch (NumberFormatException e) {
                            response.getWriter().write("{\"status\": \"error\", \"message\": \"wifi vuoto o non valido\"}");
                            return;
                        }
                        pcie=requestpcie(request,response);
                        int nPcie=0;
                        try {
                            nPcie=Integer.parseInt(request.getParameter("nPcie"));
                        } catch (NumberFormatException e) {
                            response.getWriter().write("{\"status\": \"error\", \"message\": \"nPcie vuoto o non valido\"}");
                            return;
                        }
                        MotherboardDAO motherboardDAO = new MotherboardDAO();
                        Motherboard motherboard=new Motherboard(id,marca,modello,prezzo,disponibilita,sconto,socket,categoria,tipo_ram,nSlot,capacitaRAM,nSata,nM2,wifi,pcie,nPcie);
                        if(isNew) {
                            motherboardDAO.newMotherBoard(motherboard);
                            uploadFoto(id,request);
                        }
                        else motherboardDAO.update(motherboard);
                        response.getWriter().write("{\"status\": \"success\"}");
                        return;
                    case "memory":
                        categoria=requestCategoria(request,response);
                        tipologia=requestTipologia(request,response);
                        String interfaccia=request.getParameter("interfaccia");
                        if(interfaccia==null || interfaccia.isEmpty()) {
                            response.getWriter().write("{\"status\": \"error\", \"message\": \"Intefaccia vuota\"}");
                            return;
                        }
                        capacita=requestCapacita(request,response);
                        int readSpeed=0;
                        try {
                            readSpeed=Integer.parseInt(request.getParameter("readSpeed"));
                        } catch (NumberFormatException e) {
                            response.getWriter().write("{\"status\": \"error\", \"message\": \"ReadSpeed vuota o non valida\"}");
                            return;
                        }
                        int writeSpeed=0;
                        try {
                            writeSpeed=Integer.parseInt(request.getParameter("writeSpeed"));
                        } catch (NumberFormatException e) {
                            response.getWriter().write("{\"status\": \"error\", \"message\": \"WriteSpeed vuota o non valida\"}");
                            return;
                        }
                        MemoryDAO memoryDAO = new MemoryDAO();
                        Memory memory=new Memory(id,marca,modello,prezzo,disponibilita,sconto,categoria,tipologia,interfaccia,capacita,readSpeed,writeSpeed);
                        if(isNew) {
                            memoryDAO.newMemory(memory);
                            uploadFoto(id,request);
                        }
                        else memoryDAO.update(memory);
                        response.getWriter().write("{\"status\": \"success\"}");
                        return;
                    case "aircooling":
                        socket=requestSocket(request,response);
                        altezza=requestAltezza(request,response);
                        nVentole=requestnVentole(request,response);
                        int dimVentola=0;
                        try {
                            dimVentola=Integer.parseInt(request.getParameter("dimVentola"));
                        } catch (NumberFormatException e) {
                            response.getWriter().write("{\"status\": \"error\", \"message\": \"dimVentola vuota o non valida\"}");
                            return;
                        }
                        maxRPM=requestmaxRPM(request,response);
                        tdp=requesttdp(request,response);
                        colore=requestColore(request,response);
                        rgb=requestrgb(request,response);
                        AirCoolingDAO airCoolingDAO = new AirCoolingDAO();
                        AirCooling airCooling=new AirCooling(id,marca,modello,prezzo,disponibilita,sconto,socket,altezza,lunghezza,larghezza,nVentole,dimVentola,maxRPM,rgb,tdp,colore);
                        if(isNew) {
                            airCoolingDAO.newAirCooling(airCooling);
                            uploadFoto(id,request);
                        }
                        else airCoolingDAO.update(airCooling);
                        response.getWriter().write("{\"status\": \"success\"}");
                        return;
                    case "liquidcooling":
                        socket=requestSocket(request,response);
                        altezza=requestAltezza(request,response);
                        lunghezza=requestLunghezza(request,response);
                        larghezza=requestLarghezza(request,response);
                        double dimRadiatore=0;
                        try {
                            dimRadiatore=Double.parseDouble(request.getParameter("dimRadiatore"));
                        } catch (NumberFormatException e) {
                            response.getWriter().write("{\"status\": \"error\", \"message\": \"dimRadiatore vuoto o non valido\"}");
                            return;
                        }
                        nVentole=requestnVentole(request,response);
                        maxRPM=requestmaxRPM(request,response);
                        rgb=requestrgb(request,response);
                        tdp=requesttdp(request,response);
                        colore=requestColore(request,response);
                        boolean display=false;
                        try {
                            display=Boolean.parseBoolean(request.getParameter("display"));
                        } catch (NumberFormatException e) {
                            response.getWriter().write("{\"status\": \"error\", \"message\": \"Display vuota o non valida\"}");
                            return;
                        }
                        LiquidCoolingDAO liquidCoolingDAO = new LiquidCoolingDAO();
                        LiquidCooling liquidCooling=new LiquidCooling(id,marca,modello,prezzo,disponibilita,sconto,socket,altezza,lunghezza,larghezza,dimRadiatore,nVentole,maxRPM,rgb,tdp,colore,display);
                        if(isNew) {
                            liquidCoolingDAO.newLiquidCooling(liquidCooling);
                            uploadFoto(id,request);
                        }
                        else liquidCoolingDAO.update(liquidCooling);
                        response.getWriter().write("{\"status\": \"success\"}");
                        return;
                    case "case":
                        categoria=requestCategoria(request,response);
                        altezza=requestAltezza(request,response);
                        larghezza=requestLarghezza(request,response);
                        double profondita=0;
                        try {
                            profondita=Double.parseDouble(request.getParameter("profondita"));
                        } catch (NumberFormatException e) {
                            response.getWriter().write("{\"status\": \"error\", \"message\": \"Profondità vuota o non valida\"}");
                            return;
                        }
                        peso=requestPeso(request,response);
                        String dotazione=request.getParameter("dotazione");
                        if(dotazione==null || dotazione.isEmpty()) {
                            response.getWriter().write("{\"status\": \"error\", \"message\": \"Dotazione vuota\"}");
                            return;
                        }
                        CaseDAO caseDAO = new CaseDAO();
                        Case case2=new Case(id,marca,modello,prezzo,disponibilita,sconto,categoria,altezza,larghezza,profondita,peso,dotazione);
                        if(isNew) {
                            caseDAO.newCase(case2);
                            uploadFoto(id,request);
                        }
                        else caseDAO.update(case2);
                        response.getWriter().write("{\"status\": \"success\"}");
                        return;
                    default:
                        response.sendError(405);
                        return;
                }
            }
            else if(piece.equals("prebuilt")) {
                int RAM=0;
                try {
                    RAM=Integer.parseInt(request.getParameter("RAM"));
                } catch (NumberFormatException e) {
                    response.getWriter().write("{\"status\": \"error\", \"message\": \"RAM vuota o non valida\"}");
                    return;
                }
                int memory=0;
                try {
                    memory=Integer.parseInt(request.getParameter("memory"));
                } catch (NumberFormatException e) {
                    response.getWriter().write("{\"status\": \"error\", \"message\": \"Memory vuota o non valida\"}");
                    return;
                }
                String CPU=request.getParameter("CPU");
                if(CPU==null || CPU.isEmpty()) {
                    response.getWriter().write("{\"status\": \"error\", \"message\": \"CPU vuota\"}");
                    return;
                }
                String GPU=request.getParameter("GPU");
                if(GPU==null || GPU.isEmpty()) {
                    response.getWriter().write("{\"status\": \"error\", \"message\": \"GPU vuota\"}");
                    return;
                }
                String descrizione=request.getParameter("descrizione");
                if(descrizione==null || descrizione.isEmpty()) {
                    response.getWriter().write("{\"status\": \"error\", \"message\": \"Descrizione vuota\"}");
                    return;
                }
                PreBuiltDAO preDAO = new PreBuiltDAO();
                PreBuilt preBuilt=new PreBuilt(id,marca,modello,prezzo,disponibilita,sconto,descrizione,CPU,GPU,RAM,memory);
                if(isNew) {
                    preDAO.newPrebuilt(preBuilt);
                    uploadFotos(id,request);
                }
                else preDAO.update(preBuilt);
                response.getWriter().write("{\"status\": \"success\"}");
                return;
            }
        } catch (IDAlreadyRegistred e) {
            response.getWriter().write("{\"status\": \"failed\",\"message\": \""+e.getMessage()+"\"}");
            return;
        }
        catch (RequestFailed re) {
            return;
        }
        response.getWriter().write("{\"status\": \"failed\",\"message\": \"Implementazione ancora non effettuata\"}");
    }

    //Qui ci sono tutte le funzioni di controllo per attributi in comune fra 2 o più tipi di prodotti
    public static void uploadFoto(int id, HttpServletRequest request) throws ServletException, IOException {
        FotoDAO fotoDAO = new FotoDAO();
        fotoDAO.removeFoto(id,request.getParameter("category"),request.getParameter("name"),request.getServletContext().getRealPath("/"));
        Part filePart = request.getPart("foto");
        if(filePart != null && filePart.getSize() > 0) {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String extension = "";
            int i = fileName.lastIndexOf('.');
            if (i > 0) {
                extension = fileName.substring(i);
            }
            InputStream fileContent = filePart.getInputStream();
            String path = request.getServletContext().getRealPath("/") + "/media/" + request.getParameter("category") + "/" + request.getParameter("name") + "/" + id + extension;
            Files.copy(fileContent, Paths.get(path), StandardCopyOption.REPLACE_EXISTING);
        }
    }

    public static void uploadFotos(int id, HttpServletRequest request) throws ServletException, IOException {
        String path=request.getServletContext().getRealPath("/")+"/media/PreBuilt/"+id+"/";
        File file=new File(path);
        if(!file.exists()) {
            if(!file.mkdirs()) throw new FolderFotoFailed();
        }
        if(!file.isDirectory()) {
            if(!file.delete()) throw new FolderFotoFailed();
            if(!file.mkdirs()) throw new FolderFotoFailed();
        }
        for(Part part:request.getParts()) {
            if(part.getSize()>0 && part.getSubmittedFileName()!=null) {
                InputStream fileContent = part.getInputStream();
                Files.copy(fileContent, Paths.get(path+part.getSubmittedFileName()), StandardCopyOption.REPLACE_EXISTING);
            }
        }
    }

    public static String requestCategoria(HttpServletRequest request, HttpServletResponse response) throws IOException, RequestFailed {
        String categoria=request.getParameter("categoria");
        if(categoria==null || categoria.isEmpty()) {
            response.getWriter().write("{\"status\": \"error\", \"message\": \"Categoria vuota\"}");
            throw new RequestFailed("categoria");
        }
        return categoria;
    }

    public static String requestConnectionType(HttpServletRequest request, HttpServletResponse response) throws IOException, RequestFailed {
        String connectionType=request.getParameter("connectionType");
        if(connectionType==null || connectionType.isEmpty()) {
            response.getWriter().write("{\"status\": \"error\", \"message\": \"ConnectionType vuota\"}");
            throw new RequestFailed("ConnectionType");
        }
        return connectionType;
    }

    public static Boolean requestLED(HttpServletRequest request, HttpServletResponse response) throws IOException, RequestFailed {
        String led=request.getParameter("led");
        if(led==null || led.isEmpty()) {
            response.getWriter().write("{\"status\": \"error\", \"message\": \"LED vuoto\"}");
            throw new RequestFailed("LED");
        }
        try {
            return Boolean.parseBoolean(led);
        } catch (NumberFormatException e) {
            response.getWriter().write("{\"status\": \"error\", \"message\": \"LED non scritto correttamente\"}");
            throw new RequestFailed("LED");
        }
    }

    public static double requestPeso(HttpServletRequest request, HttpServletResponse response) throws IOException, RequestFailed {
        String peso=request.getParameter("peso");
        if(peso==null || peso.isEmpty()) {
            response.getWriter().write("{\"status\": \"error\", \"message\": \"Peso vuoto\"}");
            throw new RequestFailed("Peso");
        }
        try {
            return Double.parseDouble(peso);
        } catch (NumberFormatException e) {
            response.getWriter().write("{\"status\": \"error\", \"message\": \"Peso non scritto correttamente\"}");
            throw new RequestFailed("Peso");
        }
    }

    public static double requestLunghezza(HttpServletRequest request, HttpServletResponse response) throws IOException, RequestFailed {
        String lunghezza=request.getParameter("lunghezza");
        if(lunghezza==null || lunghezza.isEmpty()) {
            response.getWriter().write("{\"status\": \"error\", \"message\": \"Lunghezza vuota\"}");
            throw new RequestFailed("Lunghezza");
        }
        try {
            return Double.parseDouble(lunghezza);
        } catch (NumberFormatException e) {
            response.getWriter().write("{\"status\": \"error\", \"message\": \"Lunghezza non scritta correttamente\"}");
            throw new RequestFailed("Lunghezza");
        }
    }

    public static double requestLarghezza(HttpServletRequest request, HttpServletResponse response) throws IOException, RequestFailed {
        String larghezza=request.getParameter("larghezza");
        if(larghezza==null || larghezza.isEmpty()) {
            response.getWriter().write("{\"status\": \"error\", \"message\": \"Larghezza vuota\"}");
            throw new RequestFailed("Larghezza");
        }
        try {
            return Double.parseDouble(larghezza);
        } catch (NumberFormatException e) {
            response.getWriter().write("{\"status\": \"error\", \"message\": \"Larghezza non scritta correttamente\"}");
            throw new RequestFailed("Larghezza");
        }
    }

    public static String requestSocket(HttpServletRequest request, HttpServletResponse response) throws IOException, RequestFailed {
        String socket=request.getParameter("socket");
        if(socket==null || socket.isEmpty()) {
            response.getWriter().write("{\"status\": \"error\", \"message\": \"Socket vuota\"}");
            throw new RequestFailed("Socket");
        }
        return socket;
    }

    public static String requestMemFrequence(HttpServletRequest request, HttpServletResponse response) throws IOException, RequestFailed {
        String memFrequence=request.getParameter("memFrequence");
        if(memFrequence==null || memFrequence.isEmpty()) {
            response.getWriter().write("{\"status\": \"error\", \"message\": \"memFrequence vuota\"}");
            throw new RequestFailed("memFrequence");
        }
        return memFrequence;
    }

    public static String requestpcie(HttpServletRequest request, HttpServletResponse response) throws IOException, RequestFailed {
        String pcie=request.getParameter("pcie");
        if(pcie==null || pcie.isEmpty()) {
            response.getWriter().write("{\"status\": \"error\", \"message\": \"pcie vuota\"}");
            throw new RequestFailed("pcie");
        }
        return pcie;
    }

    public static String requestTipologia(HttpServletRequest request, HttpServletResponse response) throws IOException, RequestFailed {
        String tipologia=request.getParameter("tipologia");
        if(tipologia==null || tipologia.isEmpty()) {
            response.getWriter().write("{\"status\": \"error\", \"message\": \"Tipologia vuota\"}");
            throw new RequestFailed("tipologia");
        }
        return tipologia;
    }

    public static int requestCapacita(HttpServletRequest request, HttpServletResponse response) throws IOException, RequestFailed {
        String capacita=request.getParameter("capacita");
        if(capacita==null || capacita.isEmpty()) {
            response.getWriter().write("{\"status\": \"error\", \"message\": \"Capacità vuota\"}");
            throw new RequestFailed("Capacità");
        }
        try {
            return Integer.parseInt(capacita);
        } catch (NumberFormatException e) {
            response.getWriter().write("{\"status\": \"error\", \"message\": \"Capacità non valida\"}");
            throw new RequestFailed("Capacità");
        }
    }

    public static double requestAltezza(HttpServletRequest request, HttpServletResponse response) throws IOException, RequestFailed {
        String altezza=request.getParameter("altezza");
        if(altezza==null || altezza.isEmpty()) {
            response.getWriter().write("{\"status\": \"error\", \"message\": \"Altezza vuota\"}");
            throw new RequestFailed("Capacità");
        }
        try {
            return Double.parseDouble(altezza);
        } catch (NumberFormatException e) {
            response.getWriter().write("{\"status\": \"error\", \"message\": \"Altezza non valida\"}");
            throw new RequestFailed("Altezza");
        }
    }

    public static int requestnVentole(HttpServletRequest request, HttpServletResponse response) throws IOException, RequestFailed {
        String nVentole=request.getParameter("nVentole");
        if(nVentole==null || nVentole.isEmpty()) {
            response.getWriter().write("{\"status\": \"error\", \"message\": \"nVentole vuoto\"}");
            throw new RequestFailed("nVentole");
        }
        try {
            return Integer.parseInt(nVentole);
        } catch (NumberFormatException e) {
            response.getWriter().write("{\"status\": \"error\", \"message\": \"nVentole non valido\"}");
            throw new RequestFailed("nVentole");
        }
    }

    public static int requestmaxRPM(HttpServletRequest request, HttpServletResponse response) throws IOException, RequestFailed {
        String maxRPM=request.getParameter("maxRPM");
        if(maxRPM==null || maxRPM.isEmpty()) {
            response.getWriter().write("{\"status\": \"error\", \"message\": \"maxRPM vuoto\"}");
            throw new RequestFailed("maxRPM");
        }
        try {
            return Integer.parseInt(maxRPM);
        } catch (NumberFormatException e) {
            response.getWriter().write("{\"status\": \"error\", \"message\": \"maxRPM non valido\"}");
            throw new RequestFailed("maxRPM");
        }
    }

    public static int requesttdp(HttpServletRequest request, HttpServletResponse response) throws IOException, RequestFailed {
        String tdp=request.getParameter("tdp");
        if(tdp==null || tdp.isEmpty()) {
            response.getWriter().write("{\"status\": \"error\", \"message\": \"tdp vuota\"}");
            throw new RequestFailed("tdp");
        }
        try {
            return Integer.parseInt(tdp);
        }
        catch (NumberFormatException e) {
            response.getWriter().write("{\"status\": \"error\", \"message\": \"tdp non valido\"}");
            throw new RequestFailed("tdp");
        }
    }

    public static String requestColore(HttpServletRequest request, HttpServletResponse response) throws IOException, RequestFailed {
        String colore=request.getParameter("colore");
        if(colore==null || colore.isEmpty()) {
            response.getWriter().write("{\"status\": \"error\", \"message\": \"colore vuoto\"}");
            throw new RequestFailed("colore");
        }
        return colore;
    }

    public static boolean requestrgb(HttpServletRequest request, HttpServletResponse response) throws IOException, RequestFailed {
        String rgb=request.getParameter("rgb");
        if(rgb==null || rgb.isEmpty()) {
            response.getWriter().write("{\"status\": \"error\", \"message\": \"rgb vuota\"}");
            throw new RequestFailed("rgb");
        }
        try {
            return Boolean.parseBoolean(rgb);
        } catch (NumberFormatException e) {
            response.getWriter().write("{\"status\": \"error\", \"message\": \"rgb non valida\"}");
            throw new RequestFailed("rgb");
        }
    }
}
