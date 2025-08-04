package Controller.Builder;

import Model.Builds.BuilderDAO;
import Model.Users.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/cancellaBuild")
public class RemoveBuildServlet extends HttpServlet {// gestisce la rimozione di una build dala pagina utente
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        User user = (User) request.getSession().getAttribute("user");
        String temp=request.getParameter("buildId");
        int buildId=Integer.parseInt(temp);
        BuilderDAO dao = new BuilderDAO();
        dao.removeBuild(buildId,user);
        for(Cookie cookie:request.getCookies()) {
            if(cookie.getName().equals("idBuild") || cookie.getName().equals("name")) {
                Cookie cookie2=new Cookie(cookie.getName(),cookie.getValue());
                cookie2.setMaxAge(0);
                response.addCookie(cookie2);
            }
        }
        response.sendRedirect(request.getContextPath()+"/userPage?option=yourbuilds");
    }
}
