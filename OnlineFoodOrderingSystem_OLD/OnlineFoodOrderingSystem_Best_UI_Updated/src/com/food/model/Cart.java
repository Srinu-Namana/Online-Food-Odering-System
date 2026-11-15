package com.food.model;

import java.util.ArrayList;
import java.util.List;

public class Cart {
    private int cartId, userId; private List<CartItem> items = new ArrayList<>(); private double total;
    public int getCartId(){return cartId;} public void setCartId(int v){cartId=v;}
    public int getUserId(){return userId;} public void setUserId(int v){userId=v;}
    public List<CartItem> getItems(){return items;} public void setItems(List<CartItem> v){items=v;}
    public double getTotal(){return total;} public void setTotal(double v){total=v;}
}