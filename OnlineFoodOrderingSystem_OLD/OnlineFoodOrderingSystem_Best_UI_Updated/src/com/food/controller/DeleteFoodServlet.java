package com.food.controller;

import com.food.dao.FoodItemDAO;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/DeleteFoodServlet")
public class DeleteFoodServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        if (!ServletUtil.requireAdmin(req, resp)) return;
        int id = ServletUtil.intParam(req, "foodId", 0);
        if (id <= 0) {
            resp.sendRedirect(req.getContextPath() + "/admin/food-list.jsp?error=invalid");
            return;
        }
        try {
            FoodItemDAO dao = new FoodItemDAO();
            if (dao.delete(id)) {
                resp.sendRedirect(req.getContextPath() + "/admin/food-list.jsp?deleted=1");
            } else {
                resp.sendRedirect(req.getContextPath() + "/admin/food-list.jsp?error=notfound");
            }
        } catch (Exception e) {
            try {
                // Preserve historical order/cart records: disable instead of breaking FK references.
                FoodItemDAO dao = new FoodItemDAO();
                dao.setAvailability(id, false);
                resp.sendRedirect(req.getContextPath() + "/admin/food-list.jsp?disabled=1");
            } catch (Exception ignored) {
                resp.sendRedirect(req.getContextPath() + "/admin/food-list.jsp?error=delete");
            }
        }
    }
}
