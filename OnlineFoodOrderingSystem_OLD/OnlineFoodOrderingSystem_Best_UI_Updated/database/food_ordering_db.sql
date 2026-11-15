-- ============================================================
-- ONLINE FOOD ORDERING SYSTEM
-- Clean MySQL setup for Eclipse/Tomcat project
-- ============================================================
DROP DATABASE IF EXISTS food_ordering_db;
CREATE DATABASE food_ordering_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE food_ordering_db;

CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(30),
    address VARCHAR(255),
    role VARCHAR(20) NOT NULL DEFAULT 'CUSTOMER'
);

CREATE TABLE restaurant (
    restaurant_id INT PRIMARY KEY AUTO_INCREMENT,
    restaurant_name VARCHAR(120) NOT NULL,
    description VARCHAR(500),
    address VARCHAR(255),
    phone VARCHAR(30),
    image VARCHAR(255)
);

CREATE TABLE food_items (
    food_id INT PRIMARY KEY AUTO_INCREMENT,
    restaurant_id INT NOT NULL,
    food_name VARCHAR(150) NOT NULL,
    description VARCHAR(500),
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    image VARCHAR(255),
    availability BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT fk_food_restaurant
        FOREIGN KEY (restaurant_id) REFERENCES restaurant(restaurant_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE cart (
    cart_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL UNIQUE,
    CONSTRAINT fk_cart_user
        FOREIGN KEY (user_id) REFERENCES users(user_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE cart_items (
    cart_item_id INT PRIMARY KEY AUTO_INCREMENT,
    cart_id INT NOT NULL,
    food_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    price DECIMAL(10,2) NOT NULL,
    UNIQUE KEY uk_cart_food (cart_id, food_id),
    CONSTRAINT fk_cartitem_cart
        FOREIGN KEY (cart_id) REFERENCES cart(cart_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_cartitem_food
        FOREIGN KEY (food_id) REFERENCES food_items(food_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(30) NOT NULL DEFAULT 'PLACED',
    delivery_address VARCHAR(255) NOT NULL,
    order_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_order_user
        FOREIGN KEY (user_id) REFERENCES users(user_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    food_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_orderitem_order
        FOREIGN KEY (order_id) REFERENCES orders(order_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_orderitem_food
        FOREIGN KEY (food_id) REFERENCES food_items(food_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- ============================================================
-- ONE RESTAURANT
-- ============================================================
INSERT INTO restaurant
(restaurant_name, description, address, phone, image)
VALUES
('Victo Food House',
 'Fresh food. Simple ordering. Delivered with care.',
 'Bhimavaram, Andhra Pradesh',
 '9876543210',
 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=1000&auto=format&fit=crop&q=80');

-- ============================================================
-- USERS
-- ============================================================
INSERT INTO users (name,email,password,phone,address,role) VALUES
('Administrator','admin@victo.com','admin123','9876543210','Bhimavaram, Andhra Pradesh','ADMIN'),
('Sreenu','sreenu@gmail.com','12345','9876543210','Bhimavaram, Andhra Pradesh','CUSTOMER');

-- ============================================================
-- FOOD ITEMS
-- ============================================================
INSERT INTO food_items
(restaurant_id,food_name,description,category,price,image,availability) VALUES
(1,'Chicken Biryani','Aromatic basmati rice cooked with tender chicken and traditional spices.','Biryani',220.00,'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=800&auto=format&fit=crop&q=80',TRUE),
(1,'Mutton Biryani','Fragrant basmati rice slow-cooked with tender mutton and rich spices.','Biryani',280.00,'https://images.unsplash.com/photo-1633945274405-b6c8069047b0?w=800&auto=format&fit=crop&q=80',TRUE),
(1,'Veg Biryani','Fragrant basmati rice layered with fresh vegetables and aromatic spices.','Biryani',160.00,'https://images.unsplash.com/photo-1642821373181-696a54913e93?w=800&auto=format&fit=crop&q=80',TRUE),
(1,'Chicken 65','Crispy deep-fried chicken tossed with spicy masala and fresh curry leaves.','Starters',180.00,'https://upload.wikimedia.org/wikipedia/commons/d/d7/Chicken_65.jpg',TRUE),
(1,'Chicken Manchurian','Crispy golden chicken pieces tossed in a flavorful Indo-Chinese Manchurian sauce.','Starters',190.00,'https://images.unsplash.com/photo-1525755662778-989d0524087e?w=800&auto=format&fit=crop&q=80',TRUE),
(1,'Paneer 65','Crispy spiced cottage cheese cubes seasoned with herbs and curry leaves.','Starters',160.00,'https://images.unsplash.com/photo-1567184109-24b52b2fa955?w=800&auto=format&fit=crop&q=80',TRUE),
(1,'Chicken Fried Rice','Wok-tossed rice prepared with tender chicken chunks, egg and fresh vegetables.','Rice',180.00,'https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=800&auto=format&fit=crop&q=80',TRUE),
(1,'Veg Fried Rice','Wok-tossed basmati rice with crunchy fresh garden vegetables and seasoning.','Rice',150.00,'https://images.unsplash.com/photo-1512058564366-18510be2db19?w=800&auto=format&fit=crop&q=80',TRUE),
(1,'Chicken Noodles','Classic Hakka noodles wok-tossed with succulent chicken and fresh veggies.','Noodles',170.00,'https://images.unsplash.com/photo-1585032226651-759b368d7246?w=800&auto=format&fit=crop&q=80',TRUE),
(1,'Chicken Burger','Crisp seasoned chicken patty layered with lettuce, melted cheese and secret sauce.','Burgers',150.00,'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=800&auto=format&fit=crop&q=80',TRUE),
(1,'Veg Burger','Crispy spiced vegetable patty with crisp lettuce, fresh tomato and creamy mayo.','Burgers',120.00,'https://images.unsplash.com/photo-1550547660-d9450f859349?w=800&auto=format&fit=crop&q=80',TRUE),
(1,'Chicken Pizza','Oven-baked crust topped with savory chicken pieces, peppers and melted mozzarella.','Pizza',250.00,'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=800&auto=format&fit=crop&q=80',TRUE),
(1,'Veg Pizza','Freshly baked pizza loaded with colorful vegetables, herbs and gooey cheese.','Pizza',220.00,'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=800&auto=format&fit=crop&q=80',TRUE),
(1,'Gulab Jamun','Traditional melt-in-the-mouth milk dumplings soaked in aromatic rose sugar syrup.','Desserts',80.00,'https://images.unsplash.com/photo-1601050690597-df0568f70950?w=800&auto=format&fit=crop&q=80',TRUE),
(1,'Chocolate Brownie','Decadent, rich dark chocolate brownie with a fudgy center and chocolate drizzle.','Desserts',120.00,'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?w=800&auto=format&fit=crop&q=80',TRUE);

-- One cart per customer.
INSERT INTO cart (user_id) VALUES (2);

-- ============================================================
-- VERIFY
-- ============================================================
SELECT * FROM restaurant;
SELECT * FROM users;
SELECT * FROM food_items;
SELECT * FROM cart;
SELECT * FROM cart_items;
SELECT * FROM orders;
SELECT * FROM order_items;
