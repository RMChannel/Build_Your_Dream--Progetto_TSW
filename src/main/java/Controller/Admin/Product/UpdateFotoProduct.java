package Controller.Admin.Product;

import Foto.FotoDAO;
import Model.Users.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

@WebServlet("/updateFotoProduct")
@MultipartConfig
public class UpdateFotoProduct extends HttpServlet { //gestisce la modifica delle foto
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        User user = (User) request.getSession().getAttribute("user");
        if(user == null || !user.isAdmin()) {
            response.sendError(405);
        }
        String temp=request.getParameter("id");
        int id=Integer.parseInt(temp);
        FotoDAO fotoDAO = new FotoDAO();
        fotoDAO.removeFoto(id,request.getParameter("category"),request.getParameter("name"),request.getServletContext().getRealPath("/"));
        Part filePart = request.getPart("foto");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String extension = "";
        int i = fileName.lastIndexOf('.');
        if (i > 0) {
            extension = fileName.substring(i);
        }
        InputStream fileContent = filePart.getInputStream();
        String path = request.getServletContext().getRealPath("/") + "/media/" + request.getParameter("category") + "/" + request.getParameter("name") + "/" + id + extension;
        Files.copy(fileContent, Paths.get(path), StandardCopyOption.REPLACE_EXISTING);
        response.getWriter().write("{\"status\": \"success\"}");
    }
}
