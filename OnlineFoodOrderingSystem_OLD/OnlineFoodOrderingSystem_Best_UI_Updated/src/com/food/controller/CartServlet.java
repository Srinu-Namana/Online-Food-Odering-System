package com.food.controller;
import com.food.dao.CartDAO; import jakarta.servlet.*; import jakarta.servlet.annotation.WebServlet; import jakarta.servlet.http.*; import java.io.IOException;
@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet{protected void doGet(HttpServletRequest req,HttpServletResponse resp)throws ServletException,IOException{if(!ServletUtil.requireLogin(req,resp))return;try{req.setAttribute("cart",new CartDAO().getCart(ServletUtil.user(req).getUserId()));req.getRequestDispatcher("/cart.jsp").forward(req,resp);}catch(Exception e){throw new ServletException("Unable to load cart.",e);}}}
