package com.food.model;

public class User {
    private int userId;
    private String name, email, password, phone, address, role;
    public User() {}
    public User(int userId, String name, String email, String password, String phone, String address, String role) {
        this.userId=userId; this.name=name; this.email=email; this.password=password;
        this.phone=phone; this.address=address; this.role=role;
    }
    public User(String name, String email, String password, String phone, String address) {
        this(0,name,email,password,phone,address,"CUSTOMER");
    }
    public int getUserId(){return userId;} public void setUserId(int v){userId=v;}
    public String getName(){return name;} public void setName(String v){name=v;}
    public String getEmail(){return email;} public void setEmail(String v){email=v;}
    public String getPassword(){return password;} public void setPassword(String v){password=v;}
    public String getPhone(){return phone;} public void setPhone(String v){phone=v;}
    public String getAddress(){return address;} public void setAddress(String v){address=v;}
    public String getRole(){return role;} public void setRole(String v){role=v;}
}