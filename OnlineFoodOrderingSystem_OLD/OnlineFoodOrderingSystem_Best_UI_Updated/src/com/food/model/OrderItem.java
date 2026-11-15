package com.food.model;

public class OrderItem {
    private int orderItemId,orderId,foodId,quantity; private double price; private String foodName;
    public int getOrderItemId(){return orderItemId;} public void setOrderItemId(int v){orderItemId=v;}
    public int getOrderId(){return orderId;} public void setOrderId(int v){orderId=v;}
    public int getFoodId(){return foodId;} public void setFoodId(int v){foodId=v;}
    public int getQuantity(){return quantity;} public void setQuantity(int v){quantity=v;}
    public double getPrice(){return price;} public void setPrice(double v){price=v;}
    public String getFoodName(){return foodName;} public void setFoodName(String v){foodName=v;}
    public double getLineTotal(){return price*quantity;}
}