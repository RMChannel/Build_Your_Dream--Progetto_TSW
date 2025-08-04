package Controller.User;

import Model.Builds.BuilderDAO;
import Model.Builds.UserBuild;
import Model.Orders.Order;
import Model.Orders.OrderDAO;
import Model.Users.Carte.Carta;
import Model.Users.Carte.CartaDAO;
import Model.Users.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import org.eclipse.tags.shaded.org.apache.xpath.operations.Or;

import java.io.IOException;
import java.util.List;

@WebServlet("/userPage")
public class UserPageServlet extends HttpServlet { //gestisce il menu della pagina utenti
    public void doGet(jakarta.servlet.http.HttpServletRequest request, jakarta.servlet.http.HttpServletResponse response) throws ServletException, IOException {
        User user= (User) request.getSession().getAttribute("user");
        if(user==null) {
            response.sendError(405);
            return;
        }
        String option=request.getParameter("option");
        if(option!=null && option.equals("yourbuilds")) {
            request.setAttribute("option","yourbuilds");
            BuilderDAO builderDAO=new BuilderDAO();
            List<UserBuild> userBuilds=builderDAO.loadAllBuilds(user);
            request.setAttribute("UserBuilds",userBuilds);
            request.getRequestDispatcher("/user/user.jsp").forward(request,response);
        }
        else {
            request.setAttribute("option","yourdata");
            request.getRequestDispatcher("/user/user.jsp").forward(request,response);
        }
    }

    public void doPost(jakarta.servlet.http.HttpServletRequest request, jakarta.servlet.http.HttpServletResponse response) throws ServletException, IOException {
        User user= (User) request.getSession().getAttribute("user");
        if(user==null) {
            response.sendError(405);
            return;
        }
        String option=request.getParameter("option");
        request.setAttribute("option",option);
        if(option.equals("yourcards")) {
            CartaDAO cartaDAO=new CartaDAO();
            List<Carta> carte=cartaDAO.getAllCardsFromUser((User) user);
            request.setAttribute("carte",carte);
        }
        else if(option.equals("yourbuilds")) {
            BuilderDAO builderDAO=new BuilderDAO();
            List<UserBuild> userBuilds=builderDAO.loadAllBuilds(user);
            request.setAttribute("UserBuilds",userBuilds);
        }
        else if(option.equals("yourorders")) {
            OrderDAO orderDAO=new OrderDAO();
            List<Order> orders=orderDAO.getOrdersForUser(user);
            request.setAttribute("orders",orders);
        }
        request.getRequestDispatcher("/user/user.jsp").forward(request,response);
    }
}
