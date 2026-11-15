<%@ page contentType="text/html;charset=UTF-8" import="com.food.model.User"%>
<%
User currentUser = (User) session.getAttribute("user");
if (currentUser != null) {
    response.sendRedirect("index.jsp");
    return;
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Register | Victo Food House</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
</head>
<body class="bg-light">

<!-- Navbar -->
<nav class="navbar main-navbar bg-white sticky-top">
  <div class="container py-2">
    <a class="navbar-brand brand-title" href="${pageContext.request.contextPath}/index.jsp">Victo<span class="brand-dot">.</span></a>
    <div class="ms-auto d-flex align-items-center gap-2">
      <a href="${pageContext.request.contextPath}/FoodListServlet" class="nav-link"><i class="bi bi-compass me-1"></i>Menu</a>
      <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-outline-primary rounded-pill px-4 fw-semibold">Login</a>
    </div>
  </div>
</nav>

<div class="container py-5">
  <div class="row justify-content-center">
    <div class="col-md-9 col-lg-7">
      <div class="auth-box shadow-sm">
        <div class="text-center mb-4">
          <div class="auth-icon-circle"><i class="bi bi-person-plus-fill"></i></div>
          <h2 class="fw-bold mb-1">Create Account</h2>
          <p class="text-secondary small mb-0">Join Victo Food House to order delicious food directly to your doorstep</p>
        </div>

        <% String e=request.getParameter("error"); %>
        <% if("required".equals(e)){ %><div class="alert alert-warning py-2 small"><i class="bi bi-info-circle me-1"></i> Full Name, email and password are required.</div><% } %>
        <% if("exists".equals(e)){ %><div class="alert alert-danger py-2 small"><i class="bi bi-exclamation-triangle-fill me-1"></i> An account with this email already exists.</div><% } %>
        <% if("password".equals(e)){ %><div class="alert alert-warning py-2 small"><i class="bi bi-shield-lock me-1"></i> Password must contain at least 4 characters.</div><% } %>
        <% if("db".equals(e)){ %><div class="alert alert-danger py-2 small"><i class="bi bi-database-x me-1"></i> Database connection failed. Verify MySQL connection.</div><% } %>

        <form action="${pageContext.request.contextPath}/RegisterServlet" method="post">
          <div class="row g-3">
            <div class="col-md-6">
              <label class="form-label fw-semibold small">Full Name</label>
              <input type="text" name="name" class="form-control" placeholder="John Doe" required>
            </div>
            <div class="col-md-6">
              <label class="form-label fw-semibold small">Email Address</label>
              <input type="email" name="email" class="form-control" placeholder="john@example.com" required>
            </div>
            <div class="col-md-6">
              <label class="form-label fw-semibold small">Phone Number</label>
              <input type="tel" name="phone" class="form-control" placeholder="9876543210">
            </div>
            <div class="col-md-6">
              <label class="form-label fw-semibold small">Password</label>
              <input type="password" name="password" minlength="4" class="form-control" placeholder="Min 4 characters" required>
            </div>
            <div class="col-12">
              <label class="form-label fw-semibold small">Delivery Address</label>
              <textarea name="address" rows="3" class="form-control" placeholder="Street, house number, area, Bhimavaram..."></textarea>
            </div>
          </div>

          <button type="submit" class="btn btn-primary btn-lg w-100 rounded-pill fw-bold shadow-sm mt-4">
            Register Account <i class="bi bi-arrow-right ms-1"></i>
          </button>
        </form>

        <div class="text-center mt-4">
          <span class="text-secondary small">Already have an account?</span>
          <a href="${pageContext.request.contextPath}/login.jsp" class="fw-bold text-decoration-none text-primary ms-1">Sign in here</a>
        </div>
      </div>
    </div>
  </div>
</div>

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