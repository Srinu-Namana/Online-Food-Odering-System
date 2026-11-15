package com.food.controller;
import com.food.dao.OrderDAO; import jakarta.servlet.*; import jakarta.servlet.annotation.WebServlet; import jakarta.servlet.http.*; import java.io.IOException;
@WebServlet("/admin/AdminOrderServlet")
public class AdminOrderServlet extends HttpServlet{protected void doGet(HttpServletRequest req,HttpServletResponse resp)throws ServletException,IOException{if(!ServletUtil.requireAdmin(req,resp))return;try{req.setAttribute("orders",new OrderDAO().getAll());req.getRequestDispatcher("/admin/orders.jsp").forward(req,resp);}catch(Exception e){throw new ServletException("Unable to load orders.",e);}}}
