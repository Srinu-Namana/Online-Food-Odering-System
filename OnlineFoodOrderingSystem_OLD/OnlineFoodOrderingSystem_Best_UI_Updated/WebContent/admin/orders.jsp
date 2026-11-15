<%@ page contentType="text/html;charset=UTF-8"
	import="java.util.*,com.food.model.*,com.food.controller.ServletUtil,com.food.util.HtmlUtil"%>
<%
if (!ServletUtil.requireAdmin(request, response))
	return;
%>
<%
List<Order> orders = (List<Order>) request.getAttribute("orders");
if (orders == null)
	orders = Collections.emptyList();
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Orders | Victo Food House</title>
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
				<a href="${pageContext.request.contextPath}/admin/food-list.jsp"
					class="nav-link">Food</a><a
					href="${pageContext.request.contextPath}/admin/admin-dashboard.jsp"
					class="nav-link">Dashboard</a><a
					href="${pageContext.request.contextPath}/LogoutServlet"
					class="btn btn-outline-secondary rounded-pill">Logout</a>
			</div>
		</div>
	</nav>
	<section class="page-header">
		<div class="container">
			<h1 class="fw-bold">Customer Orders</h1>
			<p class="text-secondary">Review orders and update their status.</p>
		</div>
	</section>
	<section class="py-5">
		<div class="container">
			<%
			if (orders.isEmpty()) {
			%><div class="empty-state">
				<h4>No orders found</h4>
			</div>
			<%
			} else {
			for (Order o : orders) {
			%><div class="table-card p-4 mb-4">
				<div class="d-flex flex-wrap justify-content-between gap-3">
					<div>
						<h5 class="fw-bold mb-1">
							Order #<%=o.getOrderId()%></h5>
						<div class="small text-secondary">
							Customer:
							<%=HtmlUtil.e(o.getUserName())%>
							·
							<%=HtmlUtil.e(o.getOrderDate())%></div>
						<div class="small text-secondary mt-1">
							Delivery:
							<%=HtmlUtil.e(o.getDeliveryAddress())%></div>
					</div>
					<div class="text-end">
						<strong class="food-price">₹<%=String.format("%.2f", o.getTotalAmount())%></strong>
						<form
							action="${pageContext.request.contextPath}/UpdateOrderStatusServlet"
							method="post" class="d-flex gap-2 mt-2">
							<input type="hidden" name="orderId" value="<%=o.getOrderId()%>"><select
								name="status" class="form-select form-select-sm">
								<%
								String[] st = { "PLACED", "CONFIRMED", "PREPARING", "OUT_FOR_DELIVERY", "DELIVERED", "CANCELLED" };
								for (String x : st) {
								%><option
									value="<%=x%>" <%=x.equals(o.getStatus()) ? "selected" : ""%>><%=x.replace('_', ' ')%></option>
								<%}%>
							</select>
							<button class="btn btn-sm btn-primary">Update</button>
						</form>
					</div>
				</div>
				<hr>
				<div class="row g-2">
					<%
					for (OrderItem i : o.getItems()) {
					%><div class="col-md-6">
						<span class="fw-semibold"><%=HtmlUtil.e(i.getFoodName())%></span>
						×
						<%=i.getQuantity()%>
						— ₹<%=String.format("%.2f", i.getLineTotal())%></div>
					<%}%>
				</div>
			</div>
			<%
			}
			}
			%>
		</div>
	</section>
	<footer>
		<div class="container py-4">Victo Food House · Admin Panel</div>
	</footer>
</body>
</html>