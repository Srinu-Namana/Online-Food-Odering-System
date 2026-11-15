package com.food.dao;
import com.food.model.*; import com.food.util.DBConnection; import java.sql.*; import java.util.*;
public class OrderDAO {
 public int placeOrder(int userId,String address)throws SQLException{
  Connection c=null; try{
   c=DBConnection.getConnection(); c.setAutoCommit(false);
   int cartId; try(PreparedStatement p=c.prepareStatement("SELECT cart_id FROM cart WHERE user_id=?")){p.setInt(1,userId);try(ResultSet r=p.executeQuery()){if(!r.next())throw new SQLException("Cart not found.");cartId=r.getInt(1);}}
   List<CartItem> items=new ArrayList<>(); double total=0;
   String q="SELECT ci.food_id,ci.quantity,f.price FROM cart_items ci JOIN food_items f ON ci.food_id=f.food_id WHERE ci.cart_id=? AND f.availability=TRUE";
   try(PreparedStatement p=c.prepareStatement(q)){p.setInt(1,cartId);try(ResultSet r=p.executeQuery()){while(r.next()){CartItem i=new CartItem();i.setFoodId(r.getInt(1));i.setQuantity(r.getInt(2));i.setPrice(r.getDouble(3));items.add(i);total+=i.getLineTotal();}}}
   if(items.isEmpty())throw new SQLException("Your cart is empty or contains unavailable items.");
   int orderId; String ins="INSERT INTO orders(user_id,total_amount,status,delivery_address) VALUES(?,?, 'PLACED',?)";
   try(PreparedStatement p=c.prepareStatement(ins,Statement.RETURN_GENERATED_KEYS)){p.setInt(1,userId);p.setDouble(2,total);p.setString(3,address);p.executeUpdate();try(ResultSet r=p.getGeneratedKeys()){if(!r.next())throw new SQLException("Could not create order.");orderId=r.getInt(1);}}
   String ii="INSERT INTO order_items(order_id,food_id,quantity,price) VALUES(?,?,?,?)";
   try(PreparedStatement p=c.prepareStatement(ii)){for(CartItem i:items){p.setInt(1,orderId);p.setInt(2,i.getFoodId());p.setInt(3,i.getQuantity());p.setDouble(4,i.getPrice());p.addBatch();}p.executeBatch();}
   try(PreparedStatement p=c.prepareStatement("DELETE FROM cart_items WHERE cart_id=?")){p.setInt(1,cartId);p.executeUpdate();}
   c.commit(); return orderId;
  }catch(SQLException e){if(c!=null)try{c.rollback();}catch(SQLException ignored){}throw e;}finally{if(c!=null)try{c.setAutoCommit(true);c.close();}catch(SQLException ignored){}}
 }
 public List<Order> getByUser(int userId)throws SQLException{return find("WHERE o.user_id=?",userId);}
 public List<Order> getAll()throws SQLException{return find("",null);}
 private List<Order> find(String where,Integer userId)throws SQLException{
  List<Order> list=new ArrayList<>(); String sql="SELECT o.order_id,o.user_id,o.total_amount,DATE_FORMAT(o.order_date,'%d %b %Y %h:%i %p') order_date,o.status,o.delivery_address,u.name user_name FROM orders o JOIN users u ON o.user_id=u.user_id "+where+" ORDER BY o.order_id DESC";
  try(Connection c=DBConnection.getConnection();PreparedStatement p=c.prepareStatement(sql)){if(userId!=null)p.setInt(1,userId);try(ResultSet r=p.executeQuery()){while(r.next()){Order o=new Order();o.setOrderId(r.getInt("order_id"));o.setUserId(r.getInt("user_id"));o.setTotalAmount(r.getDouble("total_amount"));o.setOrderDate(r.getString("order_date"));o.setStatus(r.getString("status"));o.setDeliveryAddress(r.getString("delivery_address"));o.setUserName(r.getString("user_name"));o.setItems(items(c,o.getOrderId()));list.add(o);}}}return list;
 }
 private List<OrderItem> items(Connection c,int orderId)throws SQLException{
  List<OrderItem> list=new ArrayList<>();String s="SELECT oi.order_item_id,oi.order_id,oi.food_id,oi.quantity,oi.price,f.food_name FROM order_items oi JOIN food_items f ON oi.food_id=f.food_id WHERE oi.order_id=?";
  try(PreparedStatement p=c.prepareStatement(s)){p.setInt(1,orderId);try(ResultSet r=p.executeQuery()){while(r.next()){OrderItem i=new OrderItem();i.setOrderItemId(r.getInt(1));i.setOrderId(r.getInt(2));i.setFoodId(r.getInt(3));i.setQuantity(r.getInt(4));i.setPrice(r.getDouble(5));i.setFoodName(r.getString(6));list.add(i);}}}return list;
 }
 public boolean updateStatus(int orderId,String status)throws SQLException{
  String[] allowed={"PLACED","CONFIRMED","PREPARING","OUT_FOR_DELIVERY","DELIVERED","CANCELLED"};boolean ok=false;for(String s:allowed)if(s.equals(status))ok=true;if(!ok)return false;
  try(Connection c=DBConnection.getConnection();PreparedStatement p=c.prepareStatement("UPDATE orders SET status=? WHERE order_id=?")){p.setString(1,status);p.setInt(2,orderId);return p.executeUpdate()==1;}
 }
}