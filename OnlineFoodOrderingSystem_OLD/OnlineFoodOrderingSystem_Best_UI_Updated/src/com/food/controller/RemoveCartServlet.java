package com.food.controller;

import com.food.dao.CartDAO;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@SuppressWarnings("serial")
@WebServlet("/RemoveCartServlet")
public class RemoveCartServlet extends HttpServlet {
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		if (!ServletUtil.requireLogin(req, resp))
			return;
		try {
			new CartDAO().remove(ServletUtil.user(req).getUserId(), ServletUtil.intParam(req, "cartItemId", 0));
		} catch (Exception ignored) {
		}
		resp.sendRedirect(req.getContextPath() + "/CartServlet?removed=1");
	}
}
