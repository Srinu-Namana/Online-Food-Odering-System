package com.food.model;

public class CartItem {
    private int cartItemId, cartId, foodId, quantity; private double price; private String foodName, image;
    public CartItem() {}
    public CartItem(int cartItemId,int cartId,int foodId,int quantity,double price,String foodName,String image){
        this.cartItemId=cartItemId;this.cartId=cartId;this.foodId=foodId;this.quantity=quantity;this.price=price;this.foodName=foodName;this.image=image;
    }
    public int getCartItemId(){return cartItemId;} public void setCartItemId(int v){cartItemId=v;}
    public int getCartId(){return cartId;} public void setCartId(int v){cartId=v;}
    public int getFoodId(){return foodId;} public void setFoodId(int v){foodId=v;}
    public int getQuantity(){return quantity;} public void setQuantity(int v){quantity=v;}
    public double getPrice(){return price;} public void setPrice(double v){price=v;}
    public String getFoodName(){return foodName;} public void setFoodName(String v){foodName=v;}
    public String getImage(){return image;} public void setImage(String v){image=v;}
    public double getLineTotal(){return price*quantity;}
}