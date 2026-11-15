# Online Food Ordering System

A food ordering web application built with **Java Servlets, JSP, JDBC, and MySQL** for **Victo Food House**. Customers can browse the menu, manage their cart, access checkout, and view order history.

## About the Project

**Victo Food House** is a single-restaurant online food ordering project built with **Java Servlets, JSP, JDBC, and MySQL**. It brings together a category-based menu, shopping cart, checkout page, and customer order history in a Bootstrap interface.

The project follows **MVC architecture** with a dedicated **DAO layer**, separating request handling, presentation, and database access. It demonstrates core Java web development concepts through a familiar, practical application.

## Features

| Feature | Experience |
| :--- | :--- |
| **Customer access** | Login-first landing page with a home view and logout option after sign-in. |
| **Restaurant menu** | Category chips, food photographs, prices, and quantity selection. |
| **Shopping cart** | Review selected items and totals, update quantities, and remove items. |
| **Quantity updates** | Dedicated update page with server-side Servlet and DAO/JDBC processing. |
| **Checkout** | A separate checkout interface accessible from the ordering workflow. |
| **Order history** | A dedicated page for viewing customer orders. |
| **Dynamic presentation** | Database-driven image URLs and Bootstrap navigation components. |

## Technologies Used

| Layer | Technology |
| --- | --- |
| Language | Java 17 |
| Request handling | Java Servlets / Jakarta Servlet API 6.1.0 |
| Views | JSP, HTML5, CSS3 |
| UI components | Bootstrap 5.3.3, Bootstrap Icons |
| Database access | JDBC, DAO design pattern |
| Database | MySQL |
| JDBC driver | MySQL Connector/J 9.6.0 |
| Application server | Apache Tomcat 11 |
| Project environment | Eclipse Dynamic Web Project |
| Architecture | Model–View–Controller (MVC) |

## How It Works

1. The browser sends a request to a Servlet, such as the menu or cart controller.
2. The Servlet coordinates the request and calls the DAO layer when database access is needed.
3. DAO classes execute database operations through JDBC using the connection utility.
4. The application passes the required data to a JSP view.
5. The JSP displays the result using HTML, CSS, and Bootstrap.

For example, `FoodListServlet` provides the menu view in `menu.jsp`, while `OrderHistoryServlet` provides the customer order history view in `orders.jsp`.

## Project Files

| Component | Responsibility | Location |
| --- | --- | --- |
| Controller | Handle incoming requests and coordinate application actions | `src/com/food/controller/` |
| Model | Represent application data | `src/com/food/model/` |
| DAO | Perform database operations through JDBC | `src/com/food/dao/` |
| Database utility | Configure and create database connections | `src/com/food/util/DBConnection.java` |
| View | Render the user interface | `WebContent/*.jsp` |

## Prerequisites

- JDK 17
- Eclipse with Java web development support
- Apache Tomcat 11
- MySQL and MySQL Workbench
- Jakarta Servlet API 6.1.0 and MySQL Connector/J 9.6.0 JAR files

## How to Run

### 1. Prepare the environment

Install Java 17, MySQL, Apache Tomcat 11, and an Eclipse installation with Java web development support. Download or clone this repository and locate the `OnlineFoodOrderingSystem` project folder.

The Eclipse build path references these dependency files:

| Dependency | Expected location |
| --- | --- |
| Jakarta Servlet API | `lib/jakarta.servlet-api-6.1.0.jar` |
| MySQL Connector/J | `WebContent/WEB-INF/lib/mysql-connector-j-9.6.0.jar` |

Make sure these files are present or adjust the Eclipse build path to match their actual locations. Tomcat provides the Servlet API at runtime; keep that API dependency out of the deployed application's `WEB-INF/lib` folder.

### 2. Set up the database

1. Start MySQL and open MySQL Workbench.
2. Open and execute `database/food_ordering_db.sql`.
3. Confirm that the `food_ordering_db` database is available.
4. Open `src/com/food/util/DBConnection.java` and configure its connection URL, username, and password for your local MySQL installation.

For a local MySQL server on its default port, the JDBC URL is:

```text
jdbc:mysql://localhost:3306/food_ordering_db
```

