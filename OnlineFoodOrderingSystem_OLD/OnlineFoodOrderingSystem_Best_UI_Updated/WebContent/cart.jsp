<%@ page contentType="text/html;charset=UTF-8" import="java.util.*,com.food.model.*,com.food.util.HtmlUtil"%>
<%
User currentUser = (User) session.getAttribute("user");
boolean loggedIn = currentUser != null;
Cart cart = (Cart) request.getAttribute("cart");
if (cart == null) {
    response.sendRedirect("CartServlet");
    return;
}
String defaultFallback = "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=600&auto=format&fit=crop&q=80";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Your Cart | Victo Food House</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
</head>
<body>

<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg main-navbar sticky-top">
  <div class="container py-2">
    <a class="navbar-brand brand-title" href="index.jsp">Victo<span class="brand-dot">.</span></a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navContent">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navContent">
      <ul class="navbar-nav ms-auto align-items-lg-center gap-lg-2">
        <li class="nav-item"><a class="nav-link" href="index.jsp"><i class="bi bi-house-door me-1"></i>Home</a></li>
        <li class="nav-item"><a class="nav-link" href="FoodListServlet"><i class="bi bi-menu-button-wide me-1"></i>Menu</a></li>
        <li class="nav-item"><a class="nav-link active" href="CartServlet"><i class="bi bi-bag me-1"></i>Cart (<%=cart.getItems().size()%>)</a></li>
        <% if (loggedIn) { %>
          <li class="nav-item"><a class="nav-link" href="OrderHistoryServlet"><i class="bi bi-clock-history me-1"></i>My Orders</a></li>
          <li class="nav-item ms-lg-2">
            <span class="user-badge"><i class="bi bi-person-circle text-primary"></i> Hi, <%=HtmlUtil.e(currentUser.getName())%></span>
          </li>
          <li class="nav-item ms-lg-2">
            <!-- ONLY Logout shown when user is logged in -->
            <a class="btn-logout" href="LogoutServlet"><i class="bi bi-box-arrow-right me-1"></i> Logout</a>
          </li>
        <% } else { %>
          <li class="nav-item ms-lg-2">
            <a class="btn btn-primary rounded-pill px-4 fw-bold" href="index.jsp#loginSection">Login</a>
          </li>
        <% } %>
      </ul>
    </div>
  </div>
</nav>

<!-- Page Header -->
<section class="bg-white border-bottom py-4">
  <div class="container">
    <span class="text-uppercase fw-bold text-primary small letter-spacing-1">ORDER REVIEW</span>
    <h1 class="fw-bold mb-1">Shopping Cart</h1>
    <p class="text-secondary small mb-0">Verify your selected dishes, update quantity, and proceed to checkout.</p>
  </div>
</section>

