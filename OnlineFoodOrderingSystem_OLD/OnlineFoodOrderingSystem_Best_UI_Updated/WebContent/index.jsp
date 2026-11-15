<%@ page contentType="text/html;charset=UTF-8"
	import="java.util.*,com.food.model.*,com.food.dao.*,com.food.util.HtmlUtil"%>
<%
User currentUser = (User) session.getAttribute("user");
boolean loggedIn = currentUser != null;
int cartCount = 0;
List<FoodItem> foodList = Collections.emptyList();
try {
	foodList = new FoodItemDAO().getAll(true);
	if (loggedIn) {
		Cart c = new CartDAO().getCart(currentUser.getUserId());
		if (c != null && c.getItems() != null) {
	cartCount = c.getItems().size();
		}
	}
} catch (Exception ignored) {
}

String defaultFallback = "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=600&auto=format&fit=crop&q=80";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title><%=loggedIn ? "Home | Victo Food House" : "Login | Victo Food House"%></title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
	rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
</head>
<body>

	<%
	if (!loggedIn) {
	%>
	<!-- ========================================================= -->
	<!-- 1. NOT LOGGED IN: Opening / Landing Page with Login Box -->
	<!-- ========================================================= -->
	<nav class="navbar navbar-expand-lg main-navbar sticky-top">
		<div class="container py-2">
			<a class="navbar-brand brand-title" href="index.jsp">Victo<span
				class="brand-dot">.</span></a>
			<div class="ms-auto d-flex align-items-center gap-2">
				<a href="FoodListServlet" class="nav-link"><i
					class="bi bi-compass me-1"></i>Explore Menu</a> <a href="register.jsp"
					class="btn btn-outline-secondary rounded-pill px-3 fw-semibold">Sign
					Up</a> <a href="#loginSection"
					class="btn btn-primary rounded-pill px-4 fw-bold">Login</a>
			</div>
		</div>
	</nav>

	<section class="hero-landing">
		<div class="container hero-content">
			<div class="row align-items-center g-5 min-vh-75">
				<div class="col-lg-7">
					<span class="hero-pill"><i class="bi bi-fire"></i> VICTO
						FOOD HOUSE · BHIMAVARAM</span>
					<h1 class="hero-headline">
						Delicious food,<br>
						<span>delivered to your door.</span>
					</h1>
					<p class="hero-desc">Craving hot Biryani, crispy Starters,
						wok-tossed Noodles, or loaded Pizzas? Victo brings you
						restaurant-quality food delivered fast and fresh.</p>

					<div class="hero-stats">
						<div class="stat-chip">
							<strong>30 Mins</strong> <span>Fast Delivery</span>
						</div>
						<div class="stat-chip">
							<strong>★ 4.5 / 5</strong> <span>Customer Rating</span>
						</div>
						<div class="stat-chip">
							<strong>100% Fresh</strong> <span>Hygienic Cooking</span>
						</div>
					</div>
				</div>

				<div class="col-lg-5" id="loginSection">
					<div class="auth-box">
						<div class="text-center mb-3">
							<div class="auth-icon-circle">
								<i class="bi bi-person-fill-lock"></i>
							</div>
							<h3 class="fw-bold mb-1">Customer Login</h3>
							<p class="text-secondary small mb-0">Enter your credentials
								to place your order</p>
						</div>

						<%
						String error = request.getParameter("error");
						%>
						<%
						if ("invalid".equals(error)) {
						%><div
							class="alert alert-danger py-2 small">
							<i class="bi bi-exclamation-triangle-fill me-1"></i> Invalid
							email or password.
						</div>
						<%
						}
						%>
						<%
						if ("required".equals(error)) {
						%><div
							class="alert alert-warning py-2 small">
							<i class="bi bi-info-circle me-1"></i> Please enter email and
							password.
						</div>
						<%
						}
						%>
						<%
						if ("db".equals(error)) {
						%><div
							class="alert alert-danger py-2 small">
							<i class="bi bi-database-x me-1"></i> Database connection failed.
							Verify MySQL.
						</div>
						<%
						}
						%>
						<%
						if ("server".equals(error)) {
						%><div
							class="alert alert-danger py-2 small">Server error
							occurred. Please try again.</div>
						<%
						}
						%>
						<%
						if ("1".equals(request.getParameter("logout"))) {
						%><div
							class="alert alert-success py-2 small">
							<i class="bi bi-check-circle me-1"></i> Logged out successfully.
						</div>
						<%
						}
						%>

						<form action="${pageContext.request.contextPath}/LoginServlet"
							method="post">
							<div class="mb-3">
								<label class="form-label fw-semibold small">Email
									Address</label>
								<div class="input-group">
									<span class="input-group-text bg-light text-secondary"><i
										class="bi bi-envelope"></i></span> <input type="email" name="email"
										class="form-control" placeholder="sreenu@gmail.com" required>
								</div>
							</div>
							<div class="mb-3">
								<label class="form-label fw-semibold small">Password</label>
								<div class="input-group">
									<span class="input-group-text bg-light text-secondary"><i
										class="bi bi-lock"></i></span> <input type="password" name="password"
										class="form-control" placeholder="••••••••" required>
								</div>
							</div>
							<button type="submit"
								class="btn btn-primary btn-lg w-100 rounded-3 fw-bold mt-2">
								Login to Order <i class="bi bi-arrow-right ms-1"></i>
							</button>
						</form>

						<div class="demo-account-hint mt-3">
							<span class="text-muted small d-block">Demo Customer
								Login:</span> <strong class="text-dark">sreenu@gmail.com</strong> <span
								class="text-muted">/</span> <strong class="text-dark">12345</strong>
						</div>

						<div class="text-center mt-3">
							<span class="text-secondary small">Don't have an account?</span>
							<a href="register.jsp"
								class="fw-bold text-decoration-none text-primary ms-1">Create
								Account</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- Category Showcase on Landing -->
	<section class="py-5 bg-white">
		<div class="container">
			<div class="text-center mb-4">
				<span
					class="text-uppercase fw-bold text-primary small letter-spacing-1">Taste
					The Best</span>
				<h2 class="fw-bold">What Are You Craving Today?</h2>
				<p class="text-secondary">Select your favorite food category to
					explore our mouthwatering menu</p>
			</div>

			<div class="row g-3">
				<div class="col-6 col-md-3">
					<a href="FoodListServlet?category=Biryani"
						class="home-category-card"> <img
						src="https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=300&auto=format&fit=crop&q=80"
						class="home-category-thumb" alt="Biryani"
						onerror="this.src='<%=defaultFallback%>'">
						<div class="home-category-title">Biryani</div> <span
						class="home-category-count">3 varieties</span>
					</a>
				</div>
				<div class="col-6 col-md-3">
					<a href="FoodListServlet?category=Starters"
						class="home-category-card"> <img
						src="https://upload.wikimedia.org/wikipedia/commons/d/d7/Chicken_65.jpg"
						class="home-category-thumb" alt="Starters"
						onerror="this.src='<%=defaultFallback%>'">
						<div class="home-category-title">Starters</div> <span
						class="home-category-count">3 varieties</span>
					</a>
				</div>
				<div class="col-6 col-md-3">
					<a href="FoodListServlet?category=Rice" class="home-category-card">
						<img
						src="https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=300&auto=format&fit=crop&q=80"
						class="home-category-thumb" alt="Rice"
						onerror="this.src='<%=defaultFallback%>'">
						<div class="home-category-title">Fried Rice</div> <span
						class="home-category-count">2 varieties</span>
					</a>
				</div>
				<div class="col-6 col-md-3">
					<a href="FoodListServlet?category=Noodles"
						class="home-category-card"> <img
						src="https://images.unsplash.com/photo-1585032226651-759b368d7246?w=300&auto=format&fit=crop&q=80"
						class="home-category-thumb" alt="Noodles"
						onerror="this.src='<%=defaultFallback%>'">
						<div class="home-category-title">Noodles</div> <span
						class="home-category-count">Classic Noodles</span>
					</a>
				</div>
				<div class="col-6 col-md-3">
					<a href="FoodListServlet?category=Burgers"
						class="home-category-card"> <img
						src="https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=300&auto=format&fit=crop&q=80"
						class="home-category-thumb" alt="Burgers"
						onerror="this.src='<%=defaultFallback%>'">
						<div class="home-category-title">Burgers</div> <span
						class="home-category-count">2 varieties</span>
					</a>
				</div>
				<div class="col-6 col-md-3">
					<a href="FoodListServlet?category=Pizza" class="home-category-card">
						<img
						src="https://images.unsplash.com/photo-1513104890138-7c749659a591?w=300&auto=format&fit=crop&q=80"
						class="home-category-thumb" alt="Pizza"
						onerror="this.src='<%=defaultFallback%>'">
						<div class="home-category-title">Pizza</div> <span
						class="home-category-count">2 varieties</span>
					</a>
				</div>
				<div class="col-6 col-md-3">
					<a href="FoodListServlet?category=Desserts"
						class="home-category-card"> <img
						src="https://images.unsplash.com/photo-1606313564200-e75d5e30476c?w=300&auto=format&fit=crop&q=80"
						class="home-category-thumb" alt="Desserts"
						onerror="this.src='<%=defaultFallback%>'">
						<div class="home-category-title">Desserts</div> <span
						class="home-category-count">Sweet Treats</span>
					</a>
				</div>
				<div class="col-6 col-md-3">
					<a href="FoodListServlet" class="home-category-card bg-light">
						<img
						src="https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=300&auto=format&fit=crop&q=80"
						class="home-category-thumb" alt="All Menu"
						onerror="this.src='<%=defaultFallback%>'">
						<div class="home-category-title text-primary">All Menu</div> <span
						class="home-category-count">15+ Items</span>
					</a>
				</div>
			</div>
		</div>
	</section>

	<%
	} else {
	%>
	<!-- ========================================================= -->
	<!-- 2. LOGGED IN: Authenticated Home Page with ONLY Logout    -->
	<!-- ========================================================= -->
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
					<li class="nav-item"><a class="nav-link active"
						href="index.jsp"><i class="bi bi-house-door me-1"></i>Home</a></li>
					<li class="nav-item"><a class="nav-link"
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
					<li class="nav-item"><a class="nav-link"
						href="OrderHistoryServlet"><i class="bi bi-clock-history me-1"></i>My
							Orders</a></li>
					<li class="nav-item ms-lg-2"><span class="user-badge"><i
							class="bi bi-person-circle text-primary"></i> Hi, <%=HtmlUtil.e(currentUser.getName())%></span>
					</li>
					<li class="nav-item ms-lg-2">
						<!-- ONLY Logout is displayed in place of login --> <a
						class="btn-logout" href="LogoutServlet"><i
							class="bi bi-box-arrow-right me-1"></i> Logout</a>
					</li>
				</ul>
			</div>
		</div>
	</nav>

	<!-- Home Hero Section -->
	<section class="hero-landing py-5">
		<div class="container hero-content">
			<div class="row align-items-center">
				<div class="col-lg-8">
					<span class="hero-pill"><i class="bi bi-hand-thumbs-up"></i>
						WELCOME BACK, <%=currentUser.getName().toUpperCase()%></span>
					<h1 class="hero-headline">
						Fresh flavours,<br>
						<span>made to order.</span>
					</h1>
					<p class="hero-desc">Check out our handcrafted biryanis,
						sizzling starters, and fresh oven-baked pizzas ready for fast
						delivery to your address.</p>
					<div class="d-flex flex-wrap gap-2 mt-4">
						<a href="FoodListServlet"
							class="btn btn-primary btn-lg rounded-pill px-4 fw-bold shadow">Browse
							Menu <i class="bi bi-arrow-right ms-1"></i>
						</a> <a href="CartServlet"
							class="btn btn-light btn-lg rounded-pill px-4 fw-bold">View
							Cart (<%=cartCount%>)
						</a>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- Restaurant Showcase Strip -->
	<div class="container">
		<div
			class="restaurant-showcase d-flex flex-wrap align-items-center justify-content-between gap-3">
			<div class="d-flex align-items-center gap-3">
				<img
					src="https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=200&auto=format&fit=crop&q=80"
					class="restaurant-avatar" alt="Victo Food House"
					onerror="this.src='<%=defaultFallback%>'">
				<div>
					<div class="d-flex align-items-center gap-2 mb-1">
						<h4 class="fw-bold mb-0">Victo Food House</h4>
						<span class="status-badge-open">OPEN NOW</span>
					</div>
					<div class="text-secondary small">Biryani · North Indian ·
						Chinese · Fast Food · Desserts</div>
				</div>
			</div>
			<div class="d-flex align-items-center gap-3">
				<span class="rating-badge"><i class="bi bi-star-fill"></i>
					4.5</span> <span class="fw-semibold text-secondary small"><i
					class="bi bi-clock me-1"></i>30 mins</span> <span
					class="fw-semibold text-secondary small"><i
					class="bi bi-cash-stack me-1"></i>₹300 for two</span> <span
					class="fw-semibold text-secondary small d-none d-md-inline"><i
					class="bi bi-geo-alt me-1"></i>Bhimavaram</span>
			</div>
		</div>
	</div>

	<!-- Browse Categories Grid -->
	<section class="py-5">
		<div class="container">
			<div class="d-flex justify-content-between align-items-center mb-4">
				<div>
					<span
						class="text-uppercase fw-bold text-primary small letter-spacing-1">CATEGORIES</span>
					<h3 class="fw-bold mb-0">What are you craving?</h3>
				</div>
				<a href="FoodListServlet"
					class="fw-bold text-primary text-decoration-none">View full
					menu <i class="bi bi-arrow-right"></i>
				</a>
			</div>

			<div class="row g-3">
				<div class="col-6 col-md-3">
					<a href="FoodListServlet?category=Biryani"
						class="home-category-card"> <img
						src="https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=300&auto=format&fit=crop&q=80"
						class="home-category-thumb" alt="Biryani"
						onerror="this.src='<%=defaultFallback%>'">
						<div class="home-category-title">Biryani</div> <span
						class="home-category-count">3 varieties</span>
					</a>
				</div>
				<div class="col-6 col-md-3">
					<a href="FoodListServlet?category=Starters"
						class="home-category-card"> <img
						src="https://upload.wikimedia.org/wikipedia/commons/d/d7/Chicken_65.jpg"
						class="home-category-thumb" alt="Starters"
						onerror="this.src='<%=defaultFallback%>'">
						<div class="home-category-title">Starters</div> <span
						class="home-category-count">3 varieties</span>
					</a>
				</div>
				<div class="col-6 col-md-3">
					<a href="FoodListServlet?category=Rice" class="home-category-card">
						<img
						src="https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=300&auto=format&fit=crop&q=80"
						class="home-category-thumb" alt="Rice"
						onerror="this.src='<%=defaultFallback%>'">
						<div class="home-category-title">Fried Rice</div> <span
						class="home-category-count">2 varieties</span>
					</a>
				</div>
				<div class="col-6 col-md-3">
					<a href="FoodListServlet?category=Noodles"
						class="home-category-card"> <img
						src="https://images.unsplash.com/photo-1585032226651-759b368d7246?w=300&auto=format&fit=crop&q=80"
						class="home-category-thumb" alt="Noodles"
						onerror="this.src='<%=defaultFallback%>'">
						<div class="home-category-title">Noodles</div> <span
						class="home-category-count">1 variety</span>
					</a>
				</div>
				<div class="col-6 col-md-3">
					<a href="FoodListServlet?category=Burgers"
						class="home-category-card"> <img
						src="https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=300&auto=format&fit=crop&q=80"
						class="home-category-thumb" alt="Burgers"
						onerror="this.src='<%=defaultFallback%>'">
						<div class="home-category-title">Burgers</div> <span
						class="home-category-count">2 varieties</span>
					</a>
				</div>
				<div class="col-6 col-md-3">
					<a href="FoodListServlet?category=Pizza" class="home-category-card">
						<img
						src="https://images.unsplash.com/photo-1513104890138-7c749659a591?w=300&auto=format&fit=crop&q=80"
						class="home-category-thumb" alt="Pizza"
						onerror="this.src='<%=defaultFallback%>'">
						<div class="home-category-title">Pizza</div> <span
						class="home-category-count">2 varieties</span>
					</a>
				</div>
				<div class="col-6 col-md-3">
					<a href="FoodListServlet?category=Desserts"
						class="home-category-card"> <img
						src="https://images.unsplash.com/photo-1606313564200-e75d5e30476c?w=300&auto=format&fit=crop&q=80"
						class="home-category-thumb" alt="Desserts"
						onerror="this.src='<%=defaultFallback%>'">
						<div class="home-category-title">Desserts</div> <span
						class="home-category-count">Sweet Finish</span>
					</a>
				</div>
				<div class="col-6 col-md-3">
					<a href="FoodListServlet" class="home-category-card bg-light">
						<img
						src="https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=300&auto=format&fit=crop&q=80"
						class="home-category-thumb" alt="All Menu"
						onerror="this.src='<%=defaultFallback%>'">
						<div class="home-category-title text-primary">All Menu</div> <span
						class="home-category-count">15 Dishes</span>
					</a>
				</div>
			</div>
		</div>
	</section>

	<!-- ========================================================= -->
	<!-- 3. EXPLORE MENU ON HOME PAGE (SWIGGY/ZOMATO CARDS)        -->
	<!-- ========================================================= -->
	<section class="py-4 bg-white border-top border-bottom">
		<div class="container">
			<div class="d-flex justify-content-between align-items-center mb-4">
				<div>
					<span
						class="text-uppercase fw-bold text-primary small letter-spacing-1">HOT
						& POPULAR</span>
					<h3 class="fw-bold mb-0">Explore Top Dishes</h3>
					<p class="text-secondary small mb-0">Authentic recipes prepared
						fresh with prime ingredients</p>
				</div>
				<a href="FoodListServlet"
					class="btn btn-outline-primary btn-sm rounded-pill px-3 fw-bold">See
					All Menu <i class="bi bi-arrow-right"></i>
				</a>
			</div>

			<%
			if (foodList.isEmpty()) {
			%>
			<div class="text-center py-5 text-secondary">
				<i class="bi bi-egg-fried fs-1"></i>
				<h5 class="mt-2">No food items found</h5>
			</div>
			<%
			} else {
			%>
			<div class="row g-4">
				<%
				int limit = Math.min(foodList.size(), 8);
				for (int i = 0; i < limit; i++) {
					FoodItem f = foodList.get(i);
					String imgUrl = f.getImage();
					if (imgUrl == null || imgUrl.trim().isEmpty()) {
						imgUrl = defaultFallback;
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
								<h5 class="dish-name"><%=HtmlUtil.e(f.getFoodName())%></h5>
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
							<img src="<%=imgUrl%>" class="swiggy-food-img"
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

	<!-- Feature Badges -->
	<section class="py-5">
		<div class="container">
			<div class="row g-4">
				<div class="col-md-4">
					<div class="feature-card-clean">
						<i class="bi bi-speedometer2"></i>
						<h5 class="fw-bold">Lightning Fast Delivery</h5>
						<p class="text-secondary small mb-0">Hot food prepared on
							order and delivered within 30 minutes to ensure peak freshness.</p>
					</div>
				</div>
				<div class="col-md-4">
					<div class="feature-card-clean">
						<i class="bi bi-shield-check"></i>
						<h5 class="fw-bold">Hygienic & Certified</h5>
						<p class="text-secondary small mb-0">Every meal is cooked with
							premium ingredients in an inspected, hygienic kitchen.</p>
					</div>
				</div>
				<div class="col-md-4">
					<div class="feature-card-clean">
						<i class="bi bi-arrow-repeat"></i>
						<h5 class="fw-bold">Instant Cart Adjustments</h5>
						<p class="text-secondary small mb-0">Easily update quantities
							on the dedicated update page with dynamic rupee calculation.</p>
					</div>
				</div>
			</div>
		</div>
	</section>
	<%
	}
	%>

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
