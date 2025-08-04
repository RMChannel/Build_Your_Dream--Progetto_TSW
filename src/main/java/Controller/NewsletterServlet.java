package Controller;

import Database.DB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;

@WebServlet("/newsletter")
public class NewsletterServlet extends HttpServlet { // gestione form newsletter
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        if(!email.matches("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$")) {
            response.sendError(409);
            return;
        }
        if(!(email == null || email.isEmpty())) {
            try {
                Connection conn = DB.getConn();
                PreparedStatement ps = conn.prepareStatement("INSERT INTO Build_Your_Dream.EMAIL_NEWSLETTER VALUES (?)");
                ps.setString(1, email);
                ps.executeUpdate();
            }
            catch (SQLIntegrityConstraintViolationException _){}
            catch (SQLException e) {
                throw new ServletException(e);
            }
        }
    }
}
