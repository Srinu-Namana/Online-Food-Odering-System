package com.food.dao;
import com.food.model.Restaurant; import com.food.util.DBConnection; import java.sql.*;
public class RestaurantDAO {
 public Restaurant getFirst() throws SQLException{
  String s="SELECT restaurant_id,restaurant_name,description,address,phone,image FROM restaurant ORDER BY restaurant_id LIMIT 1";
  try(Connection c=DBConnection.getConnection();PreparedStatement p=c.prepareStatement(s);ResultSet r=p.executeQuery()){if(r.next())return new Restaurant(r.getInt(1),r.getString(2),r.getString(3),r.getString(4),r.getString(5),r.getString(6));}
  return null;
 }
}