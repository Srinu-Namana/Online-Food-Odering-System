package com.food.model;

import java.util.ArrayList;
import java.util.List;

public class Order {
    private int orderId,userId; private double totalAmount; private String orderDate,status,deliveryAddress,userName;
    private List<OrderItem> items=new ArrayList<>();
    public int getOrderId(){return orderId;} public void setOrderId(int v){orderId=v;}
    public int getUserId(){return userId;} public void setUserId(int v){userId=v;}
    public double getTotalAmount(){return totalAmount;} public void setTotalAmount(double v){totalAmount=v;}
    public String getOrderDate(){return orderDate;} public void setOrderDate(String v){orderDate=v;}
    public String getStatus(){return status;} public void setStatus(String v){status=v;}
    public String getDeliveryAddress(){return deliveryAddress;} public void setDeliveryAddress(String v){deliveryAddress=v;}
    public String getUserName(){return userName;} public void setUserName(String v){userName=v;}
    public List<OrderItem> getItems(){return items;} public void setItems(List<OrderItem> v){items=v;}
}