package Controller;

import Database.DB;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

@WebServlet("/getRandomID")
@MultipartConfig
public class RandomServlet extends HttpServlet { // genera l'id randomico per i prodotti
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Random rand = new Random();
        String type=request.getParameter("type"); // controlla se il tipo esiste
        if(type==null || type.isEmpty()) {
            response.sendError(500);
        }
        List<Integer> ids = new ArrayList<Integer>();
        try {
            Connection conn = DB.getConn();
            PreparedStatement ps;
            if (type.equals("accessorio")) { // Salva tutti gli id della tipologia del prodotto richiesto tra accessori, pezzi e prebuilt
                ps=conn.prepareStatement("select ID_ACCESSORIO from Build_Your_Dream.ACCESSORI");
            }
            else if(type.equals("pezzo")) {
                ps=conn.prepareStatement("select ID_PEZZO from Build_Your_Dream.PEZZI");
            }
            else {
                ps=conn.prepareStatement("select Id_prodotto from Build_Your_Dream.PREBUILT");
            }
            ResultSet rs=ps.executeQuery();
            while(rs.next()) {
                ids.add(rs.getInt(1));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            throw new RuntimeException();
        }
        int id;
        do {
            id=rand.nextInt(999999);
        } while (ids.contains(id));
        response.setContentType("application/json");
        response.getWriter().write("{\"id\": "+id+"}");
    }
}
