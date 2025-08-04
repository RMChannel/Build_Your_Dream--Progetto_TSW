package Controller.Admin.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/updateProduct")
 @MultipartConfig
public class UpdateProductServlet extends HttpServlet { //gestisce la modifica di un prodotto preesistente
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UpdateOrAddProductServlet.process(request,response,false);
    }
}
