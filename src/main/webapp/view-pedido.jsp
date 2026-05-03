<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="com.svalero.tienda.model.Pedido" %>
<%@ page import="com.svalero.tienda.model.Usuario" %>

<%@ include file="includes/header.jsp" %>

<%
  if (usuarioSesion == null || !"admin".equals(usuarioSesion.getRol())) {
    response.sendRedirect("index.jsp");
    return;
  }

  Pedido pedido = (Pedido) request.getAttribute("pedido");
%>

<main class="container py-5">

  <% if (pedido != null) { %>

  <div class="card shadow-sm">

    <div class="card-body">

      <h1 class="fw-bold mb-3">
        Pedido <%= pedido.getCodigo() %>
      </h1>

      <p class="mb-2">
        <strong>Total:</strong>
        <%= pedido.getTotal() %> €
      </p>

      <p class="mb-2">
        <strong>Cantidad de artículos:</strong>
        <%= pedido.getCantidadArticulos() %>
      </p>

      <p class="mb-2">
        <strong>Fecha del pedido:</strong>
        <%= pedido.getFechaPedido() %>
      </p>

      <p class="mb-2">
        <strong>ID usuario:</strong>
        <%= pedido.getIdUsuario() %>
      </p>

      <p class="mb-0">
        <strong>Estado:</strong>
        <span class="<%= pedido.isPagado() ? "text-success" : "text-danger" %>">
                    <%= pedido.isPagado() ? "Pagado" : "Pendiente" %>
                </span>
      </p>

    </div>

    <div class="card-footer bg-white border-0 d-flex gap-2">

      <a href="pedidos" class="btn btn-secondary">
        Volver
      </a>

      <a href="edit-pedido.jsp?id=<%= pedido.getIdPedido() %>"
         class="btn btn-outline-primary">
        Editar
      </a>

      <a href="remove-pedido?id=<%= pedido.getIdPedido() %>"
         class="btn btn-danger"
         onclick="return confirm('¿Seguro que quieres eliminar este pedido?')">
        Eliminar
      </a>

    </div>

  </div>

  <% } else { %>

  <div class="alert alert-warning">
    No se ha encontrado el pedido solicitado.
  </div>

  <a href="pedidos" class="btn btn-secondary">
    Volver a pedidos
  </a>

  <% } %>

</main>

<%@ include file="includes/footer.jsp" %>