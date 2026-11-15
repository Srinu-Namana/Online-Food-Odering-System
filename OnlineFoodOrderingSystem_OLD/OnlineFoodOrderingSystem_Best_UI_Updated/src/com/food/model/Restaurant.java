package com.food.model;

public class Restaurant {
    private int restaurantId; private String restaurantName, description, address, phone, image;
    public Restaurant() {}
    public Restaurant(int id,String name,String description,String address,String phone,String image){
        this.restaurantId=id;this.restaurantName=name;this.description=description;this.address=address;this.phone=phone;this.image=image;
    }
    public int getRestaurantId(){return restaurantId;} public void setRestaurantId(int v){restaurantId=v;}
    public String getRestaurantName(){return restaurantName;} public void setRestaurantName(String v){restaurantName=v;}
    public String getDescription(){return description;} public void setDescription(String v){description=v;}
    public String getAddress(){return address;} public void setAddress(String v){address=v;}
    public String getPhone(){return phone;} public void setPhone(String v){phone=v;}
    public String getImage(){return image;} public void setImage(String v){image=v;}
}