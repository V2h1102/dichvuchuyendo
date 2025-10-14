package com.assignment.furniture_moving_service_swp391.controller;

import com.assignment.furniture_moving_service_swp391.dao.UserDAO;
import com.assignment.furniture_moving_service_swp391.model.User;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UserDAO dao = new UserDAO();
        User user = dao.login(email, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            switch (user.getRole()) {
                case "admin":
                    response.sendRedirect("views/admin/dashboard.jsp");
                    break;
                case "staff":
                    response.sendRedirect("views/staff/dashboard.jsp");
                    break;
                default:
                    response.sendRedirect("views/customer/home.jsp");
                    break;
            }
        } else {
            request.setAttribute("error", "Email hoặc mật khẩu không đúng!");
            request.getRequestDispatcher("views/login.jsp").forward(request, response);
        }
    }
}
