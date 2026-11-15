package com.food.controller;
import com.food.model.User;
import jakarta.servlet.http.*;
public final class ServletUtil {
 private ServletUtil(){}
 public static User user(HttpServletRequest req){Object o=req.getSession(false)==null?null:req.getSession(false).getAttribute("user");return o instanceof User?(User)o:null;}
 public static boolean requireLogin(HttpServletRequest req,HttpServletResponse resp)throws java.io.IOException{if(user(req)==null){resp.sendRedirect(req.getContextPath()+"/login.jsp?error=login");return false;}return true;}
 public static boolean requireAdmin(HttpServletRequest req,HttpServletResponse resp)throws java.io.IOException{User u=user(req);if(u==null){resp.sendRedirect(req.getContextPath()+"/login.jsp?error=login");return false;}if(!"ADMIN".equals(u.getRole())){resp.sendError(HttpServletResponse.SC_FORBIDDEN,"Admin access required.");return false;}return true;}
 public static int intParam(HttpServletRequest r,String n,int d){try{return Integer.parseInt(r.getParameter(n));}catch(Exception e){return d;}}
 public static double doubleParam(HttpServletRequest r,String n,double d){try{return Double.parseDouble(r.getParameter(n));}catch(Exception e){return d;}}
}