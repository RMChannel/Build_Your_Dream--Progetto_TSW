package Controller.Builder;

import Model.Builds.Build;
import Model.Builds.BuilderDAO;
import Model.Users.User;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/removeFromBuild")
public class RemoveFromBuildServlet extends HttpServlet { // gestisce la rimozione di un pezzo della build
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Build build = (Build) request.getSession().getAttribute("build");
        if(build == null) {
            build = new Build();
        }
        else {
            String type=request.getParameter("type");
            String temp= request.getParameter("id");
            int id= Integer.parseInt(temp);
            switch(type) {
                case "CPU":
                    build.setCpu(null);
                    break;
                case "GPU":
                    build.setGpu(null);
                    break;
                case "RAM":
                    build.removeRam(id);
                    break;
                case "Motherboard":
                    build.setMotherboard(null);
                    break;
                case "PSU":
                    build.setPsu(null);
                    break;
                case "HDD/SSD":
                    build.removeMemory(id);
                    break;
                case "LiquidCooling":
                    build.removeLiquidCooling(id);
                    break;
                case "AirCooling":
                    build.removeAirCooling(id);
                    break;
                case "Case":
                    build.setCase2(null);
                    break;
            }
        }
        User user= (User) request.getSession().getAttribute("user");
        if(user!=null){
            BuilderDAO builderDAO = new BuilderDAO();
            builderDAO.saveBuild(build,user);
        }
        request.getSession().setAttribute("build", build);
        response.sendRedirect(request.getContextPath()+"/builder");
    }
}
