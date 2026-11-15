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
<title>Customer Login | Victo Food House</title>
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
      <a href="${pageContext.request.contextPath}/register.jsp" class="btn btn-outline-primary rounded-pill px-4 fw-semibold">Create Account</a>
    </div>
  </div>
</nav>

<div class="container py-5">
  <div class="row justify-content-center">
    <div class="col-md-7 col-lg-5">
      <div class="auth-box shadow-sm">
        <div class="text-center mb-4">
          <div class="auth-icon-circle"><i class="bi bi-person-fill-lock"></i></div>
          <h2 class="fw-bold mb-1">Welcome Back</h2>
          <p class="text-secondary small mb-0">Sign in with your email to start ordering</p>
        </div>

        <% String error=request.getParameter("error"); %>
        <% if("invalid".equals(error)){ %><div class="alert alert-danger py-2 small"><i class="bi bi-exclamation-triangle-fill me-1"></i> Invalid email or password.</div><% } %>
        <% if("required".equals(error)){ %><div class="alert alert-warning py-2 small"><i class="bi bi-info-circle me-1"></i> Please enter email and password.</div><% } %>
        <% if("login".equals(error)){ %><div class="alert alert-warning py-2 small"><i class="bi bi-info-circle me-1"></i> Please login to access your cart or checkout.</div><% } %>
        <% if("db".equals(error)){ String code=request.getParameter("code"); %><div class="alert alert-danger py-2 small"><strong>Database connection failed.</strong> Diagnostic: <code><%=code==null?"DATABASE_CONNECTION_ERROR":code%></code></div><% } %>
        <% if("server".equals(error)){ %><div class="alert alert-danger py-2 small">Server error occurred. Please try again.</div><% } %>
        <% if("1".equals(request.getParameter("registered"))){ %><div class="alert alert-success py-2 small"><i class="bi bi-check-circle me-1"></i> Registration successful! Please login below.</div><% } %>

        <form action="${pageContext.request.contextPath}/LoginServlet" method="post">
          <div class="mb-3">
            <label class="form-label fw-semibold small">Email Address</label>
            <div class="input-group">
              <span class="input-group-text bg-light text-secondary"><i class="bi bi-envelope"></i></span>
              <input type="email" name="email" class="form-control form-control-lg" placeholder="sreenu@gmail.com" required>
            </div>
          </div>
          <div class="mb-4">
            <label class="form-label fw-semibold small">Password</label>
            <div class="input-group">
              <span class="input-group-text bg-light text-secondary"><i class="bi bi-lock"></i></span>
              <input type="password" name="password" class="form-control form-control-lg" placeholder="••••••••" required>
            </div>
          </div>
          <button type="submit" class="btn btn-primary btn-lg w-100 rounded-pill fw-bold shadow-sm">
            Login <i class="bi bi-arrow-right ms-1"></i>
          </button>
        </form>

        <div class="demo-account-hint mt-4">
          <span class="text-muted small d-block mb-1">Pre-configured Demo Account:</span>
          <strong>Customer:</strong> sreenu@gmail.com / 12345<br>
          <strong>Admin:</strong> admin@victo.com / admin123
        </div>

        <div class="text-center mt-4">
          <span class="text-secondary small">Don't have an account yet?</span>
          <a href="${pageContext.request.contextPath}/register.jsp" class="fw-bold text-decoration-none text-primary ms-1">Sign up here</a>
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