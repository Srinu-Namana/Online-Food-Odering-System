package com.food.controller;

import com.food.dao.UserDAO;
import com.food.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String name = req.getParameter("name"), email = req.getParameter("email"),
				password = req.getParameter("password"), phone = req.getParameter("phone"),
				address = req.getParameter("address");
		if (blank(name) || blank(email) || blank(password)) {
			resp.sendRedirect("register.jsp?error=required");
			return;
		}
		if (password.length() < 4) {
			resp.sendRedirect("register.jsp?error=password");
			return;
		}
		try {
			UserDAO dao = new UserDAO();
			if (dao.emailExists(email.trim())) {
				resp.sendRedirect("register.jsp?error=exists");
				return;
			}
			dao.register(new User(name.trim(), email.trim(), password, phone, address));
			resp.sendRedirect("login.jsp?registered=1");
		} catch (Exception e) {
			resp.sendRedirect(req.getContextPath() + "/register.jsp?error=db");
		}
	}

	private boolean blank(String s) {
		return s == null || s.trim().isEmpty();
	}
}