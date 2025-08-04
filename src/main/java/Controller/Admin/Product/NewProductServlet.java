package Controller.Admin.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/newProduct")
@MultipartConfig
public class NewProductServlet extends HttpServlet { //gestisce l'aggiunta di un nuovo prodotto
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UpdateOrAddProductServlet.process(request,response,true);
    }
}
