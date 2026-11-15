package com.food.controller;

import com.food.dao.FoodItemDAO;
import com.food.model.FoodItem;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/UpdateFoodServlet")
public class UpdateFoodServlet extends HttpServlet {
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		if (!ServletUtil.requireAdmin(req, resp))
			return;
		try {
			FoodItem f = new FoodItem();
			f.setFoodId(ServletUtil.intParam(req, "foodId", 0));
			f.setFoodName(req.getParameter("foodName"));
			f.setCategory(req.getParameter("category"));
			f.setPrice(ServletUtil.doubleParam(req, "price", 0));
			f.setImage(req.getParameter("image"));
			f.setDescription(req.getParameter("description"));
			f.setAvailability(req.getParameter("availability") != null);
			new FoodItemDAO().update(f);
			resp.sendRedirect(req.getContextPath() + "/admin/food-list.jsp?updated=1");
		} catch (Exception e) {
			resp.sendRedirect(req.getContextPath() + "/admin/food-list.jsp?error=1");
		}
	}
}
