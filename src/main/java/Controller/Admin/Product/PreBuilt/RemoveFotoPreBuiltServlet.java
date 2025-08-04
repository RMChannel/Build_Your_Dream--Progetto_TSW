package Controller.Admin.Product.PreBuilt;

import Foto.FotoDAO;
import Model.Users.User;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@MultipartConfig
@WebServlet("/deleteFotoProduct")
public class RemoveFotoPreBuiltServlet extends HttpServlet { //gestice la rimozione della foto di un prebuilt da parte dell'admin
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        User user=(User) request.getSession().getAttribute("user");
        if(user==null || !user.isAdmin()) {
            response.sendError(405);
            return;
        }
        response.setContentType("application/json");
        String imgPath=request.getParameter("imgPath");
        if(imgPath==null || imgPath.isEmpty()) {
            response.getWriter().write("{\"status\": \"error\", \"message\": \"Richiesta non valida\"}");
            return;
        }
        FotoDAO fotoDAO=new FotoDAO();
        try {
            fotoDAO.removeFoto(request.getServletContext().getRealPath("/")+imgPath);
        } catch (Exception e) {
            response.getWriter().write("{\"status\": \"error\", \"message\": \"Errore interno\"}");
            e.printStackTrace();
            return;
        }
        response.getWriter().write("{\"status\": \"success\"}");
    }
}
