package com.food.controller;

import com.food.dao.OrderDAO;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/UpdateOrderStatusServlet")
public class UpdateOrderStatusServlet extends HttpServlet {
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		if (!ServletUtil.requireAdmin(req, resp))
			return;
		try {
			new OrderDAO().updateStatus(ServletUtil.intParam(req, "orderId", 0), req.getParameter("status"));
		} catch (Exception ignored) {
		}
		resp.sendRedirect(req.getContextPath() + "/admin/AdminOrderServlet");
	}
}
