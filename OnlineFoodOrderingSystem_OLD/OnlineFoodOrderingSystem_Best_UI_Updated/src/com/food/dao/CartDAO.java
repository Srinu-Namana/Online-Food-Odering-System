package com.food.dao;
import com.food.model.*; import com.food.util.DBConnection; import java.sql.*; import java.util.*;
public class CartDAO {
 public Cart getCart(int userId)throws SQLException{
  Cart cart=new Cart(); cart.setUserId(userId); ensureCart(userId);
  String sql="SELECT c.cart_id,ci.cart_item_id,ci.food_id,ci.quantity,ci.price,f.food_name,f.image FROM cart c LEFT JOIN cart_items ci ON c.cart_id=ci.cart_id LEFT JOIN food_items f ON ci.food_id=f.food_id WHERE c.user_id=? ORDER BY ci.cart_item_id";
  try(Connection c=DBConnection.getConnection();PreparedStatement p=c.prepareStatement(sql)){p.setInt(1,userId);try(ResultSet r=p.executeQuery()){while(r.next()){if(cart.getCartId()==0)cart.setCartId(r.getInt("cart_id"));if(r.getObject("cart_item_id")!=null){CartItem i=new CartItem(r.getInt("cart_item_id"),r.getInt("cart_id"),r.getInt("food_id"),r.getInt("quantity"),r.getDouble("price"),r.getString("food_name"),r.getString("image"));cart.getItems().add(i);cart.setTotal(cart.getTotal()+i.getLineTotal());}}}}
  return cart;
 }
 private void ensureCart(int userId)throws SQLException{try(Connection c=DBConnection.getConnection();PreparedStatement p=c.prepareStatement("INSERT IGNORE INTO cart(user_id) VALUES(?)")){p.setInt(1,userId);p.executeUpdate();}}
 public void add(int userId,int foodId,int qty)throws SQLException{
  if(qty<1)qty=1; ensureCart(userId);
  FoodItemDAO food=new FoodItemDAO(); FoodItem f=food.findById(foodId); if(f==null||!f.isAvailability())throw new SQLException("Food item is not available.");
  String sql="INSERT INTO cart_items(cart_id,food_id,quantity,price) SELECT cart_id,?,?,? FROM cart WHERE user_id=? ON DUPLICATE KEY UPDATE quantity=quantity+VALUES(quantity), price=VALUES(price)";
  try(Connection c=DBConnection.getConnection();PreparedStatement p=c.prepareStatement(sql)){p.setInt(1,foodId);p.setInt(2,qty);p.setDouble(3,f.getPrice());p.setInt(4,userId);p.executeUpdate();}
 }

 public CartItem getItem(int userId,int cartItemId)throws SQLException{
  String sql="SELECT ci.cart_item_id,ci.cart_id,ci.food_id,ci.quantity,ci.price,f.food_name,f.image FROM cart_items ci JOIN cart c ON ci.cart_id=c.cart_id JOIN food_items f ON ci.food_id=f.food_id WHERE c.user_id=? AND ci.cart_item_id=?";
  try(Connection c=DBConnection.getConnection();PreparedStatement p=c.prepareStatement(sql)){
   p.setInt(1,userId); p.setInt(2,cartItemId);
   try(ResultSet r=p.executeQuery()){
    if(r.next()) return new CartItem(r.getInt("cart_item_id"),r.getInt("cart_id"),r.getInt("food_id"),r.getInt("quantity"),r.getDouble("price"),r.getString("food_name"),r.getString("image"));
   }
  }
  return null;
 }

 public void update(int userId,int cartItemId,int qty)throws SQLException{
  if(qty<=0){remove(userId,cartItemId);return;}
  String sql="UPDATE cart_items ci JOIN cart c ON ci.cart_id=c.cart_id SET ci.quantity=? WHERE ci.cart_item_id=? AND c.user_id=?";
  try(Connection c=DBConnection.getConnection();PreparedStatement p=c.prepareStatement(sql)){p.setInt(1,qty);p.setInt(2,cartItemId);p.setInt(3,userId);p.executeUpdate();}
 }
 public void remove(int userId,int cartItemId)throws SQLException{
  String sql="DELETE ci FROM cart_items ci JOIN cart c ON ci.cart_id=c.cart_id WHERE ci.cart_item_id=? AND c.user_id=?";
  try(Connection c=DBConnection.getConnection();PreparedStatement p=c.prepareStatement(sql)){p.setInt(1,cartItemId);p.setInt(2,userId);p.executeUpdate();}
 }
 public void clear(int userId)throws SQLException{
  String sql="DELETE ci FROM cart_items ci JOIN cart c ON ci.cart_id=c.cart_id WHERE c.user_id=?";
  try(Connection c=DBConnection.getConnection();PreparedStatement p=c.prepareStatement(sql)){p.setInt(1,userId);p.executeUpdate();}
 }
}