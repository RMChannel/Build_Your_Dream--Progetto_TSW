package Controller.Builder;

import Model.Builds.Build;
import Model.Builds.BuilderDAO;
import Model.Users.User;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/removeAllFromBuild")
public class RemoveAllFromBuildServlet extends HttpServlet { // cancella tutte le build presenti nell'area utente
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Build build = new Build();
        request.getSession().setAttribute("build", build);
        User user= (User) request.getSession().getAttribute("user");
        if(user!=null){
            BuilderDAO builderDAO = new BuilderDAO();
            builderDAO.saveBuild(build,user);
        }
        response.sendRedirect(request.getContextPath()+"/builder");
    }
}
