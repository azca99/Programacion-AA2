<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="com.svalero.tienda.model.Usuario" %>

<%@ include file="includes/header.jsp" %>

<%
  Usuario usuario = (Usuario) request.getAttribute("usuario");

  // Cliente no puede acceder a lista de usuarios
  if (usuarioSesion == null || !"admin".equals(usuarioSesion.getRol())) {
    response.sendRedirect("index.jsp");
    return;
  }
%>

<main class="container py-5">

  <% if (usuario != null) { %>

  <div class="card shadow-sm">

    <div class="card-body">

      <h1 class="fw-bold mb-3">
        <%= usuario.getNombre() %>
      </h1>

      <p class="mb-2">
        <strong>Email:</strong>
        <%= usuario.getEmail() %>
      </p>

      <p class="mb-2">
        <strong>Teléfono:</strong>
        <%= usuario.getTelefono() %>
      </p>

      <p class="mb-2">
        <strong>Saldo:</strong>
        <%= usuario.getSaldo() %> €
      </p>

      <p class="mb-2">
        <strong>Fecha de registro:</strong>
        <%= usuario.getFechaRegistro() %>
      </p>

      <p class="mb-2">
        <strong>Rol:</strong>
        <%= usuario.getRol() %>
      </p>

      <p class="mb-0">
        <strong>Estado:</strong>
        <span class="<%= usuario.isActivo() ? "text-success" : "text-danger" %>">
                    <%= usuario.isActivo() ? "Activo" : "Inactivo" %>
                </span>
      </p>

    </div>

    <div class="card-footer bg-white border-0 d-flex gap-2">

      <a href="usuarios" class="btn btn-secondary">
        Volver
      </a>

      <a href="edit-usuario.jsp?id=<%= usuario.getIdUsuario() %>"
         class="btn btn-outline-primary">
        Editar
      </a>

      <a href="remove-usuario?id=<%= usuario.getIdUsuario() %>"
         class="btn btn-danger"
         onclick="return confirm('¿Seguro que quieres eliminar este usuario?')">
        Eliminar
      </a>

    </div>

  </div>

  <% } else { %>

  <div class="alert alert-warning">
    No se ha encontrado el usuario solicitado.
  </div>

  <!-- Botones -->

  <a href="usuarios" class="btn btn-secondary">
    Volver a usuarios
  </a>

  <% } %>

</main>

<%@ include file="includes/footer.jsp" %>