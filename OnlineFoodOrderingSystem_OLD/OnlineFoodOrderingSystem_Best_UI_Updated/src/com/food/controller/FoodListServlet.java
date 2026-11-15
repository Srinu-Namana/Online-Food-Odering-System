package com.food.controller;

import com.food.dao.FoodItemDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/FoodListServlet")
public class FoodListServlet extends HttpServlet {
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			String cat = req.getParameter("category");
			req.setAttribute("foods", new FoodItemDAO().getByCategory(cat));
			req.getRequestDispatcher("/menu.jsp").forward(req, resp);
		} catch (Exception e) {
			resp.sendRedirect(req.getContextPath() + "/menu.jsp?error=db");
		}
	}
}
