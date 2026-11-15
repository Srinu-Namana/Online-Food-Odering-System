# Online Food Ordering System — UI Updated Starter

## Technology
- Java Servlets
- JSP
- HTML5
- CSS3
- Bootstrap 5.3.3
- Bootstrap Icons
- JDBC
- MySQL
- DAO Design Pattern
- MVC Architecture

## UI update
The frontend is designed as a modern food-delivery style interface inspired by common patterns used by food-ordering platforms: restaurant header, rating/delivery information, horizontally scrollable category chips, food photos, prices, quantity selection, prominent ADD buttons, cart summary and a separate Bootstrap update page.

The menu uses real food photographs referenced from their source URLs in the SQL data. Image-source URLs are kept in the database so the JSP pages display the same images dynamically.

## Important
- No custom JavaScript validation is included.
- Bootstrap's bundled JavaScript is used only for Bootstrap components such as the responsive navbar.
- Quantity updates are handled through `UpdateCartServlet` + `UpdateCartServlet` DAO/JDBC flow.
- The project contains one restaurant: Victo Food House.

## Database
Run `database/food_ordering_db.sql` in MySQL Workbench.

Database: `food_ordering_db`

Demo customer:
- Email: `sreenu@gmail.com`
- Password: `12345`

Demo admin:
- Email: `admin@victo.com`
- Password: `admin123`

## Main pages
- `index.jsp` — login-first landing page; after login it becomes the home page and shows Logout.
- `FoodListServlet` → `menu.jsp` — category-based menu with real food photos, prices and quantity selection.
- `CartServlet` → `cart.jsp` — cart, totals, Update and Remove actions.
- `UpdateCartServlet` → `update-cart.jsp` — Bootstrap update page for quantity changes.
- `checkout.jsp` — checkout.
- `OrderHistoryServlet` → `orders.jsp` — customer order history.

## Architecture
Controller: `src/com/food/controller`
Model: `src/com/food/model`
DAO: `src/com/food/dao`
DB utility: `src/com/food/util/DBConnection.java`
View: `WebContent/*.jsp`
