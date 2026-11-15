<%@ page contentType="text/html;charset=UTF-8"
	import="java.util.*,com.food.model.*,com.food.dao.CartDAO,com.food.util.HtmlUtil"%>
<%
User currentUser = (User) session.getAttribute("user");
boolean loggedIn = currentUser != null;
int cartCount = 0;
if (loggedIn) {
	try {
		Cart c = new CartDAO().getCart(currentUser.getUserId());
		if (c != null && c.getItems() != null)
	cartCount = c.getItems().size();
	} catch (Exception ignored) {
	}
}

List<FoodItem> foods = (List<FoodItem>) request.getAttribute("foods");
if (foods == null)
	foods = Collections.emptyList();

String selected = request.getParameter("category");
if (selected == null || selected.trim().isEmpty())
	selected = "All";

String[] cats = { "All", "Biryani", "Starters", "Rice", "Noodles", "Burgers", "Pizza", "Desserts" };

Map<String, String> catImages = new HashMap<>();
catImages.put("All", "https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=100&auto=format&fit=crop&q=80");
catImages.put("Biryani",
		"https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=100&auto=format&fit=crop&q=80");
catImages.put("Starters", "https://upload.wikimedia.org/wikipedia/commons/d/d7/Chicken_65.jpg");
catImages.put("Rice", "https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=100&auto=format&fit=crop&q=80");
catImages.put("Noodles",
		"https://images.unsplash.com/photo-1585032226651-759b368d7246?w=100&auto=format&fit=crop&q=80");
catImages.put("Burgers",
		"https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=100&auto=format&fit=crop&q=80");
catImages.put("Pizza", "https://images.unsplash.com/photo-1513104890138-7c749659a591?w=100&auto=format&fit=crop&q=80");
catImages.put("Desserts",
		"https://images.unsplash.com/photo-1606313564200-e75d5e30476c?w=100&auto=format&fit=crop&q=80");

String defaultFallback = "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=600&auto=format&fit=crop&q=80";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title><%=selected%> Menu | Victo Food House</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
	rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
