package Controller.Admin.Product.PreBuilt;

import Model.Users.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

@MultipartConfig
@WebServlet("/addFotoToPrebuilt")
public class AddFotoPreBuiltServlet extends HttpServlet { //gestisce l'aggiunta delle foto ad un prebuilt da parte dell'admin
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        User user=(User) request.getSession().getAttribute("user");
        if(user==null || !user.isAdmin()) {
            response.sendError(405);
            return;
        }
        int id=0;
        try {
            id=Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            response.getWriter().write("{\"status\": \"error\", \"message\": \"Richiesta non valida\"}");
            return;
        }
        response.setContentType("application/json");
        String path=request.getServletContext().getRealPath("/")+"/media/PreBuilt/"+id+"/";
        File file=new File(path);
        if(!file.exists()) {
            if(!file.mkdirs()) {
                response.getWriter().write("{\"status\": \"error\", \"message\": \"Errore nella creazione della cartella\"}");
                return;
            }
        }
        if(!file.isDirectory()) {
            if(!file.delete()) {
                response.getWriter().write("{\"status\": \"error\", \"message\": \"Errore nell'eliminazione del file preesistente\"}");
                return;
            }
            if(!file.mkdirs()) {
                response.getWriter().write("{\"status\": \"error\", \"message\": \"Errore nella creazione della cartella\"}");
                return;
            }
        }
        for(Part part:request.getParts()) {
            if(part.getSize()>0 && part.getSubmittedFileName()!=null) {
                InputStream fileContent = part.getInputStream();
                Files.copy(fileContent, Paths.get(path+part.getSubmittedFileName()), StandardCopyOption.REPLACE_EXISTING);
            }
        }
        response.getWriter().write("{\"status\": \"success\"}");
    }
}
