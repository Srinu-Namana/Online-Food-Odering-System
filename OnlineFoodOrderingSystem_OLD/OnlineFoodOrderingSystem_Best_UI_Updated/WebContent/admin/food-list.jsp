<%@ page contentType="text/html;charset=UTF-8"
	import="java.util.*,com.food.model.FoodItem,com.food.dao.FoodItemDAO,com.food.controller.ServletUtil,com.food.util.HtmlUtil"%>
<%
if (!ServletUtil.requireAdmin(request, response))
	return;
%>
<%
List<FoodItem> foods;
try {
	foods = new FoodItemDAO().getAll(false);
} catch (Exception e) {
	throw new RuntimeException(e);
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Manage Food | Victo Food House</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="../css/style.css" rel="stylesheet">
</head>
<body>
	<nav class="navbar bg-white border-bottom">
		<div class="container py-2">
			<a class="navbar-brand fw-bold"
				href="${pageContext.request.contextPath}/admin/admin-dashboard.jsp">Victo<span
				class="brand-dot">.</span></a>
			<div class="d-flex gap-3">
				<a class="nav-link"
					href="${pageContext.request.contextPath}/admin/admin-dashboard.jsp">Dashboard</a><a
					class="nav-link"
					href="${pageContext.request.contextPath}/admin/AdminOrderServlet">Orders</a><a
					class="btn btn-outline-secondary rounded-pill"
					href="${pageContext.request.contextPath}/LogoutServlet">Logout</a>
			</div>
		</div>
	</nav>
	<section class="page-header">
		<div
			class="container d-flex flex-wrap justify-content-between align-items-center gap-3">
			<div>
				<h1 class="fw-bold">Food Items</h1>
				<p class="text-secondary mb-0">Live menu data from MySQL.</p>
			</div>
			<a href="${pageContext.request.contextPath}/admin/add-food.jsp"
				class="btn btn-primary rounded-pill">+ Add Food</a>
		</div>
	</section>
	<section class="py-5">
		<div class="container">
			<%
			if (request.getParameter("saved") != null) {
			%><div class="alert alert-success">Food item added
				successfully.</div>
			<%
			}
			if (request.getParameter("updated") != null) {
			%><div class="alert alert-success">Food item updated
				successfully.</div>
			<%
			}
			if (request.getParameter("deleted") != null) {
			%><div class="alert alert-success">Food item deleted
				successfully.</div>
			<%
			}
			if (request.getParameter("disabled") != null) {
			%><div class="alert alert-warning">Food item is linked to
				existing records, so it was marked unavailable instead of being
				deleted.</div>
			<%
			}
			if (request.getParameter("error") != null) {
			%><div class="alert alert-danger">The requested food operation
				could not be completed.</div>
			<%}%><div class="table-responsive table-card">
				<table class="table table-hover align-middle mb-0">
					<thead class="table-light">
						<tr>
							<th>ID</th>
							<th>Food</th>
							<th>Category</th>
							<th>Price</th>
							<th>Available</th>
							<th>Actions</th>
						</tr>
					</thead>
					<tbody>
						<%
						for (FoodItem f : foods) {
						%><tr>
							<td><%=f.getFoodId()%></td>
							<td class="fw-semibold"><%=HtmlUtil.e(f.getFoodName())%></td>
							<td><%=HtmlUtil.e(f.getCategory())%></td>
							<td>₹<%=String.format("%.2f", f.getPrice())%></td>
							<td><span
								class="badge <%=f.isAvailability() ? "text-bg-success" : "text-bg-secondary"%>"><%=f.isAvailability() ? "Available" : "Unavailable"%></span></td>
							<td><div class="d-flex gap-1">
									<a href="update-food.jsp?id=<%=f.getFoodId()%>"
										class="btn btn-sm btn-outline-primary">Edit</a>
									<form
										action="${pageContext.request.contextPath}/DeleteFoodServlet"
										method="post">
										<input type="hidden" name="foodId" value="<%=f.getFoodId()%>">
										<button class="btn btn-sm btn-outline-danger">Delete</button>
									</form>
								</div></td>
						</tr>
						<%}%>
					</tbody>
				</table>
			</div>
		</div>
	</section>
	<footer>
		<div class="container py-4">Victo Food House · Admin Panel</div>
	</footer>
</body>
</html>