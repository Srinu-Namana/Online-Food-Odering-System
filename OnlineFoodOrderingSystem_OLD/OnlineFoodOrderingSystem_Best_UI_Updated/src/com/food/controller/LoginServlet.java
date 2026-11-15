package com.food.controller;
import com.food.dao.UserDAO; import com.food.model.User; import jakarta.servlet.ServletException; import jakarta.servlet.annotation.WebServlet; import jakarta.servlet.http.*; import java.io.IOException;
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet{
 protected void doPost(HttpServletRequest req,HttpServletResponse resp)throws ServletException,IOException{
  String email=req.getParameter("email"), password=req.getParameter("password");
  if(email==null||email.trim().isEmpty()||password==null||password.isEmpty()){resp.sendRedirect("login.jsp?error=required");return;}
  try{User u=new UserDAO().login(email.trim(),password);if(u==null){resp.sendRedirect("login.jsp?error=invalid");return;}HttpSession old=req.getSession(false);if(old!=null)old.invalidate();HttpSession s=req.getSession(true);s.setAttribute("user",u);if("ADMIN".equals(u.getRole()))resp.sendRedirect(req.getContextPath()+"/admin/admin-dashboard.jsp");else resp.sendRedirect(req.getContextPath()+"/index.jsp");}
  catch(java.sql.SQLException e){ String code=com.food.util.DBConnection.diagnose().getCategory(); resp.sendRedirect(req.getContextPath()+"/login.jsp?error=db&code="+java.net.URLEncoder.encode(code, java.nio.charset.StandardCharsets.UTF_8)); } catch(Exception e){resp.sendRedirect(req.getContextPath()+"/login.jsp?error=server");}
 }
}