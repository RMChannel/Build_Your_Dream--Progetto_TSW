package Controller.Admin;

import Controller.Admin.BloccaSito.BloccaSitoFilter;
import Model.ContactUs.ContactUs;
import Model.ContactUs.ContactUsDAO;
import Model.NewsletterDAO;
import Model.Orders.Order;
import Model.Orders.OrderDAO;
import Model.Users.User;
import Model.Users.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/adminPage")
public class LoginPageServlet extends HttpServlet { //con do get si accede alla pagina home modalità admin
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        User user=(User) request.getSession().getAttribute("user");
        if(user==null || !user.isAdmin()) {
            response.sendError(405);
        }
        else {
            request.setAttribute("isBloccato", BloccaSitoFilter.isSitoBloccato());
            request.getRequestDispatcher("/admin/adminPage.jsp").forward(request,response);
        }
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException { //si occupa del reindirizzamanto alle varie pagine admin
        User user=(User) request.getSession().getAttribute("user");
        if(user==null || !user.isAdmin()) {
            response.sendError(405);
        }
        else {
            String page=request.getParameter("page");
            if(page==null || page.equals("")) {
                request.getRequestDispatcher("/admin/adminPage.jsp").forward(request,response);
            }
            else {
                switch (page) {
                    case "users":
                        UserDAO userDAO=new UserDAO();
                        List<User> users=userDAO.getAllUsers();
                        request.setAttribute("utenti", users);
                        request.getRequestDispatcher("/admin/users/gestioneUtenti.jsp").forward(request,response);
                        break;
                    case "newsletter":
                        NewsletterDAO newsletterDAO=new NewsletterDAO();
                        List<String> emails=newsletterDAO.getAllEmails();
                        request.setAttribute("emails", emails);
                        request.getRequestDispatcher("/admin/NewsLetter/gestioneNewsletter.jsp").forward(request,response);
                        break;
                    case "contactus":
                        ContactUsDAO contactUsDAO=new ContactUsDAO();
                        List<ContactUs> messages=contactUsDAO.getAllModules();
                        request.setAttribute("messages", messages);
                        request.getRequestDispatcher("/admin/ContactUs/contactUs.jsp").forward(request,response);
                        break;
                    case "orders":
                        OrderDAO orderDAO=new OrderDAO();
                        List<Order> orders=orderDAO.getAllOrders();
                        request.setAttribute("orders", orders);
                        request.getRequestDispatcher("/admin/ordini/gestioneOrdini.jsp").forward(request,response);
                        break;
                    default:
                        request.getRequestDispatcher("/admin/adminPage.jsp").forward(request,response);
                        break;
                }
            }
        }
    }
}
