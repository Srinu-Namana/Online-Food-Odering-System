<%@ page contentType="text/html;charset=UTF-8" import="java.util.*,com.food.model.*,com.food.dao.CartDAO,com.food.util.HtmlUtil"%>
<%
User currentUser = (User) session.getAttribute("user");
if (currentUser == null) {
    response.sendRedirect("login.jsp?error=login");
    return;
}
int cartCount = 0;
try {
    Cart c = new CartDAO().getCart(currentUser.getUserId());
    if (c != null && c.getItems() != null) cartCount = c.getItems().size();
} catch(Exception ignored) {}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>My Orders | Victo Food House</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
</head>
<body>

<!-- Unified Navigation Bar -->
<nav class="navbar navbar-expand-lg main-navbar sticky-top">
  <div class="container py-2">
    <a class="navbar-brand brand-title" href="${pageContext.request.contextPath}/index.jsp">Victo<span class="brand-dot">.</span></a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navContent">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navContent">
      <ul class="navbar-nav ms-auto align-items-lg-center gap-lg-2">
        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/index.jsp"><i class="bi bi-house-door me-1"></i>Home</a></li>
        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/FoodListServlet"><i class="bi bi-menu-button-wide me-1"></i>Menu</a></li>
        <li class="nav-item">
          <a class="nav-link position-relative" href="${pageContext.request.contextPath}/CartServlet">
            <i class="bi bi-bag me-1"></i>Cart
            <% if (cartCount > 0) { %>
              <span class="badge bg-danger rounded-pill ms-1"><%=cartCount%></span>
            <% } %>
          </a>
        </li>
        <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/OrderHistoryServlet"><i class="bi bi-clock-history me-1"></i>My Orders</a></li>
        <li class="nav-item ms-lg-2">
          <span class="user-badge"><i class="bi bi-person-circle text-primary"></i> Hi, <%=HtmlUtil.e(currentUser.getName())%></span>
        </li>
        <li class="nav-item ms-lg-2">
          <!-- ONLY Logout is displayed in place of login -->
          <a class="btn-logout" href="${pageContext.request.contextPath}/LogoutServlet"><i class="bi bi-box-arrow-right me-1"></i> Logout</a>
        </li>
      </ul>
    </div>
  </div>
</nav>

<section class="bg-white border-bottom py-4">
  <div class="container">
    <span class="text-uppercase fw-bold text-primary small letter-spacing-1">YOUR ACCOUNT</span>
    <h1 class="fw-bold mb-1">Order History</h1>
    <p class="text-secondary small mb-0">Track and view your past meals and delivery records.</p>
  </div>
</section>

<section class="py-5">
  <div class="container">
    <% if (request.getParameter("placed") != null) { %>
      <div class="alert alert-success alert-dismissible fade show border-0 shadow-sm" role="alert">
        <i class="bi bi-check-circle-fill me-2"></i>Order #<%=HtmlUtil.e(request.getParameter("placed"))%> placed successfully! Your meal is being prepared.
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
      </div>
    <% } %>

    <%
    List<Order> orders = (List<Order>) request.getAttribute("orders");
    if (orders == null) orders = Collections.emptyList();
    if (orders.isEmpty()) {
    %>
      <div class="text-center py-5 bg-white rounded-4 border p-5 shadow-sm">
        <i class="bi bi-receipt-cutoff fs-1 text-muted"></i>
        <h3 class="mt-3 fw-bold">No orders placed yet</h3>
        <p class="text-secondary">Explore our delicious food items and treat yourself to a wonderful meal.</p>
        <a href="${pageContext.request.contextPath}/FoodListServlet" class="btn btn-primary rounded-pill px-5 fw-bold mt-2 shadow-sm">Order Food Now</a>
      </div>
    <% } else { %>
      <div class="row g-4">
        <% for (Order o : orders) { %>
          <div class="col-12">
            <div class="bg-white border rounded-4 p-4 shadow-sm">
              <div class="d-flex flex-wrap justify-content-between align-items-center gap-2 pb-3 border-bottom">
                <div>
                  <div class="d-flex align-items-center gap-2">
                    <h5 class="fw-bold mb-0">Order #<%=o.getOrderId()%></h5>
                    <span class="badge bg-success-subtle text-success border border-success-subtle rounded-pill px-3 py-1 fw-bold"><%=HtmlUtil.e(o.getStatus())%></span>
                  </div>
                  <div class="small text-secondary mt-1">
                    <i class="bi bi-calendar3 me-1"></i><%=HtmlUtil.e(o.getOrderDate())%>
                    <span class="mx-1">·</span>
                    <i class="bi bi-geo-alt me-1"></i><%=HtmlUtil.e(o.getDeliveryAddress())%>
                  </div>
                </div>
                <div class="text-end">
                  <span class="text-muted small d-block">Grand Total</span>
                  <div class="rupee-price-box mb-0 justify-content-end">
                    <span class="rupee-sign text-dark">₹</span>
                    <span class="rupee-val text-dark fs-3"><%=String.format("%.2f", o.getTotalAmount())%></span>
                  </div>
                </div>
              </div>

              <!-- Ordered Items -->
              <div class="row g-3 pt-3">
                <% for (OrderItem i : o.getItems()) { %>
                  <div class="col-md-6">
                    <div class="p-3 bg-light rounded-3 d-flex justify-content-between align-items-center">
                      <div>
                        <strong class="text-dark"><%=HtmlUtil.e(i.getFoodName())%></strong>
                        <span class="badge bg-white text-secondary border ms-2">Qty: <%=i.getQuantity()%></span>
                      </div>
                      <span class="fw-bold text-dark">₹<%=String.format("%.2f", i.getLineTotal())%></span>
                    </div>
                  </div>
                <% } %>
              </div>
            </div>
          </div>
        <% } %>
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