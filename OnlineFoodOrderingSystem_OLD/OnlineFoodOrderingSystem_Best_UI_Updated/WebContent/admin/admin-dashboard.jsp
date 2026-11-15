<%@ page contentType="text/html;charset=UTF-8"%><%@ page
	import="com.food.controller.ServletUtil"%>
<%
if (!ServletUtil.requireAdmin(request, response))
	return;
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Admin Dashboard | Victo Food House</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="../css/style.css" rel="stylesheet">
</head>
<body>
	<nav class="navbar bg-white border-bottom">
		<div class="container py-2">
			<a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/index.jsp">Victo<span
				class="brand-dot">.</span></a>
			<div class="d-flex gap-3 align-items-center">
				<span class="small text-secondary">Admin Panel</span><a
					class="nav-link" href="${pageContext.request.contextPath}/admin/food-list.jsp">Food</a><a class="nav-link"
					href="${pageContext.request.contextPath}/admin/AdminOrderServlet">Orders</a><a
					class="btn btn-outline-secondary rounded-pill"
					href="${pageContext.request.contextPath}/LogoutServlet">Logout</a>
			</div>
		</div>
	</nav>
	<section class="page-header">
		<div class="container">
			<p class="text-uppercase small fw-bold text-secondary mb-1">Administration</p>
			<h1 class="fw-bold">Dashboard</h1>
			<p class="text-secondary">Manage menu items and customer orders.</p>
		</div>
	</section>
	<section class="py-5">
		<div class="container">
			<div class="row g-4">
				<div class="col-md-6">
					<div class="dashboard-card h-100">
						<i class="bi bi-egg-fried fs-2 text-warning"></i>
						<h4 class="fw-bold mt-3">Food Management</h4>
						<p class="text-secondary">Add, edit, enable/disable and delete
							menu items.</p>
						<a href="${pageContext.request.contextPath}/admin/food-list.jsp" class="btn btn-primary rounded-pill">Manage
							Food</a>
					</div>
				</div>
				<div class="col-md-6">
					<div class="dashboard-card h-100">
						<i class="bi bi-receipt fs-2 text-primary"></i>
						<h4 class="fw-bold mt-3">Customer Orders</h4>
						<p class="text-secondary">View all orders and update their
							status.</p>
						<a href="${pageContext.request.contextPath}/admin/AdminOrderServlet"
							class="btn btn-outline-primary rounded-pill">Manage Orders</a>
					</div>
				</div>
			</div>
		</div>
	</section>
	<footer>
		<div class="container py-4">Victo Food House · Admin Panel</div>
	</footer>
</body>
</html>