</head>
<body>

	<!-- Navigation Bar -->
	<nav class="navbar navbar-expand-lg main-navbar sticky-top">
		<div class="container py-2">
			<a class="navbar-brand brand-title" href="index.jsp">Victo<span
				class="brand-dot">.</span></a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navContent">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navContent">
				<ul class="navbar-nav ms-auto align-items-lg-center gap-lg-2">
					<li class="nav-item"><a class="nav-link" href="index.jsp"><i
							class="bi bi-house-door me-1"></i>Home</a></li>
					<li class="nav-item"><a class="nav-link active"
						href="FoodListServlet"><i class="bi bi-menu-button-wide me-1"></i>Menu</a></li>
					<li class="nav-item"><a class="nav-link position-relative"
						href="CartServlet"> <i class="bi bi-bag me-1"></i>Cart <%
 if (cartCount > 0) {
 %>
							<span class="badge bg-danger rounded-pill ms-1"><%=cartCount%></span>
							<%
							}
							%>
					</a></li>
					<%
					if (loggedIn) {
					%>
					<li class="nav-item"><a class="nav-link"
						href="OrderHistoryServlet"><i class="bi bi-clock-history me-1"></i>My
							Orders</a></li>
					<li class="nav-item ms-lg-2"><span class="user-badge"><i
							class="bi bi-person-circle text-primary"></i> Hi, <%=HtmlUtil.e(currentUser.getName())%></span>
					</li>
					<li class="nav-item ms-lg-2">
						<!-- ONLY Logout shown when user is logged in --> <a
						class="btn-logout" href="LogoutServlet"><i
							class="bi bi-box-arrow-right me-1"></i> Logout</a>
					</li>
					<%
					} else {
					%>
					<li class="nav-item ms-lg-2"><a
						class="btn btn-outline-secondary rounded-pill px-3"
						href="register.jsp">Sign Up</a></li>
					<li class="nav-item ms-lg-2"><a
						class="btn btn-primary rounded-pill px-4 fw-bold"
						href="index.jsp#loginSection">Login</a></li>
					<%
					}
					%>
				</ul>
			</div>
		</div>
	</nav>

	<!-- Restaurant Top Banner -->
	<section class="bg-white border-bottom py-4">
		<div class="container">
			<div
				class="d-flex flex-wrap align-items-center justify-content-between gap-3">
				<div class="d-flex align-items-center gap-3">
					<img
						src="https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=200&auto=format&fit=crop&q=80"
						class="restaurant-avatar" alt="Victo Food House"
						onerror="this.src='<%=defaultFallback%>'">
					<div>
						<div class="d-flex align-items-center gap-2 mb-1">
							<h3 class="fw-bold mb-0">Victo Food House</h3>
							<span class="status-badge-open">OPEN NOW</span>
						</div>
						<p class="text-secondary small mb-1">Authentic Biryani,
							Sizzling Starters, Fried Rice, Noodles, Gourmet Burgers, Pizza &
							Desserts</p>
						<div class="d-flex align-items-center gap-3 small text-secondary">
							<span class="rating-badge"><i class="bi bi-star-fill"></i>
								4.5</span> <span><i class="bi bi-clock me-1"></i>30 mins
								delivery</span> <span><i class="bi bi-geo-alt me-1"></i>Bhimavaram</span>
						</div>
					</div>
				</div>
				<div>
					<a href="CartServlet"
						class="btn btn-primary rounded-pill px-4 fw-bold"> <i
						class="bi bi-bag me-1"></i> View Cart (<%=cartCount%>)
					</a>
				</div>
			</div>
		</div>
	</section>

	<!-- Category Horizontal Scroll Bar -->
	<section class="category-scroll-bar">
		<div class="container">
			<div class="category-track">
				<%
				for (String cat : cats) {
					boolean isActive = cat.equalsIgnoreCase(selected);
					String cImg = catImages.getOrDefault(cat, defaultFallback);
				%>
				<a class="category-pill-btn <%=isActive ? "active" : ""%>"
					href="FoodListServlet?category=<%=java.net.URLEncoder.encode(cat, "UTF-8")%>">
					<img src="<%=cImg%>" alt="<%=cat%>"
					onerror="this.src='<%=defaultFallback%>'"> <span><%=cat%></span>
				</a>
				<%
				}
				%>
			</div>
		</div>
	</section>

	<!-- Menu Items Grid -->
	<section class="py-5">
		<div class="container">
			<div class="d-flex justify-content-between align-items-center mb-4">
				<div>
					<span
						class="text-uppercase fw-bold text-primary small letter-spacing-1">EXPLORE
						MENU</span>
					<h2 class="fw-bold mb-0"><%=selected%>
						Dishes <span class="text-secondary fs-5 fw-normal">(<%=foods.size()%>
							items)
						</span>
					</h2>
				</div>
				<span class="small text-secondary"><i
					class="bi bi-shield-check text-success me-1"></i>All prices in
					Indian Rupees (₹)</span>
			</div>

			<%
			if ("cart".equals(request.getParameter("error"))) {
			%>
			<div class="alert alert-danger alert-dismissible fade show"
				role="alert">
				<i class="bi bi-exclamation-triangle-fill me-2"></i>Could not add
				item to cart. Please make sure you are logged in.
				<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
			</div>
			<%
			}
			%>

			<%
			if (foods.isEmpty()) {
			%>
			<div class="text-center py-5 bg-white rounded-4 border p-5">
				<i class="bi bi-emoji-neutral fs-1 text-muted"></i>
				<h4 class="mt-3 fw-bold">
					No food items found in "<%=selected%>"
				</h4>
				<p class="text-secondary">Try selecting another category from
					the scroll bar above.</p>
				<a href="FoodListServlet"
					class="btn btn-outline-primary rounded-pill px-4 fw-bold">View
					All Dishes</a>
			</div>
			<%
			} else {
			%>
			<div class="row g-4">
				<%
				for (FoodItem f : foods) {
					String img = f.getImage();
					if (img == null || img.trim().isEmpty()) {
						img = defaultFallback;
					}
					boolean isVeg = !f.getFoodName().toLowerCase().contains("chicken")
					&& !f.getFoodName().toLowerCase().contains("mutton");
				%>
				<div class="col-12 col-lg-6">
					<div class="swiggy-card">
						<!-- Left Info Side -->
						<div class="swiggy-card-info">
							<div>
								<%
								if (isVeg) {
								%>
								<span class="veg-icon" title="Pure Veg"></span>
								<%
								} else {
								%>
								<span class="nonveg-icon" title="Non-Veg"></span>
								<%
								}
								%>
								<h4 class="dish-name"><%=HtmlUtil.e(f.getFoodName())%></h4>
								<div class="d-flex align-items-center gap-2 mb-1">
									<span
										class="badge bg-success-subtle text-success border border-success-subtle rounded-pill px-2 py-1 small">
										<i class="bi bi-star-fill text-warning me-1"></i>4.5
									</span> <span class="text-secondary small">(120+ ratings)</span> <span
										class="badge bg-light text-secondary border rounded-pill"><%=HtmlUtil.e(f.getCategory())%></span>
								</div>
							</div>

							<!-- Rupee Price with generous margin -->
							<div class="rupee-price-box">
								<span class="rupee-sign">₹</span> <span class="rupee-val"><%=String.format("%.0f", f.getPrice())%></span>
								<span class="rupee-unit">per item</span>
							</div>

							<p class="dish-description"><%=HtmlUtil.e(f.getDescription())%></p>
						</div>

						<!-- Right Media & Action Side -->
						<div class="swiggy-card-media">
							<img src="<%=img%>" class="swiggy-food-img"
								alt="<%=HtmlUtil.e(f.getFoodName())%>"
								onerror="this.src='<%=defaultFallback%>'">

							<div class="card-action-bar">
								<form action="AddToCartServlet" method="post" class="w-100">
									<input type="hidden" name="foodId" value="<%=f.getFoodId()%>">
									<select name="quantity" class="form-select card-qty-select"
										title="Choose quantity">
										<%
										for (int q = 1; q <= 10; q++) {
										%>
										<option value="<%=q%>"><%=q%>
											<%=q == 1 ? "item" : "items"%></option>
										<%
										}
										%>
									</select>
									<button type="submit" class="btn-add-food">
										<i class="bi bi-plus-lg"></i> ADD
									</button>
								</form>
							</div>
						</div>
					</div>
				</div>
				<%
				}
				%>
			</div>
			<%
			}
			%>
		</div>
	</section>

	<footer class="site-footer">
		<div
			class="container py-4 d-flex flex-wrap justify-content-between align-items-center gap-3">
			<div>
				<h5 class="fw-bold text-white mb-1">Victo Food House</h5>
				<span class="small">Fresh food. Simple ordering. Delivered
					with care.</span>
			</div>
			<div class="small text-secondary">Bhimavaram, Andhra Pradesh ·
				Phone: 9876543210</div>
		</div>
	</footer>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