<!-- Cart Content -->
<section class="py-5">
  <div class="container">
    <% if ("1".equals(request.getParameter("added"))) { %>
      <div class="alert alert-success alert-dismissible fade show border-0 shadow-sm" role="alert">
        <i class="bi bi-check-circle-fill me-2"></i>Item successfully added to your cart.
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
      </div>
    <% } %>
    <% if ("1".equals(request.getParameter("updated"))) { %>
      <div class="alert alert-success alert-dismissible fade show border-0 shadow-sm" role="alert">
        <i class="bi bi-check-circle-fill me-2"></i>Cart item quantity and amount updated successfully.
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
      </div>
    <% } %>
    <% if ("1".equals(request.getParameter("removed"))) { %>
      <div class="alert alert-info alert-dismissible fade show border-0 shadow-sm" role="alert">
        <i class="bi bi-trash-fill me-2"></i>Item removed from your cart.
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
      </div>
    <% } %>
    <% if ("update".equals(request.getParameter("error"))) { %>
      <div class="alert alert-danger alert-dismissible fade show border-0 shadow-sm" role="alert">
        <i class="bi bi-exclamation-triangle-fill me-2"></i>Unable to update the cart item.
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
      </div>
    <% } %>

    <% if (cart.getItems().isEmpty()) { %>
      <div class="text-center py-5 bg-white rounded-4 border p-5 shadow-sm">
        <i class="bi bi-bag-x fs-1 text-muted"></i>
        <h3 class="mt-3 fw-bold">Your cart is empty</h3>
        <p class="text-secondary">Good food is always just a few clicks away. Explore our menu to start ordering!</p>
        <a href="FoodListServlet" class="btn btn-primary rounded-pill px-5 fw-bold mt-2 shadow-sm">Browse Menu</a>
      </div>
    <% } else { %>
      <div class="row g-4 align-items-start">
        <!-- Cart Items List -->
        <div class="col-lg-8">
          <div class="cart-card-wrap">
            <div class="p-3 p-md-4 border-bottom d-flex justify-content-between align-items-center">
              <div>
                <h4 class="fw-bold mb-0">Cart Items</h4>
                <span class="small text-secondary"><%=cart.getItems().size()%> distinct item(s) selected</span>
              </div>
              <a href="FoodListServlet" class="btn btn-outline-primary btn-sm rounded-pill px-3 fw-bold">+ Add more items</a>
            </div>

            <div class="p-2 p-md-3">
              <% for (CartItem i : cart.getItems()) {
                   String img = i.getImage();
                   if (img == null || img.trim().isEmpty()) {
                       img = defaultFallback;
                   }
                   boolean isVeg = !i.getFoodName().toLowerCase().contains("chicken") && !i.getFoodName().toLowerCase().contains("mutton");
              %>
                <div class="cart-item-row">
                  <!-- Thumbnail & Name -->
                  <div class="d-flex align-items-center gap-3">
                    <img src="<%=img%>" class="cart-item-thumb" alt="<%=HtmlUtil.e(i.getFoodName())%>" onerror="this.src='<%=defaultFallback%>'">
                    <div>
                      <% if (isVeg) { %>
                        <span class="veg-icon" title="Veg"></span>
                      <% } else { %>
                        <span class="nonveg-icon" title="Non-Veg"></span>
                      <% } %>
                      <h5 class="fw-bold mb-1"><%=HtmlUtil.e(i.getFoodName())%></h5>
                      <span class="text-secondary small">₹<%=String.format("%.0f", i.getPrice())%> each</span>
                    </div>
                  </div>

                  <!-- Quantity Badge -->
                  <div class="text-center">
                    <span class="cart-item-qty-tag">
                      Qty: <strong><%=i.getQuantity()%></strong>
                    </span>
                  </div>

                  <!-- Rupee Amount with spacing -->
                  <div class="text-end">
                    <div class="rupee-price-box mb-0 justify-content-end">
                      <span class="rupee-sign">₹</span>
                      <span class="rupee-val"><%=String.format("%.0f", i.getLineTotal())%></span>
                    </div>
                    <span class="small text-muted d-block">(₹<%=String.format("%.0f", i.getPrice())%> × <%=i.getQuantity()%>)</span>
                  </div>

                  <!-- Actions -->
                  <div class="d-flex flex-column gap-2 align-items-end">
                    <a href="UpdateCartServlet?cartItemId=<%=i.getCartItemId()%>" class="btn btn-sm btn-outline-primary rounded-pill px-3 fw-bold w-100">
                      <i class="bi bi-pencil-square me-1"></i> Update
                    </a>
                    <form action="RemoveCartServlet" method="post" onsubmit="return confirm('Remove <%=HtmlUtil.e(i.getFoodName())%> from your cart?');">
                      <input type="hidden" name="cartItemId" value="<%=i.getCartItemId()%>">
                      <button type="submit" class="btn btn-sm btn-outline-danger rounded-pill px-3 w-100">
                        <i class="bi bi-trash3 me-1"></i> Remove
                      </button>
                    </form>
                  </div>
                </div>
              <% } %>
            </div>
          </div>
        </div>

        <!-- Bill Details Summary -->
        <div class="col-lg-4">
          <div class="bill-summary-card">
            <div class="d-flex align-items-center gap-2 mb-3">
              <i class="bi bi-receipt fs-4 text-primary"></i>
              <h4 class="fw-bold mb-0">Bill Details</h4>
            </div>

            <div class="d-flex justify-content-between py-2 text-secondary">
              <span>Item Total</span>
              <strong class="text-dark">₹<%=String.format("%.2f", cart.getTotal())%></strong>
            </div>
            <div class="d-flex justify-content-between py-2 text-secondary">
              <span>Delivery Partner Fee</span>
              <span class="text-success fw-bold">FREE</span>
            </div>
            <div class="d-flex justify-content-between py-2 text-secondary">
              <span>Taxes & Restaurant Charges</span>
              <span>₹0.00</span>
            </div>
            
            <hr class="my-3">
            
            <div class="d-flex justify-content-between align-items-center mb-4">
              <strong class="fs-5">To Pay</strong>
              <div class="rupee-price-box mb-0">
                <span class="rupee-sign text-primary">₹</span>
                <span class="rupee-val text-primary fs-2"><%=String.format("%.2f", cart.getTotal())%></span>
              </div>
            </div>

            <a href="checkout.jsp" class="btn btn-primary btn-lg w-100 rounded-pill fw-bold shadow">
              Proceed to Checkout <i class="bi bi-arrow-right ms-1"></i>
            </a>

            <div class="text-center text-muted small mt-3">
              <i class="bi bi-shield-check text-success me-1"></i> Safe & Secure Order Flow
            </div>
          </div>
        </div>
      </div>
    <% } %>
  </div>
</section>

<footer class="site-footer">
  <div class="container py-4 d-flex flex-wrap justify-content-between align-items-center gap-3">
    <div>
      <h5 class="fw-bold text-white mb-1">Victo Food House</h5>
      <span class="small">Fresh food. Simple ordering. Delivered with care.</span>
    </div>
    <div class="small text-secondary">
      Bhimavaram, Andhra Pradesh · Phone: 9876543210
    </div>
  </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
