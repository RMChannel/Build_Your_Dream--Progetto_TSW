package Controller.Builder;

import Model.Builds.Build;
import Model.Builds.BuilderDAO;
import Model.Users.User;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Enumeration;

@WebServlet("/saveBuild")
public class SaveBuildServlet extends HttpServlet { // gestisce il salvataggio di una build nella pagina utenti
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        User user= (User) session.getAttribute("user");
        if(user==null) {
            response.getWriter().write("{\"message\":\"Non sei loggato, fai il login o registrati cliccando in alto a destra Login/Registrati\",\"error\":1}");
            return;
        }
        Build build = (Build) session.getAttribute("build");
        if(build.isEmpty()) {
            response.getWriter().write("{\"message\":\"La tua build è vuota, riempila con i pezzi da te desiderati poi potrai salvarla\",\"error\":1}");
            return;
        }
        BuilderDAO dao = new BuilderDAO();
        String nome= request.getParameter("nome");
        String temp="";
        int idBuild= -1;
        for(Cookie cookie : request.getCookies()) { // modifica la build preesistente nel caso di una modifica
            if(cookie.getName().equals("idBuild")) {
                idBuild = Integer.parseInt(cookie.getValue());
            }
            if(cookie.getName().equals("name")) {
                temp= cookie.getValue();
            }
        }
        if(nome.equals(temp)) {
            dao.saveBuild(build,user,nome,idBuild);
        }
        else {
            idBuild= dao.saveBuild(build,user,nome,-1);
        }
        Cookie cookie = new Cookie("name",nome);
        Cookie cookie2 = new Cookie("idBuild",String.valueOf(idBuild));
        response.addCookie(cookie);
        response.addCookie(cookie2);
        response.getWriter().write("{\"message\":\"Build salvata con successo\",\"error\":0}");
    }
}
