package Controller.PreBuilt;

import Foto.FotoDAO;
import Model.PreBuilts.PreBuilt;
import Model.PreBuilts.PreBuiltDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/preBuilt")
public class PreBuiltHomePageServlet extends HttpServlet { // carica la pagina con tutti i prebuilt
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PreBuiltDAO preBuiltDAO=new PreBuiltDAO();
        List<PreBuilt> preBuilts=preBuiltDAO.getAllPreBuilts();
        List<String> marche=preBuiltDAO.getAllMarche();
        List<String> cpus=preBuiltDAO.getAllCpus();
        List<String> gpus=preBuiltDAO.getAllGpus();
        List<Integer> rams=preBuiltDAO.getAllRam();
        List<Integer> disks=preBuiltDAO.getAllDisk();
        request.setAttribute("preBuilts",preBuilts);
        request.setAttribute("marche",marche);
        request.setAttribute("cpus",cpus);
        request.setAttribute("gpus",gpus);
        request.setAttribute("rams",rams);
        request.setAttribute("disks",disks);
        request.setAttribute("path",getServletContext().getRealPath("/"));
        request.getRequestDispatcher("/prebuilt/prebuiltHome.jsp").forward(request,response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String temp=request.getParameter("ID");
        int id=0;
        try {
            id=Integer.parseInt(temp);
        } catch (NumberFormatException e) {
            response.sendError(405);
            return;
        }
        if(id<0) {
            response.sendError(405);
            return;
        }
        PreBuiltDAO preBuiltDAO=new PreBuiltDAO();
        PreBuilt preBuilt=preBuiltDAO.getPrebuiltByID(id);
        FotoDAO fotoDAO=new FotoDAO();
        List<String> foto=fotoDAO.getFotoForPrebuilt(id,request.getSession().getServletContext().getRealPath("/"));
        request.setAttribute("prebuilt",preBuilt); // carica la pagina dedicata al singolo prebuilt
        request.setAttribute("path",getServletContext().getRealPath("/"));
        request.setAttribute("fotos",foto);
        request.getRequestDispatcher("/prebuilt/prebuiltDetailPage.jsp").forward(request,response);
    }
}
