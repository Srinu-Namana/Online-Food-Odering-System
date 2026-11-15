<%@ page contentType="text/html;charset=UTF-8" import="com.food.model.*,com.food.util.HtmlUtil"%>
<%
User currentUser = (User) session.getAttribute("user");
if (currentUser == null) {
    response.sendRedirect("login.jsp?error=login");
    return;
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Checkout | Victo Food House</title>
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
        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/CartServlet"><i class="bi bi-bag me-1"></i>Cart</a></li>
        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/OrderHistoryServlet"><i class="bi bi-clock-history me-1"></i>My Orders</a></li>
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
    <span class="text-uppercase fw-bold text-primary small letter-spacing-1">FINAL STEP</span>
    <h1 class="fw-bold mb-1">Checkout & Delivery</h1>
    <p class="text-secondary small mb-0">Provide your address to confirm your meal order.</p>
  </div>
</section>

<section class="py-5">
  <div class="container">
    <div class="row justify-content-center">
      <div class="col-lg-7">
        <div class="bg-white p-4 p-md-5 rounded-4 border shadow-sm">
          <% if ("address".equals(request.getParameter("error"))) { %>
            <div class="alert alert-warning alert-dismissible fade show border-0" role="alert">
              <i class="bi bi-exclamation-triangle-fill me-2"></i>Delivery address is required to place your order.
              <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
          <% } %>

          <form action="${pageContext.request.contextPath}/PlaceOrderServlet" method="post">
            <div class="mb-4">
              <label class="form-label fw-bold">Delivery Address</label>
              <textarea name="address" class="form-control form-control-lg" rows="4" required placeholder="Enter street name, house number, landmark, Bhimavaram..."><%=currentUser.getAddress() != null ? HtmlUtil.e(currentUser.getAddress()) : ""%></textarea>
              <span class="form-text text-muted">Food will be freshly prepared and delivered within 30 minutes to this address.</span>
            </div>

            <div class="p-3 bg-light rounded-3 mb-4">
              <div class="d-flex align-items-center gap-2">
                <i class="bi bi-cash-coin fs-4 text-success"></i>
                <div>
                  <strong class="d-block text-dark">Payment Method: Cash on Delivery / UPI</strong>
                  <span class="small text-secondary">Pay conveniently at your doorstep upon receiving your hot meal.</span>
                </div>
              </div>
            </div>

            <div class="d-flex flex-column flex-sm-row gap-2">
              <button type="submit" class="btn btn-primary btn-lg rounded-pill px-5 fw-bold shadow flex-grow-1">
                Confirm & Place Order <i class="bi bi-arrow-right ms-1"></i>
              </button>
              <a href="${pageContext.request.contextPath}/CartServlet" class="btn btn-outline-secondary btn-lg rounded-pill px-4">
                Back to Cart
              </a>
            </div>
          </form>
        </div>
      </div>
    </div>
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