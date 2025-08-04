package Controller.Builder;

import Model.Builds.Build;
import Model.Builds.BuilderDAO;
import Model.Users.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/builder")
public class BuilderPageServlet extends HttpServlet { // carica la pagina del builder
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Build build=(Build) request.getSession().getAttribute("build");
        if(build==null) {
            User user= (User) request.getSession().getAttribute("user");
            if(user!=null) {
                BuilderDAO buildDAO=new BuilderDAO();
                build=buildDAO.loadBuild(user);
                if(build==null) {
                    build=new Build();
                    buildDAO.saveBuild(build,user);
                }
            }
            else {
                build=new Build();
            }
            request.getSession().setAttribute("build",build);
        }
        for(Cookie cookie:request.getCookies()) {
            if(cookie.getName().equals("name")) {
                request.setAttribute("buildName",cookie.getValue());
            }
        }
        request.setAttribute("builder",build);
        request.setAttribute("compatibilita",build.isCompatibile());
        request.setAttribute("totaleOriginale",build.getTotale());
        request.setAttribute("totaleScontato",build.getTotaleScontato());
        request.setAttribute("path",getServletContext().getRealPath("/"));
        request.getRequestDispatcher("/builder/builder.jsp").forward(request,response);
    }
}
