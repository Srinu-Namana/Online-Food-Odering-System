package com.food.controller;

import com.food.dao.CartDAO;
import com.food.model.CartItem;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/UpdateCartServlet")
public class UpdateCartServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        if (!ServletUtil.requireLogin(req, resp)) return;
        try {
            int cartItemId = ServletUtil.intParam(req, "cartItemId", 0);
            CartItem item = new CartDAO().getItem(ServletUtil.user(req).getUserId(), cartItemId);
            if (item == null) {
                resp.sendRedirect(req.getContextPath() + "/CartServlet");
                return;
            }
            req.setAttribute("item", item);
            req.getRequestDispatcher("/update-cart.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException("Unable to open cart update page.", e);
        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        if (!ServletUtil.requireLogin(req, resp)) return;
        try {
            int cartItemId = ServletUtil.intParam(req, "cartItemId", 0);
            int quantity = ServletUtil.intParam(req, "quantity", 1);
            new CartDAO().update(ServletUtil.user(req).getUserId(), cartItemId, quantity);
            resp.sendRedirect(req.getContextPath() + "/CartServlet?updated=1");
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/CartServlet?error=update");
        }
    }
}
