# 🍔 Online Food Ordering System

**OnlineFoodOrderingSystem** is a web-based food ordering application built as an Eclipse **Dynamic Web Project** using **Java Servlets, JSP, JDBC and MySQL**, following the **MVC architecture**. Customers can browse the menu, add items to a cart and place orders, while admins manage menu items and track orders.

![Java](https://img.shields.io/badge/Java-17-orange?logo=openjdk)
![Servlets](https://img.shields.io/badge/Servlets-JSP-blue)
![MySQL](https://img.shields.io/badge/MySQL-8.0-4479A1?logo=mysql&logoColor=white)
![Tomcat](https://img.shields.io/badge/Tomcat-10%2F11-F8DC75?logo=apachetomcat&logoColor=black)
![License](https://img.shields.io/badge/License-MIT-green)

---

## 📑 Table of Contents

- [Features](#-features)
- [Tech Stack](#-tech-stack)
- [Architecture](#-architecture)
- [Project Structure](#-project-structure)
- [Database Design](#-database-design)
- [Getting Started](#-getting-started)
- [Usage](#-usage)
- [Screenshots](#-screenshots)
- [Future Enhancements](#-future-enhancements)
- [Contributing](#-contributing)
- [Author](#-author)

---

## ✨ Features

### 👤 Customer
- User registration and login with session management
- Browse the food menu by category
- Search food items
- Add / update / remove items in the cart
- Place orders and view order history
- Logout

### 🛠️ Admin
- Secure admin login
- Add, update and delete food items
- Manage categories
- View and update order status (Pending → Preparing → Delivered)
- View registered customers

### 🔒 General
- Session-based authentication and authorization
- Input validation
- Prepared statements to prevent SQL injection

> Edit this list so it matches exactly what your project does.

---

## 🧰 Tech Stack

| Layer      | Technology                            |
|------------|---------------------------------------|
| Frontend   | HTML, CSS, Bootstrap, JavaScript, JSP |
| Backend    | Java, Servlets, JDBC                  |
| Database   | MySQL                                 |
| Server     | Apache Tomcat                         |
| Tools      | Eclipse / VS Code, Git, GitHub        |

---

## 🏗️ Architecture

The project follows the **MVC (Model-View-Controller)** pattern:

```
 Browser ──► Servlet (Controller) ──► DAO (Model) ──► MySQL
    ▲              │
    └──── JSP (View) ◄────┘
```

- **Model**: JavaBeans (`User`, `FoodItem`, `Order`) and DAO classes that talk to the database via JDBC
- **View**: JSP pages for the user interface
- **Controller**: Servlets that handle requests, call DAOs and forward to views

---

## 📂 Project Structure

```
OnlineFoodOrderingSystem/
├── src/main/java/com/foodapp/
│   ├── controller/      # Servlets (Login, Register, Cart, Order, Admin...)
│   ├── dao/             # Data access classes (UserDAO, FoodDAO, OrderDAO)
│   ├── model/           # POJOs / JavaBeans
│   └── util/            # DBConnection utility
├── src/main/webapp/
│   ├── css/
│   ├── js/
│   ├── images/
│   ├── WEB-INF/web.xml
│   ├── index.jsp
│   ├── login.jsp
│   ├── register.jsp
│   ├── menu.jsp
│   ├── cart.jsp
│   └── orders.jsp
├── database/
│   └── food_db.sql      # Database schema + sample data
└── README.md
```

> Adjust folder and file names to match your repository.

---

## 🗄️ Database Design

**Main tables**

| Table         | Purpose                                      |
|---------------|----------------------------------------------|
| `users`       | Customer and admin accounts                  |
| `categories`  | Food categories (Starters, Biryani, Drinks…) |
| `food_items`  | Menu items with price, image and category    |
| `orders`      | Order header (user, total, status, date)     |
| `order_items` | Items belonging to each order                |

Import the schema from `database/food_db.sql`.

---

## 🚀 Getting Started

### Prerequisites
- JDK 17 or later
- Apache Tomcat 10 or later
- MySQL 8.0 or later
- Eclipse IDE for Enterprise Java (or any IDE with Tomcat support)
- MySQL Connector/J (JDBC driver)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/<your-username>/<your-repo-name>.git
   cd <your-repo-name>
   ```

2. **Create the database**
   ```sql
   CREATE DATABASE food_db;
   USE food_db;
   SOURCE database/food_db.sql;
   ```

3. **Configure the database connection** in `DBConnection.java`
   ```java
   private static final String URL = "jdbc:mysql://localhost:3306/food_db";
   private static final String USER = "root";
   private static final String PASSWORD = "your_password";
   ```

4. **Add the MySQL Connector/J JAR** to `WEB-INF/lib` (or your build path).

5. **Import into Eclipse**
   `File → Import → Existing Projects into Workspace`

6. **Run on Tomcat**
   Right-click the project → `Run As → Run on Server` → choose Tomcat.

7. **Open in browser**
   ```
   http://localhost:8080/OnlineFoodOrderingSystem/
   ```

---

## 💡 Usage

**Customer:** Register → Log in → Browse menu → Add to cart → Place order → View order history

**Admin:** Log in with admin credentials → Manage menu items → Update order status

| Role  | Username          | Password   |
|-------|-------------------|------------|
| Admin | `admin@food.com`  | `admin123` |

> Replace these with your actual demo credentials, or remove this table.

---

## 📸 Screenshots

Create a `screenshots/` folder, add your images and link them here:

| Home Page | Menu | Cart |
|-----------|------|------|
| ![Home](screenshots/home.png) | ![Menu](screenshots/menu.png) | ![Cart](screenshots/cart.png) |

| Order History | Admin Dashboard |
|---------------|-----------------|
| ![Orders](screenshots/orders.png) | ![Admin](screenshots/admin.png) |

---

## 🔮 Future Enhancements

- Online payment gateway integration
- Password hashing (BCrypt)
- Order tracking and email notifications
- Ratings and reviews
- Migration to Spring Boot REST APIs with a React frontend
- Docker support

---

## 🤝 Contributing

Contributions are welcome!

1. Fork the repository
2. Create a branch: `git checkout -b feature/your-feature`
3. Commit your changes: `git commit -m "Add your feature"`
4. Push: `git push origin feature/your-feature`
5. Open a Pull Request

---

## 👨‍💻 Author

**Lakshmi Sai Manikanta Srinu Namana**
Aspiring Java Full Stack Developer

- GitHub: [@your-username](https://github.com/your-username)
- LinkedIn: [your-profile](https://linkedin.com/in/your-profile)
- Email: your-email@example.com

---

⭐ If you found this project useful, please give it a star!