Use your own local database credentials. Do not commit private credentials to a public repository.

### 3. Import into Eclipse

1. Select **File → Import → General → Existing Projects into Workspace**.
2. Browse to the `OnlineFoodOrderingSystem` folder and finish the import.
3. Under **Project Properties → Targeted Runtimes**, select **Apache Tomcat v11.0**.
4. Check the project facets. The project import guide specifies **Java 17** and **Dynamic Web Module 6.0**.
5. Confirm that the Java build path resolves the required JAR files.
6. Select **Project → Clean**.

### 4. Run the application

Add the project to Tomcat 11 in Eclipse's **Servers** view, then start the server.

Open:

```text
http://localhost:8080/OnlineFoodOrderingSystem/
```

If your Tomcat port or application context differs, adjust the URL accordingly.

## Demo Accounts

Use these demo accounts after importing the project database:

| Role | Email | Password |
| --- | --- | --- |
| Customer | `sreenu@gmail.com` | `12345` |
| Admin | `admin@victo.com` | `admin123` |

> These are local demo accounts. Replace or disable them before deploying publicly.

## Pages and Controllers

| Entry point / Controller | View | Purpose |
| --- | --- | --- |
| Landing page | `index.jsp` | Login-first entry page and home page after login |
| `FoodListServlet` | `menu.jsp` | Category-based menu, photographs, prices, and quantity selection |
| `CartServlet` | `cart.jsp` | Cart items, totals, update controls, and removal actions |
| `UpdateCartServlet` | `update-cart.jsp` | Dedicated quantity update page |
| Checkout page | `checkout.jsp` | Checkout interface |
| `OrderHistoryServlet` | `orders.jsp` | Customer order history |

Controller names above identify project classes; consult their mappings before using them as direct URLs.

## Implementation Notes

- The project is configured for **one restaurant: Victo Food House**.
- Food image URLs are stored in MySQL and rendered dynamically in JSP pages. External image availability depends on their source hosts.
- No custom JavaScript validation is included. Bootstrap's bundled JavaScript is used for components such as the responsive navbar.
- Cart quantity changes are handled on the server through the Servlet and DAO/JDBC layers.
- The Eclipse configuration uses a source folder and explicit JAR dependencies; these instructions do not assume a Maven or Gradle build.

## Common Problems

| Problem | What to check |
| --- | --- |
| Database connection fails | MySQL is running; the SQL script has been executed; the URL and credentials in `DBConnection.java` match your installation. |
| MySQL driver is missing | Connector/J exists at the expected path and is available to the deployed application. |
| Servlet classes cannot be resolved | The Servlet API dependency, Java 17 build path, and Tomcat 11 targeted runtime are configured. |
| Application returns 404 | The project is added to Tomcat, deployment completed, and the context path and port match the URL. |
| Food images do not load | The database contains valid image URLs and the image hosts are reachable. |
| Eclipse reports runtime or facet errors | Check the installed Tomcat adapter and project facets, then clean and republish the project. |

## Learning Highlights

This project demonstrates:

- Handling web requests with Java Servlets.
- Rendering dynamic content with JSP.
- Connecting a Java application to MySQL using JDBC.
- Separating database logic with the DAO design pattern.
- Organizing controllers, models, and views using MVC architecture.
- Building menu and cart interfaces with Bootstrap.
- Configuring and running a Java web project in Eclipse and Tomcat.

## Future Enhancements

The following are future ideas, not claims about the current implementation:

- Add automated tests for cart operations and order processing.
- Add search and filtering by price or dietary preference.
- Add order status tracking and customer notifications.
- Integrate a payment provider in test mode.
- Extend the application to support multiple restaurants.

## Screenshots

Screenshots can be added to a `screenshots` folder to show the following pages:

- Login and home page
- Food menu
- Shopping cart
- Quantity update page
- Checkout
- Order history

## Author

**NAMANA LAKSHMI SAI MANIKANTA SRINU**

- GitHub: [Srinu-Namana](https://github.com/Srinu-Namana)
- LinkedIn: [Namana Manikanta](https://www.linkedin.com/in/namana-manikanta-489a42375/)
