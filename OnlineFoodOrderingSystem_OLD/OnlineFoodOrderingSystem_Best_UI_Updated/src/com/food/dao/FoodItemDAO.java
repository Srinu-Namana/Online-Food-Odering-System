package com.food.dao;
import com.food.model.FoodItem;
import com.food.util.DBConnection;
import java.sql.*; import java.util.*;

public class FoodItemDAO {
    public List<FoodItem> getAll(boolean onlyAvailable) throws SQLException {
        List<FoodItem> list=new ArrayList<>();
        String sql="SELECT food_id,restaurant_id,food_name,description,category,price,image,availability FROM food_items"+
                   (onlyAvailable?" WHERE availability=TRUE":"")+" ORDER BY category,food_name";
        try(Connection c=DBConnection.getConnection(); PreparedStatement ps=c.prepareStatement(sql); ResultSet rs=ps.executeQuery()){
            while(rs.next()) list.add(map(rs));
        } return list;
    }
    public List<FoodItem> getByCategory(String category) throws SQLException {
        if(category==null||category.trim().isEmpty()||category.equalsIgnoreCase("All")) return getAll(true);
        List<FoodItem> list=new ArrayList<>();
        String sql="SELECT food_id,restaurant_id,food_name,description,category,price,image,availability FROM food_items WHERE availability=TRUE AND category=? ORDER BY food_name";
        try(Connection c=DBConnection.getConnection(); PreparedStatement ps=c.prepareStatement(sql)){ps.setString(1,category);try(ResultSet rs=ps.executeQuery()){while(rs.next())list.add(map(rs));}}
        return list;
    }
    public FoodItem findById(int id)throws SQLException{
        try(Connection c=DBConnection.getConnection();PreparedStatement ps=c.prepareStatement("SELECT food_id,restaurant_id,food_name,description,category,price,image,availability FROM food_items WHERE food_id=?")){
            ps.setInt(1,id);try(ResultSet rs=ps.executeQuery()){return rs.next()?map(rs):null;}
        }
    }
    public boolean add(FoodItem f)throws SQLException{
        String sql="INSERT INTO food_items(restaurant_id,food_name,description,category,price,image,availability) VALUES(?,?,?,?,?,?,?)";
        try(Connection c=DBConnection.getConnection();PreparedStatement ps=c.prepareStatement(sql)){ps.setInt(1,f.getRestaurantId());ps.setString(2,f.getFoodName());ps.setString(3,f.getDescription());ps.setString(4,f.getCategory());ps.setDouble(5,f.getPrice());ps.setString(6,f.getImage());ps.setBoolean(7,f.isAvailability());return ps.executeUpdate()==1;}
    }
    public boolean update(FoodItem f)throws SQLException{
        String sql="UPDATE food_items SET food_name=?,description=?,category=?,price=?,image=?,availability=? WHERE food_id=?";
        try(Connection c=DBConnection.getConnection();PreparedStatement ps=c.prepareStatement(sql)){ps.setString(1,f.getFoodName());ps.setString(2,f.getDescription());ps.setString(3,f.getCategory());ps.setDouble(4,f.getPrice());ps.setString(5,f.getImage());ps.setBoolean(6,f.isAvailability());ps.setInt(7,f.getFoodId());return ps.executeUpdate()==1;}
    }
    public boolean delete(int id)throws SQLException{
        try(Connection c=DBConnection.getConnection();PreparedStatement ps=c.prepareStatement("DELETE FROM food_items WHERE food_id=?")){ps.setInt(1,id);return ps.executeUpdate()==1;}
    }
    public boolean setAvailability(int id, boolean available) throws SQLException {
        try (Connection c=DBConnection.getConnection();
             PreparedStatement ps=c.prepareStatement("UPDATE food_items SET availability=? WHERE food_id=?")) {
            ps.setBoolean(1, available);
            ps.setInt(2, id);
            return ps.executeUpdate()==1;
        }
    }

    private FoodItem map(ResultSet r)throws SQLException{return new FoodItem(r.getInt("food_id"),r.getInt("restaurant_id"),r.getString("food_name"),r.getString("description"),r.getString("category"),r.getDouble("price"),r.getString("image"),r.getBoolean("availability"));}
}