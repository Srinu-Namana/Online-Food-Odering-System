package com.food.model;

public class FoodItem {
    private int foodId, restaurantId; private String foodName, description, category, image; private double price; private boolean availability;
    public FoodItem() {}
    public FoodItem(int foodId,int restaurantId,String foodName,String description,String category,double price,String image,boolean availability){
        this.foodId=foodId;this.restaurantId=restaurantId;this.foodName=foodName;this.description=description;this.category=category;this.price=price;this.image=image;this.availability=availability;
    }
    public int getFoodId(){return foodId;} public void setFoodId(int v){foodId=v;}
    public int getRestaurantId(){return restaurantId;} public void setRestaurantId(int v){restaurantId=v;}
    public String getFoodName(){return foodName;} public void setFoodName(String v){foodName=v;}
    public String getDescription(){return description;} public void setDescription(String v){description=v;}
    public String getCategory(){return category;} public void setCategory(String v){category=v;}
    public double getPrice(){return price;} public void setPrice(double v){price=v;}
    public String getImage(){return image;} public void setImage(String v){image=v;}
    public boolean isAvailability(){return availability;} public void setAvailability(boolean v){availability=v;}
}