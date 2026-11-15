package com.food.controller;
import com.food.dao.CartDAO; import jakarta.servlet.annotation.WebServlet; import jakarta.servlet.http.*; import java.io.IOException;
@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet{protected void doPost(HttpServletRequest req,HttpServletResponse resp)throws IOException{if(!ServletUtil.requireLogin(req,resp))return;int id=ServletUtil.intParam(req,"foodId",0),qty=ServletUtil.intParam(req,"quantity",1);try{if(id<=0)throw new Exception("Invalid food item.");new CartDAO().add(ServletUtil.user(req).getUserId(),id,qty);resp.sendRedirect(req.getContextPath()+"/CartServlet?added=1");}catch(Exception e){resp.sendRedirect(req.getContextPath()+"/FoodListServlet?error=cart");}}}
