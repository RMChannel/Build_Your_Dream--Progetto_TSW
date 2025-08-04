package Controller.Builder;

import Model.Builds.Build;
import Model.Carrello.Carrello;
import Model.Carrello.CarrelloDAO;
import Model.Pezzi.Cooling.AirCooling;
import Model.Pezzi.Cooling.LiquidCooling;
import Model.Pezzi.Memory.Memory;
import Model.Pezzi.RAM.RAM;
import Model.Users.User;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/buildToCarrello")
public class BuildToCarrelloServlet extends HttpServlet { // gestisce il trasferimento dalla build al carrello
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
        Build build= (Build) session.getAttribute("build");
        if(build!=null) {
            if(build.getCpu()!=null) {
                carrello.addToChart(build.getCpu());
            }
            if(!build.getRams().isEmpty()) {
                for(RAM r: build.getRams()) {
                    carrello.addToChart(r);
                }
            }
            if(build.getMotherboard()!=null) {
                carrello.addToChart(build.getMotherboard());
            }
            if(build.getGpu()!=null) {
                carrello.addToChart(build.getGpu());
            }
            if(build.getPsu()!=null) {
                carrello.addToChart(build.getPsu());
            }
            if(build.getCase2()!=null) {
                carrello.addToChart(build.getCase2());
            }
            if(!build.getMemories().isEmpty()) {
                for(Memory m: build.getMemories()) {
                    carrello.addToChart(m);
                }
            }
            if(!build.getLiquidCoolings().isEmpty()) {
                for(LiquidCooling l: build.getLiquidCoolings()) {
                    carrello.addToChart(l);
                }
            }
            if(!build.getAirCoolings().isEmpty()) {
                for(AirCooling a: build.getAirCoolings()) {
                    carrello.addToChart(a);
                }
            }
        }
        if(user!=null) carrelloDAO.saveCarrello(carrello,user);
        response.sendRedirect(request.getContextPath()+"/carrello");
    }
}
