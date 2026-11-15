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
<title>Add Food | Victo Food House</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="../css/style.css" rel="stylesheet">
</head>
<body>
	<nav class="navbar bg-white border-bottom">
		<div class="container py-2">
			<a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/admin/admin-dashboard.jsp">Victo<span
				class="brand-dot">.</span></a>
			<div class="d-flex gap-3">
				<a href="${pageContext.request.contextPath}/admin/food-list.jsp" class="nav-link">Food</a><a
					href="${pageContext.request.contextPath}/admin/AdminOrderServlet" class="nav-link">Orders</a><a
					href="${pageContext.request.contextPath}/LogoutServlet"
					class="btn btn-outline-secondary rounded-pill">Logout</a>
			</div>
		</div>
	</nav>
	<section class="page-header">
		<div class="container">
			<h1 class="fw-bold">Add Food Item</h1>
			<p class="text-secondary">Create a new menu item.</p>
		</div>
	</section>
	<section class="py-5">
		<div class="container">
			<div class="dashboard-card mx-auto" style="max-width: 850px">
				<%
				if (request.getParameter("error") != null) {
				%><div
					class="alert alert-danger">Please enter a valid name and
					price.</div>
				<%}%><form action="${pageContext.request.contextPath}/AddFoodServlet" method="post">
					<div class="row g-3">
						<div class="col-md-6">
							<label class="form-label">Food Name</label><input name="foodName"
								class="form-control" required>
						</div>
						<div class="col-md-6">
							<label class="form-label">Category</label><select name="category"
								class="form-select" required><option>Biryani</option>
								<option>Starters</option>
								<option>Rice</option>
								<option>Noodles</option>
								<option>Burgers</option>
								<option>Pizza</option>
								<option>Desserts</option></select>
						</div>
						<div class="col-md-6">
							<label class="form-label">Price</label><input type="number"
								name="price" min="1" step="0.01" class="form-control" required>
						</div>
						<div class="col-md-6">
							<label class="form-label">Image file name</label><input
								name="image" class="form-control" placeholder="food.jpg">
						</div>
						<div class="col-12">
							<label class="form-label">Description</label>
							<textarea name="description" rows="4" class="form-control"></textarea>
						</div>
						<div class="col-12 form-check ms-2">
							<input class="form-check-input" type="checkbox"
								name="availability" checked><label
								class="form-check-label">Available</label>
						</div>
					</div>
					<button class="btn btn-primary rounded-pill px-4 mt-4">Save
						Food</button>
					<a href="${pageContext.request.contextPath}/admin/food-list.jsp"
						class="btn btn-outline-secondary rounded-pill px-4 mt-4 ms-2">Cancel</a>
				</form>
			</div>
		</div>
	</section>
	<footer>
		<div class="container py-4">Victo Food House · Admin Panel</div>
	</footer>
</body>
</html>