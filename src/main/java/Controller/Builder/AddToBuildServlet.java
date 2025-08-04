package Controller.Builder;

import Model.Builds.Build;
import Model.Builds.BuilderDAO;
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
import Model.Users.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/addToBuilder")
public class AddToBuildServlet extends HttpServlet { // serve per aggiungere un pezzo alla build
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BuilderDAO builderDAO = new BuilderDAO();
        HttpSession session=request.getSession();
        User user= (User) session.getAttribute("user");
        Build build=(Build) session.getAttribute("build");
        if(build==null) {
            if(user!=null) {
                build=builderDAO.loadBuild(user);
                if(build==null) {
                    build=new Build();
                }
            }
            else {
                build=new Build();
            }
            session.setAttribute("build",build);
        }
        String type=request.getParameter("type");
        String temp=request.getParameter("ID");
        int id=Integer.parseInt(temp);
        switch(type) {
            case "CPU":
                CPUDAO cpuDAO=new CPUDAO();
                CPU cpu=cpuDAO.getPezzo(id);
                build.setCpu(cpu);
                break;
            case "GPU":
                GPUDAO gpuDAO=new GPUDAO();
                GPU gpu=gpuDAO.getPezzo(id);
                build.setGpu(gpu);
                break;
            case "RAM":
                RAMDAO ramDAO=new RAMDAO();
                RAM ram=ramDAO.getPezzo(id);
                build.addRam(ram);
                break;
            case "Motherboard":
                MotherboardDAO motherboardDAO=new MotherboardDAO();
                Motherboard motherboard=motherboardDAO.getPezzo(id);
                build.setMotherboard(motherboard);
                break;
            case "PSU":
                PSUDAO psuDAO=new PSUDAO();
                PSU psu=psuDAO.getPezzo(id);
                build.setPsu(psu);
                break;
            case "HDD/SSD":
                MemoryDAO memoryDAO=new MemoryDAO();
                Memory memory=memoryDAO.getPezzo(id);
                build.addMemory(memory);
                break;
            case "LiquidCooling":
                LiquidCoolingDAO liquidCoolingDAO=new LiquidCoolingDAO();
                LiquidCooling liquidCooling=liquidCoolingDAO.getPezzo(id);
                build.addLiquidCooling(liquidCooling);
                break;
            case "AirCooling":
                AirCoolingDAO airCoolingDAO=new AirCoolingDAO();
                AirCooling airCooling=airCoolingDAO.getPezzo(id);
                build.addAirCooling(airCooling);
                break;
            case "Case":
                CaseDAO caseDAO=new CaseDAO();
                Case case1=caseDAO.getPezzo(id);
                build.setCase2(case1);
                break;
        }
        request.getSession().setAttribute("build", build);
        if(user!=null) builderDAO.saveBuild(build,user);
        response.sendRedirect(request.getContextPath()+"/builder");
    }
}
