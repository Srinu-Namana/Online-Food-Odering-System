package com.food.dao;
import com.food.model.User;
import com.food.util.DBConnection;
import java.sql.*;

public class UserDAO {
    public User login(String email,String password) throws SQLException {
        String sql="SELECT user_id,name,email,password,phone,address,role FROM users WHERE email=? AND password=?";
        try(Connection c=DBConnection.getConnection(); PreparedStatement ps=c.prepareStatement(sql)){
            ps.setString(1,email); ps.setString(2,password);
            try(ResultSet rs=ps.executeQuery()){ return rs.next()?map(rs):null; }
        }
    }
    public boolean register(User u) throws SQLException {
        String sql="INSERT INTO users(name,email,password,phone,address,role) VALUES(?,?,?,?,?,'CUSTOMER')";
        try(Connection c=DBConnection.getConnection(); PreparedStatement ps=c.prepareStatement(sql)){
            ps.setString(1,u.getName()); ps.setString(2,u.getEmail()); ps.setString(3,u.getPassword());
            ps.setString(4,u.getPhone()); ps.setString(5,u.getAddress()); return ps.executeUpdate()==1;
        }
    }
    public boolean emailExists(String email) throws SQLException {
        try(Connection c=DBConnection.getConnection(); PreparedStatement ps=c.prepareStatement("SELECT 1 FROM users WHERE email=?")){
            ps.setString(1,email); try(ResultSet rs=ps.executeQuery()){return rs.next();}
        }
    }
    private User map(ResultSet r)throws SQLException{return new User(r.getInt("user_id"),r.getString("name"),r.getString("email"),r.getString("password"),r.getString("phone"),r.getString("address"),r.getString("role"));}
}