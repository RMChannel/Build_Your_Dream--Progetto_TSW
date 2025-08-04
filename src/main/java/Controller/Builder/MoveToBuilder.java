package Controller.Builder;

import Model.Builds.Build;
import Model.Builds.BuilderDAO;
import Model.Builds.UserBuild;
import Model.Users.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/MoveToBuilder")
public class MoveToBuilder extends HttpServlet { // gestisce il caricamento della build dal database dell'utente
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        String temp=request.getParameter("buildId");
        int buildId=Integer.parseInt(temp);
        BuilderDAO dao = new BuilderDAO();
        UserBuild build = dao.loadBuild(user, buildId);
        Cookie cookie = new Cookie("idBuild", String.valueOf(buildId));
        Cookie cookie2 = new Cookie("name",build.getNome());
        response.addCookie(cookie);
        response.addCookie(cookie2);
        request.getSession().setAttribute("build", build);
        response.sendRedirect(request.getContextPath()+"/builder");
    }
}
