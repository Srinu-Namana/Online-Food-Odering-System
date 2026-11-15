<%@ page contentType="text/html;charset=UTF-8" import="com.food.model.*,com.food.util.HtmlUtil"%>
<%
User currentUser = (User) session.getAttribute("user");
boolean loggedIn = currentUser != null;
CartItem item = (CartItem) request.getAttribute("item");
if (item == null) {
    response.sendRedirect("CartServlet");
    return;
}
String img = item.getImage();
String defaultFallback = "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=600&auto=format&fit=crop&q=80";
if (img == null || img.trim().isEmpty()) {
    img = defaultFallback;
}
boolean isVeg = !item.getFoodName().toLowerCase().contains("chicken") && !item.getFoodName().toLowerCase().contains("mutton");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Update <%=HtmlUtil.e(item.getFoodName())%> | Victo Food House</title>
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
        <li class="nav-item"><a class="nav-link active" href="CartServlet"><i class="bi bi-bag me-1"></i>Cart</a></li>
        <% if (loggedIn) { %>
          <li class="nav-item"><a class="nav-link" href="OrderHistoryServlet"><i class="bi bi-clock-history me-1"></i>My Orders</a></li>
          <li class="nav-item ms-lg-2">
            <span class="user-badge"><i class="bi bi-person-circle text-primary"></i> Hi, <%=HtmlUtil.e(currentUser.getName())%></span>
          </li>
          <li class="nav-item ms-lg-2">
            <a class="btn-logout" href="LogoutServlet"><i class="bi bi-box-arrow-right me-1"></i> Logout</a>
          </li>
        <% } %>
      </ul>
    </div>
  </div>
</nav>

<!-- Page Header -->
<section class="bg-white border-bottom py-4">
  <div class="container">
    <span class="text-uppercase fw-bold text-primary small letter-spacing-1">CART MANAGEMENT</span>
    <h1 class="fw-bold mb-1">Update Item Quantity</h1>
    <p class="text-secondary small mb-0">Adjust the quantity of your dish. The rupee total automatically recalculates in real-time.</p>
  </div>
</section>

<!-- Update Form Section -->
<section class="py-5">
  <div class="container">
    <div class="update-cart-container">
      <div class="update-cart-card">
        <!-- Food Image -->
        <img src="<%=img%>" class="update-food-photo" alt="<%=HtmlUtil.e(item.getFoodName())%>" onerror="this.src='<%=defaultFallback%>'">

        <div class="p-4 p-md-5">
          <div class="d-flex align-items-center gap-2 mb-2">
            <% if (isVeg) { %>
              <span class="veg-icon" title="Pure Veg"></span>
              <span class="badge bg-success-subtle text-success border border-success-subtle rounded-pill">Pure Vegetarian</span>
            <% } else { %>
              <span class="nonveg-icon" title="Non-Veg"></span>
              <span class="badge bg-danger-subtle text-danger border border-danger-subtle rounded-pill">Non-Vegetarian</span>
            <% } %>
          </div>

          <h2 class="fw-bold mb-2"><%=HtmlUtil.e(item.getFoodName())%></h2>
          
          <div class="rupee-price-box mb-3">
            <span class="text-secondary small me-2">Base Price:</span>
            <span class="rupee-sign text-dark">₹</span>
            <span class="rupee-val text-dark" id="unitPriceDisplay"><%=String.format("%.0f", item.getPrice())%></span>
            <span class="rupee-unit">per portion</span>
          </div>

          <form action="UpdateCartServlet" method="post" id="updateCartForm">
            <input type="hidden" name="cartItemId" value="<%=item.getCartItemId()%>">
            
            <label class="form-label fw-bold mt-2">Adjust Quantity (1 - 20 items):</label>
            
            <!-- Interactive Stepper -->
            <div class="input-group input-group-lg mb-3">
              <button class="btn btn-outline-secondary px-4 fw-bold" type="button" id="btnMinus" onclick="changeQty(-1)">
                <i class="bi bi-dash-lg"></i>
              </button>
              <input type="number" id="qtyInput" name="quantity" class="form-control text-center fw-bold fs-4" value="<%=item.getQuantity()%>" min="1" max="20" oninput="onQtyChange()" onchange="onQtyChange()">
              <button class="btn btn-outline-secondary px-4 fw-bold" type="button" id="btnPlus" onclick="changeQty(1)">
                <i class="bi bi-plus-lg"></i>
              </button>
            </div>

            <!-- Quick Selection Pills -->
            <div class="d-flex flex-wrap gap-2 mb-4">
              <span class="small text-muted align-self-center me-1">Quick Select:</span>
              <% for (int q = 1; q <= 6; q++) { %>
                <button type="button" class="btn btn-sm btn-outline-primary rounded-pill px-3 fw-bold" onclick="setQty(<%=q%>)">
                  <%=q%>
                </button>
              <% } %>
            </div>

            <!-- Dynamic Live Rupee Recalculation Box -->
            <div class="price-calculation-box">
              <div class="d-flex justify-content-between align-items-center mb-2">
                <span class="text-secondary small">Formula Calculation:</span>
                <span class="badge bg-light text-secondary border" id="formulaText">
                  ₹<%=String.format("%.0f", item.getPrice())%> × <%=item.getQuantity()%> item(s)
                </span>
              </div>
              <div class="d-flex justify-content-between align-items-center">
                <div>
                  <span class="small text-secondary d-block">Updated Subtotal:</span>
                  <strong class="text-dark fs-5" id="qtyCountLabel"><%=item.getQuantity()%> item(s)</strong>
                </div>
                <div class="text-end">
                  <span class="small text-secondary d-block">Recalculated Rupee Amount:</span>
                  <div class="live-amount-highlight" id="liveAmountDisplay">
                    ₹<%=String.format("%.2f", item.getLineTotal())%>
                  </div>
                </div>
              </div>
            </div>

            <!-- Bootstrap Buttons -->
            <div class="d-flex flex-column flex-sm-row gap-3 pt-2">
              <button type="submit" class="btn btn-primary btn-lg rounded-pill px-5 fw-bold shadow flex-grow-1">
                <i class="bi bi-check2-circle me-2"></i> Update Cart
              </button>
              <a href="CartServlet" class="btn btn-outline-secondary btn-lg rounded-pill px-4">
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

<script>
const unitPrice = <%=item.getPrice()%>;

function changeQty(delta) {
  const input = document.getElementById('qtyInput');
  let current = parseInt(input.value) || 1;
  let next = current + delta;
  if (next < 1) next = 1;
  if (next > 20) next = 20;
  input.value = next;
  onQtyChange();
}

function setQty(val) {
  document.getElementById('qtyInput').value = val;
  onQtyChange();
}

function onQtyChange() {
  const input = document.getElementById('qtyInput');
  let qty = parseInt(input.value);
  if (isNaN(qty) || qty < 1) {
    qty = 1;
  } else if (qty > 20) {
    qty = 20;
  }
  
  // Calculate incremented amount
  const total = (qty * unitPrice).toFixed(2);
  
  // Update live elements
  const display = document.getElementById('liveAmountDisplay');
  display.textContent = '₹' + total;
  
  document.getElementById('formulaText').textContent = '₹' + unitPrice.toFixed(0) + ' × ' + qty + ' item' + (qty > 1 ? 's' : '');
  document.getElementById('qtyCountLabel').textContent = qty + ' item' + (qty > 1 ? 's' : '');

  // Subtle highlight animation
  display.style.transform = 'scale(1.08)';
  setTimeout(() => {
    display.style.transform = 'scale(1)';
  }, 150);
}
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
