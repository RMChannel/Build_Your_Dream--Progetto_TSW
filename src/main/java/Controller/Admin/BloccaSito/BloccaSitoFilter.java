package Controller.Admin.BloccaSito;

import Model.Users.PasswordNotCorrect;
import Model.Users.User;
import Model.Users.UserDAO;
import Model.Users.UserNotFound;
import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class BloccaSitoFilter implements Filter { //gestisce lo stato del sito
    private static boolean sitoBloccato = false;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        Filter.super.init(filterConfig);
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        User user = (User) req.getSession().getAttribute("user");
        boolean isAdmin=false;
        if(user!=null) isAdmin=user.isAdmin();
        if (sitoBloccato && !isAdmin) { //Se il sito è bloccato e l'utente non è admin
            HttpServletResponse res = (HttpServletResponse) response;
            String uri = req.getRequestURI();
            if (uri.endsWith("login")) { //Se la richiesta è un login
                String username = req.getParameter("username");
                String password = req.getParameter("password");
                UserDAO userDAO = new UserDAO();
                try {
                    user=userDAO.loginUser(username,password); //Tenta il login
                    req.getSession().setAttribute("user", user);
                    res.sendRedirect(req.getContextPath()); //Ripete la richiesta fatta già prima, perché se è admin allora passerà, altrimenti andrà in bloccato.jsp
                    return;
                } catch (PasswordNotCorrect | UserNotFound p) {
                    request.getRequestDispatcher("/bloccato.jsp").forward(request, response);
                    return;
                }
            } //Se la richiesta non è un login viene bloccata e portata alla pagina bloccato.jsp
            request.getRequestDispatcher("/bloccato.jsp").forward(request, response);
            return;
        } //Altrimenti fa passare la richiesta normalmente
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        Filter.super.destroy();
    }

    public static void setSitoBloccato() {
        if(sitoBloccato) sitoBloccato = false;
        else sitoBloccato = true;
    }

    public static boolean isSitoBloccato() {
        return sitoBloccato;
    }
}
